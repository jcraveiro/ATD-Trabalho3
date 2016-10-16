function x = freqsToSignal(freqs,amps,timeStep,fs)
    window = floor(timeStep/1000*fs);

    wsec = timeStep/1000;
    t = 0:1/fs:wsec-1/fs;

    x = zeros(1,length(freqs)*window);
    
    for i=1:length(freqs)
        indice = (i-1)*window + 1;
        x(indice:indice+window-1) = amps(i)*sin(2*pi*freqs(i).*t);
    end
    
end
