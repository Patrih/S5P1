
clc 
clear all
close all
addpath('Data')

%Fait par : PHIL
%Date : 2019-11-11
%Reste a faire: 
% - 
% - 
% - 

load('Linearisation');
load('Identification_MC');
load('Constantes');
load('equilibre');
%Ces variables seront remplacées par celle dans banc d'essai si elle sont disponibles
% Position à l'équilibre de la sphère (pour tests statiques)
    sig = 1.0;         % Présence (1) ou non (0) de la sphère

    xSeq = 0.000;      % Position x de la sphère à l'équilibre en metres

    ySeq = 0.000;      % Position y de la sphère à l'équilibre en metres
%Point d'opération choisi pour la plaque

    Axeq = 0;               %en degres

    Ayeq = 0;               %en degres

    Pzeq = 0.015;            %en metres

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%Match and remplace
disp("---------------------------Match and remplace ------------------------------")


Ae1 = Ae(1);
Ae2 = Ae(2);
Ae3 = Ae(3);
Ae4 = Ae(4);

As1 = As(1);
As2 = As(2);
As3 = As(3);
As4 = As(4);

DFa_Dz = eval(subs(DFa_Dz));
DFb_Dz = eval(subs(DFb_Dz));
DFc_Dz = eval(subs(DFc_Dz));

DFa_DIa = eval(subs(DFa_DIa));
DFb_DIb = eval(subs(DFb_DIb));
DFc_DIc = eval(subs(DFc_DIc));

disp("---------------------------Graph Actionneurs--------------------------------")

[z,I] = meshgrid(0:0.0001:0.03,-3:0.1:3);
ZI = DFa_Dz.*(z-Pzeq) + DFa_DIa.*(I-eval(IA_eq))-1.4715;

SUM_as =(As(4).*z.^3 + As(3).*z.^2 + As(2).*z + As(1));
SUM_ae = (Ae(1) + Ae(2).*z + Ae(3).*z.^2 + Ae(4).*z.^3);
Fsk = -1./SUM_as;
Fek = (I.^2 + Be.*abs(I)).* sign(I)./SUM_ae ;
F_theo = Fsk + Fek;

figure(1)
surf(z,I,(F_theo-ZI))
colorbar
colormap('colorcube')
title('Erreur de la force linéarisée au point d''équilibre z = 0.0015')
xlabel('distance (m)')
ylabel('courant (A)')
zlabel('Erreur de la linearisation (N)')

figure(2)
surf(z,I,(F_theo-ZI))
colorbar
zlim([-50 50])
colormap('hsv')
title('Erreur de la force linéarisée au point d''équilibre z = 0.0015')
xlabel('distance (m)')
ylabel('courant (A)')
zlabel('Erreur de la linearisation (N)')

