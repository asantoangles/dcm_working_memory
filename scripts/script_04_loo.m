%% DCM - leave-one-out cross-validation

disp('PEB - leave-one-out cross-validation');

cd([path '/scripts']);

peb_thr = 0.95;

% create output folder
if ~isfolder([path '/LOO'])
    mkdir([path '/LOO']);
end


%% select PEB parameters with Pp > 0.95 in PEB 
% within-trialtype PEB

% empty structure
loo_list = cell(0, 3);
    
for delay_i = 1:length(delays)

    delay = delays{delay_i};

    for trial_i = 1:length(trialtypes)

        trial = trialtypes{trial_i};

        % load peb
        load([path '/PEB/searchPEB_'...
            trial '_' delay '_vs_baseline.mat']); % searchPEB

        % loop over parameters
        number_param = size(searchPEB.Pnames, 1);
        for param_i = (number_param+1):(number_param*2)

            if full(searchPEB.Pp(param_i, 1)) > peb_thr

                loo_list{size(loo_list, 1)+1, 1} = delay;
                loo_list{size(loo_list, 1), 2} = trial;

                % feedforward connections
                if param_i-number_param == 1
                    loo_list{size(loo_list, 1), 3} = 'A{1}(2,1)';
                elseif param_i-number_param == 2
                    loo_list{size(loo_list, 1), 3} = 'A{1}(3,1)';
                elseif param_i-number_param == 3
                    loo_list{size(loo_list, 1), 3} = 'A{1}(3,2)';
                elseif param_i-number_param == 4
                    loo_list{size(loo_list, 1), 3} = 'A{1}(2,3)';
                elseif param_i-number_param == 5
                    loo_list{size(loo_list, 1), 3} = 'A{1}(1,4)';
                elseif param_i-number_param == 6
                    loo_list{size(loo_list, 1), 3} = 'A{1}(2,4)';
                elseif param_i-number_param == 7
                    loo_list{size(loo_list, 1), 3} = 'A{1}(5,4)';
                elseif param_i-number_param == 8
                    loo_list{size(loo_list, 1), 3} = 'A{1}(1,5)';                        
                elseif param_i-number_param == 9
                    loo_list{size(loo_list, 1), 3} = 'A{1}(3,5)';
                elseif param_i-number_param == 10
                    loo_list{size(loo_list, 1), 3} = 'A{1}(4,5)';
                elseif param_i-number_param == 11
                    loo_list{size(loo_list, 1), 3} = 'A{1}(1,6)';
                elseif param_i-number_param == 12
                    loo_list{size(loo_list, 1), 3} = 'A{1}(2,6)';
                elseif param_i-number_param == 13
                    loo_list{size(loo_list, 1), 3} = 'A{1}(4,6)';
                elseif param_i-number_param == 14
                    loo_list{size(loo_list, 1), 3} = 'A{1}(7,6)';
                elseif param_i-number_param == 15
                    loo_list{size(loo_list, 1), 3} = 'A{1}(1,7)';                        
                elseif param_i-number_param == 16
                    loo_list{size(loo_list, 1), 3} = 'A{1}(3,7)';
                elseif param_i-number_param == 17
                    loo_list{size(loo_list, 1), 3} = 'A{1}(5,7)';
                elseif param_i-number_param == 18
                    loo_list{size(loo_list, 1), 3} = 'A{1}(6,7)';                        

                % feedback connections
                elseif param_i-number_param == 19
                    loo_list{size(loo_list, 1), 3} = 'A{2}(4,1)';
                elseif param_i-number_param == 20
                    loo_list{size(loo_list, 1), 3} = 'A{2}(5,1)';
                elseif param_i-number_param == 21
                    loo_list{size(loo_list, 1), 3} = 'A{2}(6,1)';
                elseif param_i-number_param == 22
                    loo_list{size(loo_list, 1), 3} = 'A{2}(7,1)';
                elseif param_i-number_param == 23
                    loo_list{size(loo_list, 1), 3} = 'A{2}(1,2)';
                elseif param_i-number_param == 24
                    loo_list{size(loo_list, 1), 3} = 'A{2}(3,2)';
                elseif param_i-number_param == 25
                    loo_list{size(loo_list, 1), 3} = 'A{2}(4,2)';
                elseif param_i-number_param == 26
                    loo_list{size(loo_list, 1), 3} = 'A{2}(6,2)';
                elseif param_i-number_param == 27
                    loo_list{size(loo_list, 1), 3} = 'A{2}(1,3)';
                elseif param_i-number_param == 28
                    loo_list{size(loo_list, 1), 3} = 'A{2}(2,3)';
                elseif param_i-number_param == 29
                    loo_list{size(loo_list, 1), 3} = 'A{2}(5,3)';
                elseif param_i-number_param == 30
                    loo_list{size(loo_list, 1), 3} = 'A{2}(7,3)';
                elseif param_i-number_param == 31
                    loo_list{size(loo_list, 1), 3} = 'A{2}(5,4)';
                elseif param_i-number_param == 32
                    loo_list{size(loo_list, 1), 3} = 'A{2}(6,4)';
                elseif param_i-number_param == 33
                    loo_list{size(loo_list, 1), 3} = 'A{2}(4,5)';
                elseif param_i-number_param == 34
                    loo_list{size(loo_list, 1), 3} = 'A{2}(7,5)';
                elseif param_i-number_param == 35
                    loo_list{size(loo_list, 1), 3} = 'A{2}(7,6)';
                elseif param_i-number_param == 36
                    loo_list{size(loo_list, 1), 3} = 'A{2}(6,7)';

                end
                
                % remove if empty
                if isempty(loo_list{size(loo_list, 1), 3})
                    loo_list = loo_list(1:(size(loo_list, 1)-1),:);
                end

            end
            
        end

    end

end
    

%% cv-loo PEB
% within-trialtype PEB

for list_i = 1:size(loo_list, 1)
    
    delay = loo_list{list_i, 1};
    trial = loo_list{list_i, 2};
    parameter = loo_list{list_i, 3};

    if ~isfile([path '/LOO/peb_' trial '_' delay '_' parameter '.mat'])

        % merge GCM for first_time and second_time 
        GCM_delay = load([path '/PEB/GCM_' trial '_' delay '.mat']);
        GCM_baseline = load([path '/PEB/GCM_' trial '_baseline.mat']);
        GCM = {[GCM_delay.GCM; GCM_baseline.GCM]};
        GCM = GCM{1,1};

        % matrix design
        M  = struct();
        M.alpha = 1;
        M.beta  = 16;
        M.hE    = 0;
        M.hC    = 1/16;
        M.Q     = 'single';  
        M.X = ones(length(subjects)*2, 2);
        M.X(length(subjects)*1 + (1:length(subjects)), 2) = -1; % delay > baseline

        % model parameters to do stats
        field = parameter;

        % Perform leave-one-out cross validation (GCM,M,field are as before)
        [qE,qC,Q,r,p] = spm_dcm_loo_rcoef_pval(GCM,M,field);
        close all;

        % save
        loo = [];
        loo.corrcoef = r;
        loo.pvalue = p;
        loo.qE = qE;
        loo.qC = qC;
        loo.Q = Q;
        loo.legend = {'qE = posterior predictive expectation';...
            'qC = posterior predictive covariances';...
            'Q(1,:) = posterior probability of delay > baseline';...
            'Q(2,:) = posterior probability of delay < baseline'};

        save([path '/LOO/peb_' trial '_' delay '_' parameter '.mat'], 'loo');

    end
                
end 

%% select PEB parameters with Pp > 0.95 in PEB 
% between-trialtype PEB

% empty structure
loo_list = cell(0, 3);

for time_i = 1:length(times)

    time = times{time_i};

    for contrast_i = 1:length(contrasts)

        contrast = contrasts{contrast_i};

        if strcmp(contrasts{contrast_i}, 'highprec_lowprec')
            trialtype_1 = 'highprec';
            trialtype_2 = 'lowprec';
        elseif strcmp(contrasts{contrast_i}, 'highprec_swap')
            trialtype_1 = 'highprec';
            trialtype_2 = 'swap';
        elseif strcmp(contrasts{contrast_i}, 'lowprec_swap')
            trialtype_1 = 'lowprec';
            trialtype_2 = 'swap';
        end

        % load peb
        load([path '/PEB/searchPEB_' trialtype_1 '_' trialtype_2 '_' time '.mat']); % searchPEB

        % loop over parameters
        number_param = size(searchPEB.Pnames, 1);
        for param_i = (number_param+1):(number_param*2)

            if full(searchPEB.Pp(param_i, 1)) > peb_thr

                loo_list{size(loo_list, 1)+1, 1} = time;
                loo_list{size(loo_list, 1), 2} = contrast;

                if param_i-number_param == 1
                    loo_list{size(loo_list, 1), 3} = 'A{1}(2,1)';
                elseif param_i-number_param == 2
                    loo_list{size(loo_list, 1), 3} = 'A{1}(3,1)';
                elseif param_i-number_param == 3
                    loo_list{size(loo_list, 1), 3} = 'A{1}(3,2)';
                elseif param_i-number_param == 4
                    loo_list{size(loo_list, 1), 3} = 'A{1}(2,3)';
                elseif param_i-number_param == 5
                    loo_list{size(loo_list, 1), 3} = 'A{1}(1,4)';
                elseif param_i-number_param == 6
                    loo_list{size(loo_list, 1), 3} = 'A{1}(2,4)';
                elseif param_i-number_param == 7
                    loo_list{size(loo_list, 1), 3} = 'A{1}(5,4)';
                elseif param_i-number_param == 8
                    loo_list{size(loo_list, 1), 3} = 'A{1}(1,5)';                        
                elseif param_i-number_param == 9
                    loo_list{size(loo_list, 1), 3} = 'A{1}(3,5)';
                elseif param_i-number_param == 10
                    loo_list{size(loo_list, 1), 3} = 'A{1}(4,5)';
                elseif param_i-number_param == 11
                    loo_list{size(loo_list, 1), 3} = 'A{1}(1,6)';
                elseif param_i-number_param == 12
                    loo_list{size(loo_list, 1), 3} = 'A{1}(2,6)';
                elseif param_i-number_param == 13
                    loo_list{size(loo_list, 1), 3} = 'A{1}(4,6)';
                elseif param_i-number_param == 14
                    loo_list{size(loo_list, 1), 3} = 'A{1}(7,6)';
                elseif param_i-number_param == 15
                    loo_list{size(loo_list, 1), 3} = 'A{1}(1,7)';                        
                elseif param_i-number_param == 16
                    loo_list{size(loo_list, 1), 3} = 'A{1}(3,7)';
                elseif param_i-number_param == 17
                    loo_list{size(loo_list, 1), 3} = 'A{1}(5,7)';
                elseif param_i-number_param == 18
                    loo_list{size(loo_list, 1), 3} = 'A{1}(6,7)';                        


                elseif param_i-number_param == 19
                    loo_list{size(loo_list, 1), 3} = 'A{2}(4,1)';
                elseif param_i-number_param == 20
                    loo_list{size(loo_list, 1), 3} = 'A{2}(5,1)';
                elseif param_i-number_param == 21
                    loo_list{size(loo_list, 1), 3} = 'A{2}(6,1)';
                elseif param_i-number_param == 22
                    loo_list{size(loo_list, 1), 3} = 'A{2}(7,1)';
                elseif param_i-number_param == 23
                    loo_list{size(loo_list, 1), 3} = 'A{2}(1,2)';
                elseif param_i-number_param == 24
                    loo_list{size(loo_list, 1), 3} = 'A{2}(3,2)';
                elseif param_i-number_param == 25
                    loo_list{size(loo_list, 1), 3} = 'A{2}(4,2)';
                elseif param_i-number_param == 26
                    loo_list{size(loo_list, 1), 3} = 'A{2}(6,2)';
                elseif param_i-number_param == 27
                    loo_list{size(loo_list, 1), 3} = 'A{2}(1,3)';
                elseif param_i-number_param == 28
                    loo_list{size(loo_list, 1), 3} = 'A{2}(2,3)';
                elseif param_i-number_param == 29
                    loo_list{size(loo_list, 1), 3} = 'A{2}(5,3)';
                elseif param_i-number_param == 30
                    loo_list{size(loo_list, 1), 3} = 'A{2}(7,3)';
                elseif param_i-number_param == 31
                    loo_list{size(loo_list, 1), 3} = 'A{2}(5,4)';
                elseif param_i-number_param == 32
                    loo_list{size(loo_list, 1), 3} = 'A{2}(6,4)';
                elseif param_i-number_param == 33
                    loo_list{size(loo_list, 1), 3} = 'A{2}(4,5)';
                elseif param_i-number_param == 34
                    loo_list{size(loo_list, 1), 3} = 'A{2}(7,5)';
                elseif param_i-number_param == 35
                    loo_list{size(loo_list, 1), 3} = 'A{2}(7,6)';
                elseif param_i-number_param == 36
                    loo_list{size(loo_list, 1), 3} = 'A{2}(6,7)';

                end

                % remove if empty
                if isempty(loo_list{size(loo_list, 1), 3})
                    loo_list = loo_list(1:(size(loo_list, 1)-1),:);
                end

            end

        end

    end

end

    
%% cv-loo PEB
% between-trialtype PEB

for list_i = 1:size(loo_list, 1)
    
    time = loo_list{list_i, 1};
    contrast = loo_list{list_i, 2};
    parameter = loo_list{list_i, 3};
    
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

    if ~isfile([path '/LOO/peb_' contrast '_' time '_' parameter '.mat'])

        % merge GCM for first_time and second_time 
        GCM_trial1 = load([path '/PEB/GCM_' trialtype_1 '_' time '.mat']);
        GCM_trial2 = load([path '/PEB/GCM_' trialtype_2 '_' time '.mat']);
        GCM = {[GCM_trial1.GCM; GCM_trial2.GCM]};
        GCM = GCM{1,1};

        % matrix design
        M  = struct();
        M.alpha = 1;
        M.beta  = 16;
        M.hE    = 0;
        M.hC    = 1/16;
        M.Q     = 'single';  
        M.X = ones(length(subjects)*2, 2);
        M.X(length(subjects)*1 + (1:length(subjects)), 2) = -1; % delay > baseline

        % model parameters to do stats
        field = parameter;

        % Perform leave-one-out cross validation (GCM,M,field are as before)
        [qE,qC,Q,r,p] = spm_dcm_loo_rcoef_pval(GCM,M,field);
        close all;

        % save
        loo = [];
        loo.corrcoef = r;
        loo.pvalue = p;
        loo.qE = qE;
        loo.qC = qC;
        loo.Q = Q;
        loo.legend = {'qE = posterior predictive expectation';...
            'qC = posterior predictive covariances';...
            'Q(1,:) = posterior probability of delay > baseline';...
            'Q(2,:) = posterior probability of delay < baseline'};

        save([path '/LOO/peb_' contrast '_' time '_' parameter '.mat'], 'loo');

    end
                
end 

disp('Analyses done without errors');