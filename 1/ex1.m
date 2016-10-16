% Trabalho 3 - Exercicio 1 - ATD
% -- David Gomes
% -- Joao Craveiro
% -- Rui Pereira Mendes

% Determinamos analiticamente, tendo em conta que #G = 13 e mod(13, 2) = 1:

% xt = -1 + 3*sin(30*pi*t) + 4*sin(12*pi*t - pi/4).*cos(21*pi*t);
%    = -cos(0t+0-) + 3*cos(pi/2-30*pi*t) + 2*cos(pi/2 - (33*pi*t-pi/4))
%    = -2*cos(pi/2-(9*pi*t+pi/4))
%    = -1 + 3*cos(pi/2-30*pi*t) + 2*cos(3*pi/4 -33*pi*t) - 2*cos(pi/4 -9*pi*t)

w0 = 3 * pi;
f0 = w0 / (2 * pi);
wmax = 33 * pi;
fmax = wmax / (2 * pi);
fs = 36;
Ts = 1 / fs;
T0 = 1 / f0;
N = floor(T0 / Ts);
step = T0 / 500;
t = 0:step:T0 - step;
n = 0:N - 1;

% 1.1
xt = -1 + 3 * cos(pi / 2 - 30 * pi * t) + 2 * cos(3 * pi / 4 -33 * pi * t) - 2 * cos(pi / 4 - 9 * pi * t);
xn = -1 + 3 * cos(pi / 2 - 30 * pi * n * Ts) + 2 * cos(3 * pi / 4 - 33 * pi * n * Ts) - 2 * cos(pi / 4 - 9 * pi * n * Ts);

% 1.2
w0 = 3 * pi;
w1 = 0;
w2 = 30 * pi;
w3 = 33 * pi;
w4 = 9 * pi;
omega0 = 2 * pi / N;
omega1 = 0 * omega0;
omega2 = 11 * omega0;
omega3 = 6 * omega0;

% 1.3
figure(1), plot(t, xt, n * Ts, xn, 'o'), title('x(t) e x[n]');

% 1.4
X_n = fftshift(fft(xn));

figure(2), subplot(2,1,1), plot(n * fs / N, abs(X_n) / N, 'o'), title('Amplitude x[n]');
figure(2), subplot(2,1,2), plot(n * fs / N, angle(X_n) / N, 'o'), title('Fase x[n]');

% 1.5
cm = X_n(N / 2 + 1:N)/N ;

% 1.6
Cm  = 2 * abs(cm); 

tetam = angle(X_n(N / 2 + 1:N) / N);

figure(3), subplot(2, 1, 1), plot(0:1:N/2 - 1, Cm, 'o'), title('Cm');
figure(3), subplot(2, 1, 2), plot(0:N/2 - 1, tetam, 'o'), title('tetam');

% 1.7
x_t = serie_fourier(Cm, tetam, t, T0, length(Cm) - 1);

figure(4), plot(t, x_t, t, xt);