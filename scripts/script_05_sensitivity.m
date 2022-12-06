%% DCM - sensitivity analysis

disp('sensitivity analysis');

% create output folders
if ~isfolder([path '/sensitivity'])
    mkdir([path '/sensitivity']);
end

%% create DCMs with deviation in individual parameters (±0.1)

disp('deviation in DCMs');

for time_i = 1:length(times)

    time = times{time_i};

    for trial_i = 1:length(trialtypes)

        trial = trialtypes{trial_i};

        disp([time ' ' trial]);
        
        for sub_i = 1:length(subjects)

            subject = ['sub' num2str(subjects(sub_i))];
            
            if ~isfolder([path '/sensitivity/' subject])
                mkdir([path '/sensitivity/' subject]);
            end
                                   
            % extrinsic connections 
            for A_matrix_i = 1:2
                
                matrix_name = 'A';
                
                % check parameters
                fitted_dcm = [path '/DCMs/' subject '/DCM_' trial '_' time '.mat'];
                load(fitted_dcm);
                
                DCM_template = DCM;
                
                % introduce small changes in H parameters (sensitivity or contribution analysis)
                for row_i = 1:size(DCM_template.Ep.A{A_matrix_i}, 1)
                    for col_i = 1:size(DCM_template.Ep.A{A_matrix_i}, 1)
                       if DCM_template.Ep.A{A_matrix_i}(row_i, col_i) ~= -32 % estimated parameter (-32 means no estimation)
                           for dev_i = [0.1 -0.1]
                                                              
                               if ~isfile([path '/sensitivity/' subject '/csd_'...
                                        trialtypes{trial_i} '_' times{time_i} '_sensitivity_' matrix_name num2str(A_matrix_i)...
                                        '(' num2str(row_i) ',' num2str(col_i) ')_dev' num2str(dev_i*10) '.mat'])

                                    clear DCM;

                                    fitted_dcm = [path '/DCMs/' subject '/DCM_' trial '_' time '.mat'];
                                    load(fitted_dcm);

                                    DCM.Ep.A{A_matrix_i}(row_i, col_i) = DCM.Ep.A{A_matrix_i}(row_i, col_i) + dev_i;

                                    % get csd predictions from parameter estimates
                                    Hc  = spm_csd_mtf(DCM.Ep,DCM.M,DCM.xU);
                                    DCM.Hc = Hc;

                                    save([path '/sensitivity/' subject '/csd_'...
                                        trialtypes{trial_i} '_' times{time_i} '_sensitivity_' matrix_name num2str(A_matrix_i)...
                                        '(' num2str(row_i) ',' num2str(col_i) ')_dev' num2str(dev_i*10) '.mat'],'DCM');
                                    
                               end
                           end
                       end
                    end
                end
            end
        end
    end
end


%% create dataset of cross-spectral densities (csd) for each subject (with no deviation)

disp('CSD dataset for no-deviation DCMs');

for time_i = 1:length(times)

    time = times{time_i};

    for trial_i = 1:length(trialtypes)

        trial = trialtypes{trial_i};

        disp([time ' ' trial]);
        
        if ~isfile([path '/sensitivity/csd_' trial '_' time '_nodeviation.mat'])
        
            % empty structures
            tmp.dimord = 'row.subect_x_col.freq';        
            tmp.empirical_y_amplitude = nan(length(subjects), length(frequencies), sources, sources);
            tmp.predicted_y_amplitude = nan(length(subjects), length(frequencies), sources, sources);

            for sub_i = 1:length(subjects)

                subject = ['sub' num2str(subjects(sub_i))];
            
                fitted_dcm = [path '/DCMs/' subject '/DCM_' trial '_' time '.mat'];
                load(fitted_dcm);

                % psd and csd (source x source)
                for source_ii = 1:sources
                    for source_iii = 1:sources

                        % save empirical and predicted amplitudes
                        tmp.empirical_y_amplitude(sub_i, :, source_ii, source_iii) = abs(DCM.xY.y{1,1}(:,source_ii, source_iii));
                        tmp.predicted_y_amplitude(sub_i, :, source_ii, source_iii) = abs(DCM.Hc{1,1}(:,source_ii, source_iii));

                    end
                end
            end

            csd = tmp;

            save([path '/sensitivity/csd_' trial '_' time '_nodeviation.mat'], 'csd');
            
        end

    end
    
end


%% create dataset of cross-spectral densities (csd) for each subject (with deviation)

disp('CSD dataset for deviation DCMs');

for time_i = 1:length(times)

    time = times{time_i};

    for trial_i = 1:length(trialtypes)

        trial = trialtypes{trial_i};

        disp([time ' ' trial]);
               
        for matrix_i = 1:length(matrices)
            
            matrix = matrices{matrix_i};
                                            
            for dev_i = [0.1 -0.1]
                            
                for row_ii = 1:sources
                    for col_ii = 1:sources

                        % check if file exists
                        file_check = [path '/sensitivity/sub' num2str(1) '/csd_'...
                            trialtypes{trial_i} '_' times{time_i} '_sensitivity_' matrix ...
                            '(' num2str(row_ii) ',' num2str(col_ii) ')_dev' num2str(dev_i*10) '.mat'];

                        if isfile(file_check)

                            if ~isfile([path '/sensitivity/csd_' ...
                                trial '_' time '_' matrix ...
                                '(' num2str(row_ii) ',' num2str(col_ii) ')_dev' num2str(dev_i*10) '.mat'])

                                % empty structures
                                tmp.dimord = 'row.subect_x_col.freq';        
                                tmp.empirical_y_amplitude = nan(length(subjects), length(frequencies), sources, sources);
                                tmp.predicted_y_amplitude = nan(length(subjects), length(frequencies), sources, sources);

                                for sub_i = 1:length(subjects)

                                    subject = ['sub' num2str(subjects(sub_i))];

                                    file = [path '/sensitivity/' subject '/csd_'...
                                        trialtypes{trial_i} '_' times{time_i} '_sensitivity_' matrix ...
                                        '(' num2str(row_ii) ',' num2str(col_ii) ')_dev' num2str(dev_i*10) '.mat'];

                                    if isfile(file)

                                        clear DCM;

                                        load(file)

                                        % psd and csd (source x source)
                                        for source_ii = 1:sources
                                            for source_iii = 1:sources

                                                % save amplitudes in matrix
                                                tmp.empirical_y_amplitude(sub_i, :, source_ii, source_iii) = abs(DCM.xY.y{1,1}(:,source_ii, source_iii));
                                                tmp.predicted_y_amplitude(sub_i, :, source_ii, source_iii) = abs(DCM.Hc{1,1}(:,source_ii, source_iii));

                                            end
                                        end
                                    end
                                end

                                csd = tmp;

                                save([path '/sensitivity/csd_' ...
                                    trial '_' time '_' matrix ...
                                    '(' num2str(row_ii) ',' num2str(col_ii) ')_dev' num2str(dev_i*10) '.mat'], 'csd');

                            end
                        end
                    end
                end
            end
        end
    end
end

% % intermediary files
% system(['rm -r ' path '/sensitivity/sub*']);

