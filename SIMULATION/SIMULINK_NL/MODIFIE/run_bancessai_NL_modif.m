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

%Points du prof 
x=[0]*62.5e-3;
y=[0]*62.5e-3;
v=0.01;
ts=2;


[Pi , Ltr , E , Vr , Traj , tt , Traj_BE] = ComputeTrajectories([x' , y'] , v , ts , 0.015);


t_des     = Traj_BE(:,1);
x_des     = [t_des , Traj_BE(:,2)];
y_des     = [t_des , Traj_BE(:,3)];
z_des     = [t_des , Traj_BE(:,4)];
tfin = 50;

% t_des     = [0:1:8]'*5;
% x_des     = [t_des, [0 0 0.5 1  0 -1 0 1 0]'*0.05];
% y_des     = [t_des, [0 0 0 0 -1  0 1 0 0]'*0.05];
% z_des     = [t_des, [1 1 1 1  0.95  0.90 1 1 1]'*.015];
% tfin = 50;



%%

%initialisation
addpath ../../../Matlab/Data
load Ass_x_y.mat
load asservissement.mat
addpath ../../ERROR_DETECT
load('equilibre.mat');


%Calcul des compensateurs
%iniCTL_ver4    %Calculez vos compensateurs ici

%simulation
open_system('simulation_NL_modif')
set_param('simulation_NL_modif','AlgebraicLoopSolver','LineSearch')
sim('simulation_NL_modif')

%affichage
%trajectoires