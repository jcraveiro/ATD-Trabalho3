% Trabalho 3 - Exercicio 5 - ATD
% -- David Gomes
% -- Joao Craveiro
% -- Rui Pereira Mendes

nnotes = {'-'; 'D?'; 'D?#'; 'R?'; 'R?#'; 'Mi'; 'F?'; 'F?#'; 'Sol'; 'Sol#'; 'L?'; 'L?#'; 'Si'; 'D?2'};

% 5.1
[sound, fs] = audioread('escala.wav');

figure(1);

subplot(2, 1, 1);
plot(sound);
title('5.1 - Escala.wav');
xlabel('t');
ylabel('Amplitude');

subplot(2, 1, 2);
f = fft(sound);
plot(abs(f(1:length(f)/2)));
title('5.1 - Magnitude do espectro');
xlabel('f');
ylabel('Magnitude');

%5.2 150ms, sem sobreposicao
timeWindow = 150;
timeStep = 150;
f = stfft(sound,fs,timeWindow,timeStep,0);

wstep = floor(timeWindow/1000*fs);
[freqs1,~] = getFreqs(abs(f),fs,wstep,0);

figure(2);
plot(freqs1,'o');
title('5.2 - Frequencias obtidas  - STFT');

xlabel('t');
ylabel('f');

notes = getNotes(freqs1);
disp('5.2) Notas musicais - Escala');
for i=1:length(notes)
    disp(nnotes(notes(i)));
end

%resolucao em freq:
%1/T <=> 1/0.15 ou fs/N
disp('5.2) Resolucao em frequencia:');
disp(fs/wstep);

%5.3
[piano,fspiano] = audioread('piano.wav');
[flauta,fsflauta] = audioread('flauta.wav');

%media entre os dois canais
fusao = (flauta(:,1)+flauta(:,2))/2;
flauta = fusao;

fpiano = fft(piano);
fflauta = fft(flauta);
player = audioplayer(piano,fspiano);
player.play();

figure(3);

subplot(2,1,1);
plot(piano);
title('5.3 - piano.wav');
xlabel('t');
ylabel('Amplitude');

absfpiano = abs(fpiano);
subplot(2,1,2);
plot(absfpiano(1:floor(length(absfpiano)/2)));
title('5.3 - Magnitude do espectro');
xlabel('f');
ylabel('Magnitude');

figure(4);

subplot(2,1,1);
plot(flauta);
title('5.3 - flauta.wav');
xlabel('t');
ylabel('Amplitude');

absfflauta = abs(fflauta);
subplot(2,1,2);
plot(absfflauta(1:floor(length(absfflauta)/2)));
title('5.3 - Magnitude do espectro');
xlabel('f');
ylabel('Magnitude');

%5.4
%piano 187 ms - notas mais curtas

figure(5);

timeWindow = 187;
timeStep = 187;
f = stfft(piano,fspiano,timeWindow,timeStep,0);

wstep = floor(timeWindow/1000*fs);
[freqs1,amps1] = getFreqs(abs(f),fs,wstep,0);

subplot(2,1,1);
plot(freqs1,'o');
title('5.4 - Frequencias obtidas - Short Time Fourier Transform - Piano');

xlabel('t');
ylabel('f');

notes1 = getNotes(freqs1);
disp('5.4) Notas musicais - Piano');

for i=1:length(notes1)
    disp(nnotes(notes1(i)));
end

disp('5.4) Resolucao em frequencia (Piano):');
disp(fspiano/wstep);

%flauta 150ms
timeWindow = 150;
timeStep = 5.8;
f = stfft(flauta,fsflauta,timeWindow,timeStep,0);

wstep = floor(timeWindow/1000*fs);
[freqs2,amps2] = getFreqs(abs(f),fs,wstep,0);

subplot(2,1,2);
plot(freqs2,'o');
title('5.4 - Frequencias obtidas - Flauta');
xlabel('t');
ylabel('f');

notes2 = getNotes(freqs2);
disp('5.4) Notas musicais - Flauta');

for i=1:length(notes1)
    disp(nnotes(notes1(i)));
end

for i=1:length(notes1)
    disp(nnotes(notes1(i)));
end

disp('5.4) Resolucao em frequencia (Flauta):');
disp(fsflauta/wstep);