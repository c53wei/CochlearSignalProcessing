% Define audio files to process
audiofiles = ["moving_sound.m4a" "background_noise.m4a"];
% Container to store all matrices by applying function to list
[signal_data, Fs_data] = arrayfun(@(x) formatSound(x), audiofiles, ...
    'UniformOutput', false);
% Creates waveform plots for each audiofile
cellfun(@plotWaveform, signal_data, num2cell(audiofiles));

