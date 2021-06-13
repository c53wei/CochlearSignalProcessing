fork = 'sound of scratching a fork on a plate.wav';
knife = 'Knife on bottle.wav';
twice = 'T.wav';
finger = 'Horror Sound Effect - Fingernails on a Chalkboard.wav';
[y,Fs] = audioread(fork);

%sound(y,Fs);

[m, n] = size(y);
if n > 1 
    y = sum(y, 2);
end

newSample = resample(y,16000,Fs);

audiowrite('newfile.wav',newSample,16000);

plot(newSample,16000)

clear y Fs