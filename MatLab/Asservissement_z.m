clc;
clear all;
close all;
addpath('Data');

% Fait par Louis Etienne
% Date: 2019-11-18
% Asservissement de Z
% À faire :
% Les itérations pour atteindre les perf désirées

load('equilibre');

%% Définitions
PMd = 25;
wgd = 185;
errech1d = -0.0004;
errech2d = 0;

[num, den] = tfdata(TF_z, 'v');

%% Avance de phase
Kd = 1 / abs(evalfr(TF_z, 1i*wgd));
[PM, GM, wp, wg] = margin(Kd*TF_z);

marge = 80;
dPhi = PMd + marge - PM;

alpha = (1-sind(dPhi))/(1+sind(dPhi));
T = 1 / (wgd * sqrt(alpha));

% Calcul du z et p
z = -1/T;
p = -1/(alpha*T);

Ka = Kd/sqrt(alpha);

% Fonction de transfert du compensateur
avPh = 0.1 * Ka * tf([1 -z], [1 -p]);

margin(avPh*TF_z);