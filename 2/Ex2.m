% Trabalho 3 - Exercicio 2 - ATD
% -- David Gomes
% -- Joao Craveiro
% -- Rui Pereira Mendes
%exercicio 2.1
[x, fs] = audioread('saxriff.wav');
player = audioplayer(x, fs);
player.play();

info = audioinfo('saxriff.wav');
nBits = info.BitsPerSample;
N = 2^nBits;
X = fftshift(fft(x,N));
ws = 2*pi*fs;

aux = mod(N,2);
if aux == 0
    W = linspace(-ws/2, ws/2 - ws/N, N);
else
    W = linspace(-ws/2 + ws/(2*N), ws/2 - ws/(2*N), N);
end

figure(1);
plot(W, abs(X), '.');
title('Espetro do sinal');

fprintf('Prima qualquer tecle para continuar...\n\n');
pause();

%2.2
XAbsMax = max(abs(X));
indMax = find(abs(X) == XAbsMax);
fXAbsMax = W(indMax(2))/(2*pi);

fprintf('A frequencia cuja componente tem aplitude maxima e %f Hz\n', fXAbsMax);

fprintf('Prima qualquer tecla para continuar...\n\n');
pause();

%2.3

freq1 = 8500;
freq2 = 9500;

indPos = find(W >= 2*pi*freq1 & W <= 2*pi*freq2);
indNeg = find(W >= -2*pi*freq2 & W <= -2*pi*freq1);

XrAbs = 0.1*XAbsMax*rand(size(indPos));
XrAngle = 2*pi*rand(size(indPos))-pi;

XrPos = XrAbs.*(cos(XrAngle) + 1i*sin(XrAngle));
XrNeg = conj(XrPos);

Xr = X;
Xr(indPos) = X(indPos)' + XrPos;
Xr(indNeg) = X(indNeg)' + XrNeg(end:-1:1);

figure(2);
plot(W, abs(Xr), '.');
title('Espectro do sinal ruidoso (8500-9500)');

fprintf('Prima qualquer tecla para continuar...\n\n');
pause();

%2.4
%Fun??o para substituir o wavplay
xr = real(ifft(ifftshift(Xr)));
audioplayer(xr, fs);

fprintf('Prima qualquer tecla para continuar...\n\n');
pause();

%2.5
fc = 8000;
wn = 2*fc/fs;   % fc = fs/2 * wn  <=>  wn = 2*fc/fs
[b, a] = butter(6, wn);
xFiltrado = filter(b, a, xr);
XFiltrado = fftshift(fft(xFiltrado));

fprintf('Coeficientes do numerador:\n'); disp(b);
fprintf('Coeficientes do denominador:\n'); disp(a);

figure(3);
zplane(b,a);

%2.6
freq1 = 2000;
freq2 = 3000;

indPos = find(W >= 2*pi*freq1 & W <= 2*pi*freq2);
indNeg = find(W >= -2*pi*freq2 & W <= -2*pi*freq1);

XrAbs = 0.1*XAbsMax*rand(size(indPos));
XrAngle = 2*pi*rand(size(indPos))-pi;

XrPos = XrAbs.*(cos(XrAngle) + 1i*sin(XrAngle));
XrNeg = conj(XrPos);

Xr = X;
Xr(indPos) = X(indPos)' + XrPos;
Xr(indNeg) = X(indNeg)' + XrNeg(end:-1:1);

figure(6);
plot(W, abs(Xr), '.');
title('Espectro do sinal ruidoso (2000-3000)');

fprintf('Prima qualquer tecla para continuar...\n\n');
pause();

xr = real(ifft(ifftshift(Xr)));
player = audioplayer(xr, fs);
player.play();

fprintf('Prima qualquer tecla para continuar...\n\n');
pause();

fcLow = 2000;
fcHigh = 3000;
wn = [2*fcLow/fs, 2*fcHigh/fs];
[b, a] = butter(6, wn, 'stop');
xFiltrado = filter(b, a, xr);
XFiltrado = fftshift(fft(xFiltrado)); 

fprintf('Coeficientes do numerador:\n'); disp(b);
fprintf('Coeficientes do denominador:\n'); disp(a);

figure(7);
zplane(b,a);

figure(8);
plot(W, abs(XFiltrado), '.');
title('Espectro do sinal filtrado');

figure(9);
t = 0 : 1/fs : 1/fs * (length(xr)-1);
plot(t, real(xr), t, real(xFiltrado));
title('Sinal filtrado vs Sinal original'); 
legend('Sinal Filtrado', 'Sinal Original');

player = audioplayer(real(xFiltrado), fs);
player.play();

figure(4);
plot(W, abs(XFiltrado), '.');
title('Espectro do sinal filtrado');

figure(5);
t = 0 : 1/fs : 1/fs * (length(xr)-1);
plot(t, real(xr), t, real(xFiltrado));
title('Sinal filtrado vs Sinal original');
legend('Sinal Filtrado', 'Sinal Original');

audioplayer(real(xFiltrado), fs);
fprintf('Prima qualquer tecla para continuar...\n\n');
pause();