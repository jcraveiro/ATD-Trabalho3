% Trabalho 3 - Exercicio 4 - ATD
% -- David Gomes
% -- Joao Craveiro
% -- Rui Pereira Mendes

%4.1

[sax,fs] = audioread('saxriff.wav');
sizeX = length(sax);

subplot(2,1,1);
plot(sax);
title('4.1 - Saxriff.wav');
xlabel('t');
ylabel('Amplitude');

f = abs(fft(sax));
subplot(2,1,2);
plot(f(1:floor(length(f)/2)));
title('4.1 - Magnitude do espectro');
xlabel('f');
ylabel('Magnitude');

player = audioplayer(sax,fs);
player.play();

%4.2
window = round(46.44*fs/1000);
sobreposicao = round(5.8*fs/1000);
N = window;

if mod(sizeX,2) == 0
    f = linspace(-fs/2, fs/2 - fs/N, N);
else
    f = linspace(-fs/2 + fs/(2*N), fs/2 - fs/(2*N), N);
end

matrixsizeX = 1:N-sobreposicao:sizeX-N;

%Janelas
xaprox = zeros(size(sax));

Ts = 1/fs;
t = 0:Ts:sizeX*Ts-Ts;
x2 = zeros(sizeX, 1);
j=1;
for i=matrixsizeX
    janelaX = fftshift(fft(sax(i : i+N-1).*hamming(N), N));
    
    Xabsmax = (abs(janelaX));
    ind = find(f <= 100);
    Xabsmax(ind) = 0;
    [amps(j), ind] = max(Xabsmax);
    freqs(j) = f(ind(end)); 
    j = j + 1;
  
end
figure(2);
plot(freqs, '.');
title('Frequencias fundamentais do sistema');

%4.3 - Filtro do tipo mediana

timeStep  = 5.8;
freqs2 = medianFilter(freqs,7);

subplot(2,1,2);
plot(freqs2,'o');
title('4.3 - Frequencias filtradas - Janela 5');
xlabel('t');
ylabel('f');

%4.4 - Reconstrucao do sinal

x = freqsToSignal(freqs2,amps,timeStep,fs);
figure(3);
plot(x);
title('4.4 - Sinal filtrado reconstruido');
xlabel('t');
ylabel('A');
