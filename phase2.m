    intervals = [0, 100, 500, 700, 900, 1100, 1300, 1800, 2800, 4800, 7999];
    fs = 8000;
    numSamples = length(resampledFile);
    filteredSounds(numSamples, 10) = 0.0;
    
    for x = 1:10
        if x == 1
            [b,a] = butter(4, 100/fs, 'low');
        else
            interval1 = intervals(x)/fs;
            interval2 = intervals(x+1)/fs;
            [b,a] = butter(4,[interval1 interval2], 'bandpass');    
        end
        filter = filtfilt(b,a,resampledFile);
        for n = 1:numSamples
            filteredSounds(n,x) = filter(n);
        end
    end
    
    timeDuration = numSamples;
    t = 0:timeDuration/(numSamples-1):numSamples;
    lowChannel(numSamples) = 0.0;
    highChannel(numSamples)= 0.0;
    
    for y = 1:numSamples
        lowChannel(y) = filteredSounds(y,1);
        highChannel(y) = filteredSounds(y,10);
    end
    
    plot(t, lowChannel(1:y));
    title('First Channel Filtered')
    xlabel('Sample Number')
    
    plot(t, highChannel(1:y));
    title('Last Channel Filtered')
    xlabel('Sample Number')
    
    %7-8
    rectified = filteredSounds;
    rectifiedTranspose = transpose(rectified);
    signalSize = size(rectifiedTranspose);
    signalQuantity = signalSize(1);
    signalEnvelopes(10, numSamples) = 0.0;
    filter = bandpass();
     
    for i = 1:signalQuantity
        signalSquared = 2*rectifiedTranspose(i,:).*rectifiedTranspose(i,:);
        signalEnvelope = filtfilt(filter.Numerator,1,signalSquared);
        
        signalEnvelopes(i,:) = sqrt(signalEnvelope);
        
        if i == 1 
            plot(abs(signalEnvelopes(i,:)));
            title('Low Freq Envelope'); 
            xlabel('Sample Number');
        end
        if i == signalQuantity
            plot(abs(signalEnvelopes(i,:)));
            title('High Freq Envelope'); 
            xlabel('Sample Number');
        end
    end
