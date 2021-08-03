function Hd = bandPass(interval)

cutoff1 = interval(1);
cutoff2 = interval(2);
Fs = 16000;
N = 12;

h  = fdesign.bandpass('N,F3dB1,F3dB2', N, cutoff1, cutoff2, Fs);
Hd = design(h, 'butter');