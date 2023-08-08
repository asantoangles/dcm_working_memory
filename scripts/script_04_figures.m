%% DCM - figures

disp('figures');

% create output folders
if ~isfolder([path '/figures'])
    mkdir([path '/figures']);
end

%% figures empirical vs predicted cross-spectral densities
% Figure S1 in supplementary material

disp('empirical vs predicted CSD');

% load csd
highaccuracy_baseline_dev0 = load([path '/sensitivity/csd_highaccuracy_baseline_nodeviation.mat']);
lowaccuracy_baseline_dev0 = load([path '/sensitivity/csd_lowaccuracy_baseline_nodeviation.mat']);
swap_baseline_dev0 = load([path '/sensitivity/csd_swap_baseline_nodeviation.mat']);
highaccuracy_early_delay_dev0 = load([path '/sensitivity/csd_highaccuracy_early_delay_nodeviation.mat']);
lowaccuracy_early_delay_dev0 = load([path '/sensitivity/csd_lowaccuracy_early_delay_nodeviation.mat']);
swap_early_delay_dev0 = load([path '/sensitivity/csd_swap_early_delay_nodeviation.mat']);
highaccuracy_late_delay_dev0 = load([path '/sensitivity/csd_highaccuracy_late_delay_nodeviation.mat']);
lowaccuracy_late_delay_dev0 = load([path '/sensitivity/csd_lowaccuracy_late_delay_nodeviation.mat']);
swap_late_delay_dev0 = load([path '/sensitivity/csd_swap_late_delay_nodeviation.mat']);


% for each source
for param_i = 1:sources
    for param_ii = 1:sources

        % subset modelled connections
        if ~(param_i == 6 && param_ii == 5)
            if ~(param_i == 5 && param_ii == 6)
                if ~(param_i == 4 && param_ii == 7)
                    if ~(param_i == 7 && param_ii == 4)                        
                        if ~(param_i == 3 && param_ii == 6)
                            if ~(param_i == 6 && param_ii == 3)
                                if ~(param_i == 2 && param_ii == 7)
                                    if ~(param_i == 7 && param_ii == 2) 
                                        if ~(param_i == 3 && param_ii == 4)
                                            if ~(param_i == 4 && param_ii == 3)
                                                if ~(param_i == 2 && param_ii == 5)
                                                    if ~(param_i == 5 && param_ii == 2) 
                                                        if ~(param_i > param_ii) 

                                                            % figure empirical vs predicted all trial types time-averaged
                                                            if ~isfile([path '/figures/Figure_empirical_vs_predicted_csd(' num2str(param_i) ',' num2str(param_ii) ').jpg'])

                                                                highaccuracy_empirical = median([highaccuracy_baseline_dev0.csd.empirical_y_amplitude(:, :, param_i, param_ii); ...
                                                                                  highaccuracy_early_delay_dev0.csd.empirical_y_amplitude(:, :, param_i, param_ii); ...
                                                                                  highaccuracy_late_delay_dev0.csd.empirical_y_amplitude(:, :, param_i, param_ii)], 1);
                                                                highaccuracy_predicted = median([highaccuracy_baseline_dev0.csd.predicted_y_amplitude(:, :, param_i, param_ii); ...
                                                                                  highaccuracy_early_delay_dev0.csd.predicted_y_amplitude(:, :, param_i, param_ii); ...
                                                                                  highaccuracy_late_delay_dev0.csd.predicted_y_amplitude(:, :, param_i, param_ii)], 1);
                                                                lowaccuracy_empirical = median([lowaccuracy_baseline_dev0.csd.empirical_y_amplitude(:, :, param_i, param_ii); ...
                                                                                  lowaccuracy_early_delay_dev0.csd.empirical_y_amplitude(:, :, param_i, param_ii); ...
                                                                                  lowaccuracy_late_delay_dev0.csd.empirical_y_amplitude(:, :, param_i, param_ii)], 1);
                                                                lowaccuracy_predicted = median([lowaccuracy_baseline_dev0.csd.predicted_y_amplitude(:, :, param_i, param_ii); ...
                                                                                  lowaccuracy_early_delay_dev0.csd.predicted_y_amplitude(:, :, param_i, param_ii); ...
                                                                                  lowaccuracy_late_delay_dev0.csd.predicted_y_amplitude(:, :, param_i, param_ii)], 1);
                                                                swap_empirical = median([swap_baseline_dev0.csd.empirical_y_amplitude(:, :, param_i, param_ii); ...
                                                                                  swap_early_delay_dev0.csd.empirical_y_amplitude(:, :, param_i, param_ii); ...
                                                                                  swap_late_delay_dev0.csd.empirical_y_amplitude(:, :, param_i, param_ii)], 1);
                                                                swap_predicted = median([swap_baseline_dev0.csd.predicted_y_amplitude(:, :, param_i, param_ii); ...
                                                                                  swap_early_delay_dev0.csd.predicted_y_amplitude(:, :, param_i, param_ii); ...
                                                                                  swap_late_delay_dev0.csd.predicted_y_amplitude(:, :, param_i, param_ii)], 1);
                                                            
                                                                fig = figure; hold on;
                                                                plot(frequencies, highaccuracy_empirical,'k', 'LineWidth',2)
                                                                plot(frequencies, highaccuracy_predicted,'k--', 'LineWidth',1)
                                                                plot(frequencies, lowaccuracy_empirical,'r', 'LineWidth',2)
                                                                plot(frequencies, lowaccuracy_predicted,'r--', 'LineWidth',1)
                                                                plot(frequencies, swap_empirical,'b', 'LineWidth',2)
                                                                plot(frequencies, swap_predicted,'b--', 'LineWidth',1)
                                                                xlabel('Frequency (Hz)');
                                                                ylabel('Amplitude (a.u.)');
                                                                title(['cross-spectral densities time-averaged connection (' num2str(param_i) ',' num2str(param_ii) ')']);
                                                                legend('high accuracy - empirical', 'high accuracy - predicted', 'low accuracy - empirical',...
                                                                    'low accuracy - predicted', 'swaps - empirical', 'swaps - predicted');
                                                                saveas(fig, [path '/figures/Figure_empirical_vs_predicted_csd(' num2str(param_i) ',' num2str(param_ii) ').jpg']);

                                                                close all;

                                                            end
                                                                                                                                                                                    
                                                        end

                                                    end

                                                end

                                            end

                                        end

                                    end

                                end

                            end

                        end

                    end

                end

            end

        end

    end

end
    



%% figures sensitivity analysis
% Figures 2 in manuscript
% Figures S2-4 in supplementary material

disp('sensitivity analysis');

% for each trial type
for trial_i = 1:length(trialtypes)
    
    trial = trialtypes{trial_i};
    
    % load no-deviation data
    dev0_baseline = load([path '/sensitivity/csd_' trial '_baseline_nodeviation.mat']);
    dev0_early_delay = load([path '/sensitivity/csd_' trial '_early_delay_nodeviation.mat']);
    dev0_late_delay = load([path '/sensitivity/csd_' trial '_late_delay_nodeviation.mat']);

    % median across time
    dev0 = dev0_baseline;
    dev0.csd.empirical_y_amplitude = median([dev0_baseline.csd.empirical_y_amplitude;...
                                             dev0_early_delay.csd.empirical_y_amplitude;...
                                             dev0_late_delay.csd.empirical_y_amplitude], 1);

    dev0.csd.predicted_y_amplitude = median([dev0_baseline.csd.predicted_y_amplitude;...
                                             dev0_early_delay.csd.predicted_y_amplitude;...
                                             dev0_late_delay.csd.predicted_y_amplitude], 1);
    
    % for each A matrix (feedforward and feedback)
    for mat_i = 1:length(matrices)

        matrix = matrices{mat_i};
        
        if mat_i == 1
            connections = 'feedforward';
        else
            connections = 'feedback';
        end
        
        % plot sensitivity for extrinsic parameters 
        for param_i = 1:sources

            for param_ii = 1:sources

                check_file = [path '/sensitivity/csd_' trialtypes{1} '_' times{1} '_' matrix '(' num2str(param_i) ',' num2str(param_ii) ')_dev1.mat'];

                if isfile(check_file)
                    
                    % load data deviation
                    dev1_baseline = load([path '/sensitivity/csd_' trial '_baseline_' matrix '(' num2str(param_i) ',' num2str(param_ii) ')_dev1.mat']);
                    dev1_early_delay = load([path '/sensitivity/csd_' trial '_early_delay_' matrix '(' num2str(param_i) ',' num2str(param_ii) ')_dev1.mat']);
                    dev1_late_delay = load([path '/sensitivity/csd_' trial '_late_delay_' matrix '(' num2str(param_i) ',' num2str(param_ii) ')_dev1.mat']);
                    devminus1_baseline = load([path '/sensitivity/csd_' trial '_baseline_' matrix '(' num2str(param_i) ',' num2str(param_ii) ')_dev-1.mat']);
                    devminus1_early_delay = load([path '/sensitivity/csd_' trial '_early_delay_' matrix '(' num2str(param_i) ',' num2str(param_ii) ')_dev-1.mat']);
                    devminus1_late_delay = load([path '/sensitivity/csd_' trial '_late_delay_' matrix '(' num2str(param_i) ',' num2str(param_ii) ')_dev-1.mat']);

                    % median across time
                    dev1 = dev1_baseline;
                    dev1.csd.empirical_y_amplitude = median([dev1_baseline.csd.empirical_y_amplitude;...
                                                             dev1_early_delay.csd.empirical_y_amplitude;...
                                                             dev1_late_delay.csd.empirical_y_amplitude], 1);
                    dev1.csd.predicted_y_amplitude = median([dev1_baseline.csd.predicted_y_amplitude;...
                                                             dev1_early_delay.csd.predicted_y_amplitude;...
                                                             dev1_late_delay.csd.predicted_y_amplitude], 1);

                    devminus1 = devminus1_baseline;
                    devminus1.csd.empirical_y_amplitude = median([devminus1_baseline.csd.empirical_y_amplitude;...
                                                             devminus1_early_delay.csd.empirical_y_amplitude;...
                                                             devminus1_late_delay.csd.empirical_y_amplitude], 1);
                    devminus1.csd.predicted_y_amplitude = median([devminus1_baseline.csd.predicted_y_amplitude;...
                                                             devminus1_early_delay.csd.predicted_y_amplitude;...
                                                             devminus1_late_delay.csd.predicted_y_amplitude], 1);

                    % for each source
                    for source_i = 1:sources
                        for source_ii = 1:sources

                            % plot effect of deviation over CSD in same connection
                            if param_i == source_i
                                if param_ii == source_ii
                                                                        
                                    % plot sensitivity 
                                    if ~isfile([path '/figures/Figure_sensitivity_' trial '_avgtime_' connections '_A(' num2str(param_i) ',' num2str(param_ii) ').jpg'])

                                        % adapt y-axis range
                                        maximum = 0;
                                        if max(median(dev0.csd.empirical_y_amplitude(:, 2:50, param_i, param_ii), 1)) > maximum
                                            maximum = max(median(dev0.csd.empirical_y_amplitude(:, 2:50, param_i, param_ii), 1));
                                        end
                                        if max(median(dev0.csd.empirical_y_amplitude(:, 2:50, param_i, param_ii), 1)) > maximum
                                            maximum = max(median(dev0.csd.empirical_y_amplitude(:, 2:50, param_i, param_ii), 1));
                                        end
                                        if max(median(dev0.csd.empirical_y_amplitude(:, 2:50, param_i, param_ii), 1)) > maximum
                                            maximum = max(median(dev0.csd.empirical_y_amplitude(:, 2:50, param_i, param_ii), 1));
                                        end

                                        % figure
                                        fig = figure; hold on;
                                        plot(2:50, median(dev0.csd.predicted_y_amplitude(:, 2:50, source_i, source_ii), 1),'k', 'LineWidth',2)
                                        plot(2:50, median(dev1.csd.predicted_y_amplitude(:, 2:50, source_i, source_ii), 1),'r--', 'LineWidth',2)
                                        plot(2:50, median(devminus1.csd.predicted_y_amplitude(:, 2:50, source_i, source_ii), 1),'b--', 'LineWidth',2)
                                        legend('predicted', '+0.1', '-0.1');
                                        xlabel('Frequency (Hz)');
                                        ylabel('Amplitude (a.u.)');
                                        title(['sensitivity ' trial ' time-averaged - ' connections ' connection A(' num2str(source_i) ',' num2str(source_ii) ')']);

                                        % save figure
                                        saveas(fig, [path '/figures/Figure_sensitivity_' trial '_avgtime_' connections '_A(' num2str(param_i) ',' num2str(param_ii) ').jpg']);

                                        close all;

                                    end
                                    
                                end

                            end

                        end

                    end

                end

            end

        end

    end

end

