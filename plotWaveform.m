function plotWaveform(signal_values, filename)
% Generates & saves waveform plots and titles based on sample name
[~, name, ~] = fileparts(filename);
plot(signal_values);
xlabel('Sample Number');
ylabel('Value (Units?)'); % Not sure what the unit is
saveas(gcf, strcat(name, '.png'));
end