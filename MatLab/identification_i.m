clear all
IDENTIFICATION_MC;
close all
clc

Be1 = 13.029359254409743;
Fe = -9.8*0.4602/3;
z = 0:0.0001:0.03;
Fs = (-1./(A(1) + A(2).*z + A(3).*z.^2 + A(4).*z.^3)+offset);
polyz = (A1(1) + A1(2)*z + A1(3)*z.^2 + A1(4)*z.^3);

%% Cas 1

Ie1 = 1/2.*(-sqrt(Be1^2-4.*polyz.*Fs+4.*polyz.*Fe)-Be1);% complex
Ie2 = 1/2.*(sqrt(Be1^2-4.*polyz.*Fs+4*polyz.*Fe)-Be1); % complex


Ie3 = 1/2.*(-sqrt(Be1^2+4.*polyz.*Fs-4.*polyz.*Fe)+Be1); %BONNE R�PONSE :D!!!!!!
Ie4 = 1/2.*(sqrt(Be1^2+4.*polyz.*Fs-4.*polyz.*Fe)+Be1); %suelement positif :/ meh


figure(69)
plot(z,Ie3)

figure(420)
plot(z,Ie4)




