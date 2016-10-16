% Trabalho 3 - Exercicio 3 - ATD
% -- David Gomes
% -- Joao Craveiro
% -- Rui Pereira Mendes

%3.1
[img,map] = imread('lena.bmp');

%3.2
figure(1);
imshow(img);
title('Exercício 3.2');

%3.3
f = fftshift(fft2(img));
[w, h] = size(f);

xstart = fix(-w/2);
xend = fix(w/2 - 1 + mod(w,2));
ystart = fix(-h/2);
yend = fix(h/2 - 1 + mod(h,2));
xx = xstart:xend;
yy = ystart:yend;

figure(2);
mesh(xx,yy,20*log10(abs(f)));
axis([xx(1) xx(length(xx)) yy(1) yy(length(yy))]);
view([-45 30]);
rotate3d;
title('Magnitude');

%cor media
mask = zeros(size(f));
mx = find(xx == 0);
my = find(yy == 0);
mask(mx,my) = 1;
    
fmedia = f .* mask;
invfmedia = ifft2(ifftshift(fmedia));
cormedia = invfmedia(mx,my);
invfmedia(1:length(invfmedia)) = cormedia;
figure(3);
imshow(invfmedia,map);
title('Cor média');

%3.4

escolha = menu('3.4 - Tipo de filtro:','Passa-Baixo','Passa-Alto');

%3.5
freq = input('Frequência: ');

mask = zeros(size(f));
s = size(mask);

for i = 1:s(1)
    for j = 1:s(2)
        mask(i,j) = (((i-mx)^2 + (j-my)^2) >= freq^2);
    end
end

if (escolha == 1)
    mask = 1-mask;
    mask(mx,my) = 1;
end

figure(4);
mesh(xx,yy,20*log10(abs(mask)+1));
title('FFT - db - Máscara');
axis([xx(1) xx(length(xx)) yy(1) yy(length(yy))]);
view([-45 30]);
rotate3d;

%3.6
ffiltered = f .* mask;

figure(5);
mesh(xx,yy,20*log10(abs(ffiltered)+1));
title('FFT - db - Imagem filtrada');
axis([xx(1) xx(length(xx)) yy(1) yy(length(yy))]);
view([-45 30]);
rotate3d;

%3.7
outputimg = ifft2(ifftshift(ffiltered))/length(map);

%3.8
figure(6);
imshow(outputimg);
title('Imagem filtrada');

