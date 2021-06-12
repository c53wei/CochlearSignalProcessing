function y = createCosine(sample_data, sample_Fs, cos_Fs, filename)
% Writes .wav file for cosine function at 1kHz of same duration as original
% Also plots 2 cycles of it

[~, name, ~] = fileparts(filename);
% Calculate original duration of sample signal
signal_duration = length(sample_data)/sample_Fs;
% Setup dependent & independent values for cosine plot
n = 0:cos_Fs*signal_duration; % Number of samples needed
y = cos(2*pi*cos_Fs .*n);

% Extract 2 cycles only
% Since frequency is 1000 Hz, it will take 2 ms to complete 2 cycles
% Could just extract from above but will need more data points
time = linspace(0, 2e-3, 1000);
% Calculate cosine
yshort = cos(2*pi*cos_Fs .*time);
plot(time.*1e3, yshort);
xlabel('Time (ms)');
ylabel('Value (Units?)'); 
saveas(gcf, strcat(name, '_1kHz_2cycles.png'));
end