% Task 5: Filter sounds with pass bank

% Define audio files to process
audiofiles = dir('*_resampled.wav');
audiofiles = {audiofiles(1:end).name};
[signal_data, Fs_data] = cellfun(@audioread, audiofiles, ...
    'UniformOutput', false);
% Define bandwidth intervals from 100 Hz to 8 kHz – Feel free to modify
bw = {[100 500] [500 700] [700 900] [900 1100] [1100 1300] ...
    [1300 1800] [1800 2800] [2800 4800] [4800 8000]};
% Creates list of filter functions that can be called later 'in parallel'
filters = cellfun(@bandPass, bw);

% For each audio file, run each filter interval on it
for i=1:length(audiofiles)
    % Isolate audio file of interest
    signal = signal_data{i};
    % Separate audio file into frequencies of interest
    split_band = cellfun(@filter, num2cell(filters), ...
        repmat({signal}, 1, length(filters)), 'UniformOutput', false);
    % Task 6: Plot lowest and highest frequency bandwidths
    [~, name, ~] = fileparts(audiofiles{i});
    plot(split_band{1});
    ylabel('Amplitude');
    xlabel('Sample Number');
    title(strcat(num2str(bw{1}), 'Hz'));
    saveas(gcf, strcat(name, '_LowFreq.png'));
    
    plot(split_band{length(split_band)});
    ylabel('Amplitude');
    xlabel('Sample Number');
    title(strcat(num2str(bw{length(split_band)}), 'Hz'));
    saveas(gcf, strcat(name, '_HighFreq.png'));
    
    % Task 7: Rectify each frequency
    split_band = cellfun(@abs, split_band, 'UniformOutput', false);
    % Task 8: Run it through LPF
    split_band = cellfun(@filter, repmat({LPF}, 1, length(filters)), ...
        split_band, 'UniformOutput', false);
    plot(split_band{1});
    ylabel('Amplitude');
    xlabel('Sample Number');
    title(strcat(num2str(bw{1}), 'Hz'));
    saveas(gcf, strcat(name, '_LowFreqEnvelope.png'));
    
    plot(split_band{length(split_band)});
    ylabel('Amplitude');
    xlabel('Sample Number');
    title(strcat(num2str(bw{length(split_band)}), 'Hz'));
    saveas(gcf, strcat(name, '_HighFreqEnvelope.png'));
    
    close all
end