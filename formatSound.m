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
