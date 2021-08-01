intervals = logspace(2,log10(8000),10); % generates n points between decades 10^a and 10^b.
audiofile = 'radio_resampled.wav';
[signal, Fs_data] = audioread(audiofile);

% Define bandwidth intervals from 100 Hz to 8 kHz – Feel free to modify
bw = {[intervals(1) intervals(2)] [intervals(2) intervals(3)] ...
    [intervals(3) intervals(4)] [intervals(4) intervals(5)] ...
    [intervals(5) intervals(6)] [intervals(6) intervals(7)] ...
    [intervals(7) intervals(8)] [intervals(8) intervals(9)] ...
    [intervals(9) intervals(10)-51] 
    };
% Creates list of filter functions that can be called later 'in parallel'
filters = cellfun(@NewBand, bw);

% Run each filter interval on it
% hold off;
% Separate audio file into frequencies of interest
split_band = cellfun(@filter, num2cell(filters), ...
    repmat({signal}, 1, length(filters)), 'UniformOutput', false);
% Task 6: Plot lowest and highest frequency bandwidths
[~, name, ~] = fileparts(audiofile);

% Task 7: Rectify each frequency
split_band = cellfun(@abs, split_band, 'UniformOutput', false);
% Task 8: Run it through LPF
envelope = cellfun(@filter, repmat({LPF3}, 1, length(filters)), ...
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
% sound(split_band{1}, 16000);

%     % Get centre frequency
%     fc = sqrt(bw{3}(1)*bw{3}(2));
%     % Create cosine with oscillation of centre frequency of passband
%     cosine = createCosine(split_band{3}, 16000, fc, ...
%         strcat(num2str(bw{3}), '_Hz.wav'));
%     cosine=cosine(1:length(cosine)-1);
% %     sound(cosine, 16000);
%     % Modulate cosine with envelope of other
%     bob = envelope{3}.* cosine.';
%     y = ammod(envelope{3},fc,16000);
% sound(y, 16000);
    
modulate = zeros(size(split_band{1}, 1), length(split_band));
for i=1:9
    envelope{i}=envelope{i}*2; 
    % Get centre frequency
    fc = sqrt(bw{i}(1)*bw{i}(2));
    % Create cosine with oscillation of centre frequency of passband
    cosine = createCosine(split_band{i}, 16000, fc, ...
        strcat(num2str(bw{i}), '_Hz.wav'));
    cosine=cosine(1:length(cosine)-1);
%     sound(cosine, 16000);
    % Modulate cosine with envelope of other
    bob = envelope{i} .*cosine.';
    modulate(:,i) = envelope{i} .* cosine.';
end

final = sum(modulate, 2);
sound(final, 16000);
