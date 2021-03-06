function Hd = IIRButter(interval)
%NEWBAND Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.10 and DSP System Toolbox 9.12.
% Generated on: 01-Aug-2021 02:16:33

% Butterworth Bandpass filter designed using FDESIGN.BANDPASS.

% All frequency values are in Hz.
Fs = 16000;  % Sampling Frequency

N   = 10;   % Order
Fc1 = interval(1);  % First Cutoff Frequency
Fc2 = interval(2) + 50;  % Second Cutoff Frequency

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.bandpass('N,F3dB1,F3dB2', N, Fc1, Fc2, Fs);
Hd = design(h, 'butter');

% [EOF]
