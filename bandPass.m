%% Task 4 – Bandpass filter bank
function Hd = bandPass(interval)
% Returns a discrete-time filter object.
% signal - output of audioread of resampled audio file at 16000 Fs
% fc1, fc2 – Upper and lower cutoff frequencies

% MATLAB Code
% Generated by MATLAB(R) 9.10 and DSP System Toolbox 9.12.
% Generated on: 01-Jul-2021 01:39:14

% Butterworth Bandpass filter designed using FDESIGN.BANDPASS.
% Unpack interval limits into lower and upper frequency
fc1 = interval(1);
fc2 = interval(2);
% All frequency values are in Hz.
Fstop1 = fc1-100;     % First Stopband Frequency
if Fstop1 <= 0
    % For lower cutoff frequencies <= 100 Hz
    Fstop1 = 50;
end
Fpass1 = fc1;         % First Passband Frequency
Fpass2 = fc2;         % Second Passband Frequency
Fstop2 = fc2 + 100;   % Second Stopband Frequency
Fs = 2*Fstop2 + 100;  % Sampling Frequency
Astop1 = 60;          % First Stopband Attenuation (dB)
Apass  = 1;           % Passband Ripple (dB)
Astop2 = 80;          % Second Stopband Attenuation (dB)
match  = 'passband';  % Band to match exactly

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.bandpass(Fstop1, Fpass1, Fpass2, Fstop2, Astop1, Apass, ...
                      Astop2, Fs);
Hd = design(h, 'butter', 'MatchExactly', match);

% [EOF]
