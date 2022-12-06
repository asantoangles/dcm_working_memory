%% DCM - first-stage grand-averaged DCM for all subjects and trial types

disp('first-stage grand-averaged DCM');

% create output folders
if ~isfolder([path '/DCMs'])
    mkdir([path '/DCMs']);
end

for time_i = 1 % only baseline

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
        
    % input timecourses
    DCM.xY.Dfile            = [path '/timecourses/tc_allsubjects_alltrials.mat'];
    
    % number of trials
    load(DCM.xY.Dfile); % D
    DCM.xY.nt               = size(D.trials, 2);
    clear D;
                
    % options
    DCM.options.Tdcm(1)     = tp1;          % start of peri-stimulus time to be modelled
    DCM.options.Tdcm(2)     = tp2;          % end of peri-stimulus time to be modelled
    DCM.options.trials      = [1,2,3];
    DCM.xU.X                = [1;1;1];
    DCM.xU.name             = 'alltrials';
           
    % output name
    DCM.name                = [path '/DCMs/DCM_allsubjects_alltrials_' times{time_i} '.mat']; 

    % Invert DCM
    if ~isfile(DCM.name)
        DCM                 = spm_dcm_csd(DCM);
    end
    
end
