%% DCM - Parametric Empirical Bayes

disp('Parametric Empirical Bayes');

% settings PEB
field = {'A' 'H'};

%% Collate DCMs into a GCM file

disp('collate DCMs');

% create output folder
if ~isfolder([path '/PEB'])
    mkdir([path '/PEB']);
end

for trial_i = 1:length(trialtypes)

    trial = trialtypes{trial_i};

    for time_i = 1:length(times)

        time = times{time_i};
        
        if ~isfile([path '/PEB/GCM_' trial '_' time '.mat'])

            % collate
            GCM = cell(length(subjects),1);
            for sub_i = 1:length(subjects)
                
                subject = ['sub' num2str(sub_i)];
                
                load([path '/DCMs/' subject '/DCM_' trial '_' time '.mat']);
                GCM{sub_i, 1} = DCM;
            end
            save([path '/PEB/GCM_' trial '_' time '.mat'], 'GCM');
            
        end

    end

end

%% within-trialtype PEB - contrast early/late delay vs baseline

disp('within-trialtype PEB');

% for each trial type
for trial_i = 1:length(trialtypes)

    trial = trialtypes{trial_i};

    % for each delay period
    for delay_i = 1:length(delays)

        delay = delays{delay_i};
        
        if ~isfile([path '/PEB/searchPEB_'...
                trial '_' delay '_vs_baseline.mat'])
        
            % load GCMs
            GCM_delay = load([path '/PEB/GCM_' trial '_' delay '.mat']);
            GCM_baseline = load([path '/PEB/GCM_' trial '_baseline.mat']);

            % matrix design
            X = ones(length(subjects)*2, 2);
            X(length(subjects)*1 + (1:length(subjects)), 2) = -1; % delay > baseline

            %%% PEB
            GCM = [GCM_delay.GCM; GCM_baseline.GCM];
            PEB = spm_dcm_peb(GCM, X, field);

            % compute posterior probabilities
            % https://www.jiscmail.ac.uk/cgi-bin/webadmin?A2=SPM;d9f2cb4a.1806
            PEB.Pp = nan(size(PEB.Cp, 1), 1);
            for param_i = 1:size(PEB.Cp, 1)
                Ep = PEB.Ep(param_i);
                Vp = PEB.Cp(param_i,param_i);
                PEB.Pp(param_i,1) = 1 - spm_Ncdf(0,abs(Ep),Vp);
            end
            % PEB.Ep = parameter estimate (log-scaling parameter of H)
            % PEB.Pp = posterior probability that parameter > 0

            %%% BMA - search-PEB
            searchPEB = spm_dcm_peb_bmc(PEB);
            close all;

            save([path '/PEB/searchPEB_'...
                trial '_' delay '_vs_baseline.mat'], 'searchPEB')
            % searchPEB.Ep = parameter estimate (log-scaling parameter of H)
            % searchPEB.Pp = Free Energy (with vs without) - posterior probability that
            %           parameter > 0 after bayesian model averaging and search-PEB

            % display results
            % spm_dcm_peb_review(searchPEB);
            
        end
        
    end
    
end

close all;

%% between-trialtype PEB - pairwise contrasts between trial types during early delay, late delay and baseline

disp('between-trialtype PEB');

for time_i = 1:length(times)

    time = times{time_i};

    for contrast_i = 1:length(contrasts)
        
        contrast = contrasts{contrast_i};

        if strcmp(contrast, 'highprec_lowprec')
            trialtype_1 = 'highprec';
            trialtype_2 = 'lowprec';
        elseif strcmp(contrast, 'highprec_swap')
            trialtype_1 = 'highprec';
            trialtype_2 = 'swap';
        elseif strcmp(contrast, 'lowprec_swap')
            trialtype_1 = 'lowprec';
            trialtype_2 = 'swap';
        end
        
        if ~isfile([path '/PEB/searchPEB_'...
            contrast '_' time '.mat'])
        
            % load GCM
            GCM_1 = load([path '/PEB/GCM_' trialtype_1 '_' time '.mat']);
            GCM_2 = load([path '/PEB/GCM_' trialtype_2 '_' time '.mat']);

            % matrix design
            X = ones(length(subjects)*2, 2);
            X(length(subjects)*1 + (1:length(subjects)), 2) = -1;

            %%% PEB
            GCM = [GCM_1.GCM; GCM_2.GCM];
            PEB = spm_dcm_peb(GCM, X, field);

            % compute posterior probabilities
            % https://www.jiscmail.ac.uk/cgi-bin/webadmin?A2=SPM;d9f2cb4a.1806
            PEB.Pp = nan(size(PEB.Cp, 1), 1);
            for param_i = 1:size(PEB.Cp, 1)
                Ep = PEB.Ep(param_i);
                Vp = PEB.Cp(param_i,param_i);
                PEB.Pp(param_i,1) = 1 - spm_Ncdf(0,abs(Ep),Vp);
            end
            % PEB.Ep = parameter estimate (log-scaling parameter of H)
            % PEB.Pp = posterior probability that parameter > 0

            %%% BMA - search-PEB
            searchPEB = spm_dcm_peb_bmc(PEB);
            close all;

            save([path '/PEB/searchPEB_'...
                contrast '_' time '.mat'], 'searchPEB')
            % searchPEB.Ep = parameter estimate (log-scaling parameter of H)
            % searchPEB.Pp = Free Energy (with vs without) - posterior probability that
            %           parameter > 0 after bayesian model averaging and search-PEB

            % display results
            % spm_dcm_peb_review(searchPEB);
            
        end
        
    end
    
end

