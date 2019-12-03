close all
clear all
clc

addpath ../../../Matlab/Functions
addpath ../../../Matlab/Data
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
% 
% x = [0 0.2 0.3 0.4 0.6 0.8].*62.5e-3;
% y = [0 0.8 0.6 0 -0.2 0].*62.5e-3;
% 
% v_al=0.05;
% v_ret = 0.05;
% ts=0.5;
% 
% [Pi_al , Ltr_al , E_al , Vr_al , Traj_al , tt_al , Traj_BE_al] = ComputeTrajectories([x' , y'] , v_al , ts , 0.015);
% [Pi_re , Ltr_re , E_re , Vr_re , Traj_re , tt_re , Traj_BE_re] = ComputeTrajectories([flip(x)' , flip(y)'] , v_ret , ts , 0.015);

load('Traj_BE_al.mat')
load('Traj_BE_re.mat')

Traj_BE_tot = CreateArrayTB(Traj_BE_al , Traj_BE_re);

t_des     = Traj_BE_tot(:,1);
x_des     = [t_des , Traj_BE_tot(:,2)];
y_des     = [t_des , Traj_BE_tot(:,3)];
z_des     = [t_des , Traj_BE_tot(:,4)];
tfin = 40 ;

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

%% FP

FP = ErreurFp(t_des , x_des , y_des , ynonlineaire , tsim);

