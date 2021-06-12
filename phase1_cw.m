%% Helper function
cosineHelper = @(y, Fs, filename) createCosine(y, Fs, 1000, filename);
%% Task 3.1-3.6 (Signal Reformatting)
% Define audio files to process
audiofiles = ["moving_sound.m4a" "background_noise.m4a"];
% Container to store all matrices by applying function to list
[signal_data, Fs_data] = arrayfun(@(x) formatSound(x), audiofiles, ...
    'UniformOutput', false);
% Creates waveform plots for each audiofile
cellfun(@plotWaveform, signal_data, num2cell(audiofiles));

%% Task 3.7 Generating cosine for each file
cos_sound = cellfun(cosineHelper, signal_data, Fs_data, ...
    num2cell(audiofiles), 'UniformOutput', false);
% sound(cos_sound{1}, 1000} % Play it back if you'd like