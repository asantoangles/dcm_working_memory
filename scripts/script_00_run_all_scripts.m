%% run all scripts of manuscript

% paths
path = '/Users/as14864/Data/Analysis/BESM/DCM/dcm_github_fhn';
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
trialtypes = {'highaccuracy' 'lowaccuracy' 'swap'};         
times = {'early_delay' 'late_delay'};
contrasts = {'highaccuracy_lowaccuracy' 'highaccuracy_swap' 'lowaccuracy_swap'};
subjects = 1:26;
matrices = {'B1'};
sources = 7;

% run matlab scripts
run([path '/scripts/script_01_dcm_inversion.m']);       
run([path '/scripts/script_02_peb.m']);                 
