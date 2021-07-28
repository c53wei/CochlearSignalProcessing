audiofile = 'radio_resampled.wav';
[signal, Fs_data] = audioread(audiofile);
% Define bandwidth intervals from 100 Hz to 8 kHz – Feel free to modify
bw = {[100 500] [500 700] [700 900] [900 1100] [1100 1300] ...
    [1300 1800] [1800 2800] [2800 4800] [4800 8000]};
% Creates list of filter functions that can be called later 'in parallel'
filters = cellfun(@bandPass, bw);




% Run each filter interval on it
% hold off;
% Separate audio file into frequencies of interest
split_band = cellfun(@filter, num2cell(filters), ...
    repmat({signal}, 1, length(filters)), 'UniformOutput', false);
% Task 6: Plot lowest and highest frequency bandwidths
% [~, name, ~] = fileparts(audiofile);

% Task 7: Rectify each frequency
split_band = cellfun(@abs, split_band, 'UniformOutput', false);
% Task 8: Run it through LPF
envelope = cellfun(@filter, repmat({LPF3}, 1, length(filters)), ...
    split_band, 'UniformOutput', false);
% Plot lowest frequency
% plot(split_band{1});
% hold on;
% plot(sqrt(2)*envelope{1});
% ylabel('Amplitude');
% xlabel('Sample Number');
% title(strcat(num2str(bw{1}), 'Hz'));
% saveas(gcf, strcat(name, '_LowFreqEnvelope.png'));
% hold off;
% % % % Plot highest frequency
% plot(split_band{length(split_band)});
% hold on;
% plot(5*envelope{length(envelope)});
% ylabel('Amplitude');
% xlabel('Sample Number');
% title(strcat(num2str(bw{length(split_band)}), 'Hz'));
% saveas(gcf, strcat(name, '_HighFreqEnvelope.png'));
% % close all




% Find Centre of bandwith
centreFreq([100 1000]);
centre = cellfun(@centreFreq, bw);

% For each of the recitified audio signals, call the cosine function
% cosines = cellfun(@createCosine, centre,  )
cosineLength = length(split_band{1,2});
cosines = zeros(1, 9);
cosinesCell = num2cell(cosines);

for i = length(centre)
   cosinesCell{i} = createCosine(cosineLength, 44000, centre(i));
end

modulated = num2cell(zeros(1,9));
bands = cell2mat(split_band);
for i = length(modulated)
%     modulated{1} = ammod(envelope{i},cosinesCell{i}, 44000);
    modulated{i} = cosinesCell{i}.*envelope{i};
end

modulatedSum = sum(modulated);
maodulated_abs = abs(modulatedSum);
maxVal = max(modulated_abs);
modulatedSum = modulatedSum/max_val;

sound(modulatedSum, 44000);
%ok i think nromalizign means dividing everything by some value


% Find Centre of bandwith
function center = centreFreq(interval)
    % Pass in the bandwidth
    fc1 = interval(1);
    fc2 = interval(2);
    center = sqrt(fc1*fc2);
end

% % Create Cosine for the rectified signals
function y = createCosine(sample_data, sample_Fs, cos_Fs)
    signal_duration = length(sample_data)/sample_Fs;
    t = 0:sample_Fs^-1:signal_duration;
    y = cos(2*pi*cos_Fs .*t);
end



