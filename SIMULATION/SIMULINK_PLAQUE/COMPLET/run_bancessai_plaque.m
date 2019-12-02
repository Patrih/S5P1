close all
clear all
clc

addpath ../../../Matlab/Functions
% Décrit dans équilibre.m
% Position à l'équilibre de la sphère (pour tests statiques)
% xSeq = 0.000;      % Position x de la sphère à l'équilibre en metres
% ySeq = 0.000;      % Position y de la sphère à l'équilibre en metres
% 
% %Point d'opération choisi pour la plaque
% Axeq = 0;               %en degres
% Ayeq = 0;               %en degres
% Pzeq = .015;            %en metres

%Exemple de trajectoire

t_des     = [0:1:8]'*5;
Ax_des     = [t_des, [0 0 0.5 1  0 -1 0 1 0]'*0.0436];
Ay_des     = [t_des, [0 0 0 0 -1  0 1 0 0]'*0.0436];
z_des     = [t_des, [1 1 1 1 1 1 1 1 1]'*.015];
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
open_system('simulation_plaque')
set_param('simulation_plaque','AlgebraicLoopSolver','LineSearch')
sim('simulation_plaque')

%affichage
%trajectoires