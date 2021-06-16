fork = 'sound of scratching a fork on a plate';
knife = 'Knife on bottle';
finger = 'Horror Sound Effect - Fingernails on a Chalkboard';
scary = 'Scary';
caterpillar = 'caterpillar';
sampleRate = 16000;

forkProcessed = process(fork,sampleRate,1,'.wav');
knifeProcessed = process(knife, sampleRate,2,'.wav');
fingerProcessed = process(finger, sampleRate,3,'.wav');
scaryProcessed = process(scary, sampleRate,4, '.m4a');
caterProcessed = process(caterpillar, sampleRate, 5, '.m4a');
cosinePlot();

f = @process;
c = @cosinePlot;

function process = process(name,sampleRate,num, type)
    [y,Fs] = audioread(strcat(name,type));
    [m, n] = size(y);
    if n == 2 
        y = sum(y, 2);
    end
    
    newSample = resample(y,sampleRate,Fs);
    audiowrite(strcat(name,'_resampled.wav'),newSample,sampleRate);
    
    duration = size(newSample, 1)/sampleRate;

    w = 2*pi*1000;
    t = [0:(1/sampleRate):duration];
    y = cos(w*t);
    audiowrite(strcat(name,'_cosine.wav'),y,sampleRate);
    [y,Fs] = audioread('cosine.wav');
    sound(y,Fs);
    
    figure(num);
    process = plot(newSample);
    xlabel('Time (ms)');
    ylabel(''); 
    saveas(gcf, strcat(name, '_plot.png'));
end

function cosinePlot
    w = 2*pi*1000;
    t = linspace(0, 2e-3, 1000);
    y = cos(w*t);
    plot(t,y);
    xlabel('Time (ms)');
    clear y Fs
end