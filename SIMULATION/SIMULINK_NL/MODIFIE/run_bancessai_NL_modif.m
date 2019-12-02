close all
clear all
clc


% D�crit dans �quilibre.m
% Position � l'�quilibre de la sph�re (pour tests statiques)
% xSeq = 0.000;      % Position x de la sph�re � l'�quilibre en metres
% ySeq = 0.000;      % Position y de la sph�re � l'�quilibre en metres
% 
% %Point d'op�ration choisi pour la plaque
% Axeq = 0;               %en degres
% Ayeq = 0;               %en degres
% Pzeq = .015;            %en metres

%Exemple de trajectoire
t_des     = [0:1:8]'*5;
x_des     = [t_des, [0 0 0.5 1  0 -1 0 1 0]'*0.05];
y_des     = [t_des, [0 0 0 0 -1  0 1 0 0]'*0.05];
z_des     = [t_des, [1 1 1 1  0.95  0.90 1 1 1]'*.015];
tfin = 50;




%%

%initialisation
addpath ../../../Matlab/Data
addpath ../../ERROR_DETECT
load('equilibre.mat');
load Ass_x_y.mat
load asservissement.mat

%Calcul des compensateurs
%iniCTL_ver4    %Calculez vos compensateurs ici

%simulation
open_system('simulation_NL_modif')
set_param('simulation_NL_modif','AlgebraicLoopSolver','LineSearch')
sim('simulation_NL_modif')

%affichage
%trajectoires