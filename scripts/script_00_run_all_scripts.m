%% run all scripts of manuscript

% paths
path = '/Users/as14864/Data/Analysis/BESM/DCM/dcm_github_hbm';
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
trialtypes = {'highaccuracy' 'lowaccuracy' 'swap'};         
delays = {'early_delay' 'late_delay'};
contrasts = {'highaccuracy_lowaccuracy' 'highaccuracy_swap' 'lowaccuracy_swap'};
subjects = 1:26;
matrices = {'A1' 'A2'};
sources = 7;
frequencies = 2:100;

% run matlab scripts
run([path '/scripts/script_01_dcm_inversion.m']);       
run([path '/scripts/script_02_peb.m']);                 
run([path '/scripts/script_03_sensitivity.m']);         
run([path '/scripts/script_04_figures.m']);  

% run scripts on Rstudio
% script_05_figures.Rmd
% script_06_summary.Rmd
