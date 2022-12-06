%% DCM - individual DCM estimation

disp('second-stage individual DCM estimation');

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

            % time windows       
            if strcmp(times{time_i},'early_delay')
                tp1 = 400;
                tp2 = 1200;
            elseif strcmp(times{time_i},'late_delay')
                tp1 = 1200;
                tp2 = 2000;
            elseif strcmp(times{time_i},'baseline')
                tp1 = -800;
                tp2 = -200;
            end

            % load DCM template (structure with default fields from SPM GUI)
            load([path '/timecourses/DCM_template.mat']); % DCM

            % load group priors
            priors                  = load([path '/DCMs/DCM_allsubjects_alltrials_baseline.mat']);

            % set group priors
            DCM.M.pE                = priors.DCM.Ep;
            pC                      = spm_unvec(diag(full(priors.DCM.Cp)),priors.DCM.M.pC);
            DCM.M.pC                = pC;
            clear priors pC;

            % input timecourses
            DCM.xY.Dfile            = [path '/timecourses/' subject '/tc_' trial '.mat'];

            % number of trials
            load(DCM.xY.Dfile); % D
            DCM.xY.nt               = size(D.trials, 2);
            clear D;

            % options
            DCM.options.Tdcm(1)     = tp1;          % start of peri-stimulus time to be modelled
            DCM.options.Tdcm(2)     = tp2;          % end of peri-stimulus time to be modelled
            DCM.options.trials      = 1;
            DCM.xU.X                = 1;
            DCM.xU.name             = time;

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
        

