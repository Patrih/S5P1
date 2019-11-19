clc;
clear all;
close all;
addpath('Data');
addpath('Functions');

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

%% Avance de phase
[avPh1, ~] = AvancePhaseBode1(TF_z, PMd, wgd, 5);

% Deuxième avance de phase
[avPh2, ~] = AvancePhaseBode1(avPh1*TF_z, PMd, wgd, 10);
margin(avPh2*avPh1*TF_z);


%% Erreur en régime permanent
disp('--- ERREUR EN RÉGIME PERMANENT ---');
erp = ErrRP(avPh2*avPh1*TF_z);


%% Retard de phase
rePh = RetardPhaseBode1(avPh2*avPh1*TF_z, errech1d, wgd, 10);
erp = ErrRP(rePh*avPh2*avPh1*TF_z);

%% Informations sur la stabilité
FTBO_finale = rePh*avPh2*avPh1*TF_z;
allmargin(FTBO_finale)
