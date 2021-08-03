function y = createCosine(sample_data, sample_Fs, cos_Fs, filename)
% Writes .wav file for cosine function at 1kHz of same duration as original
% Also plots 2 cycles of it

[~, name, ~] = fileparts(filename);
% Calculate original duration of sample signal
signal_duration = length(sample_data)/sample_Fs;
% Setup dependent & independent values for cosine plot
t = 0:sample_Fs^-1:signal_duration;
y = cos(2*pi*cos_Fs .*t);
%audiowrite(strcat(name, '_cos1khz.wav'), y, sample_Fs);

% Extract 2 cycles only
% Since frequency is 1000 Hz, it will take 2 ms to complete 2 cycles
% Could just extract from above but will need more data points
time = linspace(0, 2e-3, 1000);
% Calculate cosine
yshort = cos(2*pi*cos_Fs .*time);
%plot(time.*1e3, yshort);
%xlabel('Time (ms)');
%ylabel(''); 
%saveas(gcf, strcat(name, '_1kHz_2cycles.png'));
end