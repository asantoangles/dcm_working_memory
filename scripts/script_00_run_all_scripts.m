%% run all scripts of manuscript

% paths
path = '/Volumes/Neuroimage/Analysis/BESM/DCM/dcm_github';
if isfolder(path)
else
    disp('Error - specify path to dcm_github folder');
end

% load spm
path_spm = '/Users/as14864/software/spm12/';
if isfolder(path_spm)
    addpath(path_spm);
    spm('defaults','EEG');
else
    disp('Error - SPM12 folder not found');
end

% parameters
times = {'baseline' 'early_delay' 'late_delay'};
trialtypes = {'highprec' 'lowprec' 'swap'};
delays = {'early_delay' 'late_delay'};
contrasts = {'highprec_lowprec' 'highprec_swap' 'lowprec_swap'};
subjects = 1:26;
matrices = {'A1' 'A2'};
sources = 7;
frequencies = 2:100;

% run scripts
run([path '/scripts/script_01_group_priors.m'])
run([path '/scripts/script_02_dcm_inversion.m']);
run([path '/scripts/script_03_peb.m']);
run([path '/scripts/script_04_loo.m']);
run([path '/scripts/script_05_sensitivity.m']);
run([path '/scripts/script_06_figures.m']);

% run script_07_figures.Rmd and script_08_summary.Rmd on Rstudio to create html figures and summary documents
disp(' ');
disp('run script_07_figures.Rmd on Rstudio, after adapting paths, to create html document with all the figures (see script_07_figures.html)');
disp(' ');
disp('run script_08_summary.Rmd on Rstudio, after adapting paths, to create html document with all PEB results (see script_08_summary.html)');

