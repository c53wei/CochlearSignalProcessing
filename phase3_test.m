audiofile = 'use_resampled.wav';
[signal, Fs_data] = audioread(audiofile);

% Define bandwidth intervals from 100 Hz to 8 kHz – Feel free to modify
intervals = logspace(2,log10(8000),100); % generates n points between decades 10^a and 10^b.
intervals(end) = intervals(end)-51;
bw = zeros(length(intervals)-1, 2);
bw(:, 1) = intervals(1:end-1);
bw(:, 2) = intervals(2:end);
bw = num2cell(bw,2).';

% Creates list of filter functions that can be called later 'in parallel'
filters = cellfun(@IIRButter, bw);

% Run each filter interval on it
% Separate audio file into frequencies of interest
split_band = cellfun(@filter, num2cell(filters), ...
    repmat({signal}, 1, length(filters)), 'UniformOutput', false);

% Task 7: Rectify each frequency
split_band = cellfun(@abs, split_band, 'UniformOutput', false);
% Task 8: Run it through LPF
envelope = cellfun(@filter, repmat({LPF3}, 1, length(filters)), ...
    split_band, 'UniformOutput', false);
    
modulate = zeros(size(split_band{1}, 1), length(split_band));
for i=1:length(split_band)
    envelope{i}=envelope{i}.*2; 
    % Get centre frequency
    fc = sqrt(bw{i}(1)*bw{i}(2));
    % Create cosine with oscillation of centre frequency of passband
    cosine = createCosine(split_band{i}, 16000, fc, ...
        strcat(num2str(bw{i}), '_Hz.wav'));
    cosine=cosine(1:length(cosine)-1);
    % Modulate cosine with envelope of other
    modulate(:,i) = envelope{i} .* cosine.';
end

final = sum(modulate, 2);
final = final./max(abs(final));
sound(final, 16000);
[~, name, ~] = fileparts(audiofile);
audiowrite(strcat(name, '_final.wav'),final,Fs_data);