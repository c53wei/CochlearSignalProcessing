audiofile = 'Knife on bottle_resampled.wav';
[signal, Fs_data] = audioread(audiofile);
% Define bandwidth intervals from 100 Hz to 8 kHz – Feel free to modify
bw = {[100 500] [500 700] [700 900] [900 1100] [1100 1300] ...
    [1300 1800] [1800 2800] [2800 4800] [4800 8000]};
% Creates list of filter functions that can be called later 'in parallel'
filters = cellfun(@bandPass, bw);

% Run each filter interval on it
hold off;
% Separate audio file into frequencies of interest
split_band = cellfun(@filter, num2cell(filters), ...
    repmat({signal}, 1, length(filters)), 'UniformOutput', false);
% Task 6: Plot lowest and highest frequency bandwidths
[~, name, ~] = fileparts(audiofile);

% Task 7: Rectify each frequency
split_band = cellfun(@abs, split_band, 'UniformOutput', false);
% Task 8: Run it through LPF
envelope = cellfun(@filter, repmat({LPF}, 1, length(filters)), ...
    split_band, 'UniformOutput', false);

% Plot lowest frequency
% plot(split_band{1});
% hold on;
% plot(2*envelope{1});
% ylabel('Amplitude');
% xlabel('Sample Number');
% title(strcat(num2str(bw{1}), 'Hz'));
% saveas(gcf, strcat(name, '_LowFreqEnvelope.png'));
% hold off;
% % Plot highest frequency
% plot(split_band{length(split_band)});
% hold on;
% plot(2*envelope{length(envelope)});
% ylabel('Amplitude');
% xlabel('Sample Number');
% title(strcat(num2str(bw{length(split_band)}), 'Hz'));
% saveas(gcf, strcat(name, '_HighFreqEnvelope.png'));
% close all

modulate = zeros(size(split_band{1}, 1), length(split_band));
for i=length(split_band)
%     envelope{i}=envelope{i}*2; 
    % Get centre frequency
    fc = sqrt(bw{i}(1)*bw{i}(2));
    % Create cosine with oscillation of centre frequency of passband
    cosine = createCosine(split_band{i}, 16000, fc, ...
        strcat(num2str(bw{1}), '_Hz.wav'));
    cosine=cosine(1:length(cosine)-1);
    % Modulate cosine with envelope of other
    modulate(:,i) = envelope{i} .* cosine.';
end

final = sum(modulate, 2);
