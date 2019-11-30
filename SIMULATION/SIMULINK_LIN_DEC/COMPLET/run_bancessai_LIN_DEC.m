close all
clear all
clc
%Ces valeurs sont d�crites dans le fichier �quilibre.m pour des questions
%d'int�gration

% % Position � l'�quilibre de la sph�re (pour tests statiques)
% sig = 1.0;         % Pr�sence (1) ou non (0) de la sph�re
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
z_des     = [t_des, [1 1 1 1  1  1 1 1 1]'*.015];
tfin = 50;




%initialisation
addpath ../../../Matlab/Data
addpath ../../ERROR_DETECT
load('equilibre.mat');
load Ass_x_y.mat
load asservissement.mat



%------- AJOUTER LES INITIALISATIONS DES MATRICES ABCD ICI ----------------


%Calcul des compensateurs
%iniCTL_ver4    %Calculez vos compensateurs ici

%simulation
open_system('simulation_LIN_DEC')
set_param('simulation_LIN_DEC','AlgebraicLoopSolver','LineSearch')
sim('simulation_LIN_DEC')

%affichage
%trajectoires