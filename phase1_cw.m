% Define audio files to process
audiofiles = ["moving_sound.m4a" "background_noise.m4a"];
% Container to store all matrices by applying function to list
[signal_data, Fs_data] = arrayfun(@(x) formatSound(x), audiofiles, ...
    'UniformOutput', false);
% Creates waveform plots for each audiofile
cellfun(@plotWaveform, signal_data, num2cell(audiofiles));

function [y, Fs] = formatSound(filename)
% Reads audio file, resampling and converting to mono if needed

% Extract basename
[~,name,~] = fileparts(filename);
[y,Fs] = audioread(filename);
% Resample to 16 kHz if needed
if Fs ~= 16000
    Fsnew = 16e3;
    [P,Q] = rat(Fsnew/Fs);
    y = resample(y,P,Q);
    Fs = Fsnew;
end
% If stereo, convert to mono
[m, n] = size(y);
if n == 2
    % Sum across rows
    y = sum(y, 2);
end
% Write resampled file
audiowrite(strcat(name, '_resampled.wav'),y,Fs);
end

function plotWaveform(signal_values, filename)
% Generates & saves waveform plots and titles based on sample name
[~, name, ~] = fileparts(filename);
plot(signal_values);
xlabel('Sample Number');
ylabel('Value (Units?)');
saveas(gcf, strcat(name, '.png'))
end
