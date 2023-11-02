%% DCM - individual DCM estimation

disp('DCM estimation');

%% individual DCMs for each subject and trial type

for sub_i = 1:length(subjects)
    
    subject = ['sub' num2str(subjects(sub_i))];
    
    if ~isfolder([path '/DCMs/' subject])
        mkdir([path '/DCMs/' subject]);
    end
    
    for trial_i = 1:length(trialtypes)
        
        trial = trialtypes{trial_i};
    
        for time_i = 1:length(times)

            time = times{time_i};

            % load DCM template (structure with default fields from SPM GUI)
            load([path '/timecourses/DCM_template.mat']); % DCM

            % input timecourses
            DCM.xY.Dfile            = [path '/timecourses/' subject '/tc_' trial '_' time '.mat'];

            % number of trials
            load(DCM.xY.Dfile); % D
            DCM.xY.nt               = size(D.trials, 2);
            clear D;

            % Parameters and options
            DCM.options.trials   = [1,2];           
            DCM.options.onset    = 60;              
            DCM.options.Tdcm(1)  = 1;               
            DCM.options.Tdcm(2)  = 800;             
            DCM.options.Nmodes   = 8;               
            DCM.options.h        = 1;               
            DCM.options.onset    = 60;              
            DCM.options.D        = 1;               
            DCM.options.Fdcm     = 2:100;      
        
            % Between trial effects
            DCM.xU.X = [-1; 1];        % delay > baseline;
            DCM.xU.name = {'baseline' times{time_i}};
    
            % feedforward connections
            DCM.A{1} = [0 0 0 1 1 1 1;
                        1 0 0 1 0 1 0;
                        1 0 0 0 1 0 1;
                        0 0 0 0 0 1 0;
                        0 0 0 0 0 0 1;
                        0 0 0 0 0 0 0;
                        0 0 0 0 0 0 0];
    
            % feedback connections
            DCM.A{2} = DCM.A{1}';
    
            % lateral connections (e.g., interhemispheric)
            DCM.A{3} = [0 0 0 0 0 0 0;
                        0 0 1 0 0 0 0;
                        0 1 0 0 0 0 0;
                        0 0 0 0 1 0 0;
                        0 0 0 1 0 0 0;
                        0 0 0 0 0 0 1;
                        0 0 0 0 0 1 0];
    
            % condition-specific modulations
            DCM.B{1} = DCM.A{1} + DCM.A{2} + DCM.A{3};

            % output name
            DCM.name                = [path '/DCMs/' subject '/DCM_' trial '_' time '.mat'];

            % Invert DCM
            if ~isfile(DCM.name)
                disp(['invert DCM ' subject ' ' trial ' ' time]);
                DCM                 = spm_dcm_csd(DCM);
            end

        end
    
    end
    
end
        