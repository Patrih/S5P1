clc;
clear all;
close all;
addpath('Data');
addpath('Functions');

% Fait par Louis Etienne
% Date: 2019-11-18
% Asservissement de Z
% � faire :
% Les it�rations pour atteindre les perf d�sir�es

load('equilibre');

%% D�finitions
PMd = 25;
wgd = 185;
errech1d = -0.0004;
errech2d = 0;
cas = 2;

% Avance de phase
[avPh1, ~] = AvancePhaseBode1(TF_z, PMd, wgd, 5);

% Deuxi�me avance de phase
[avPh2, ~] = AvancePhaseBode1(avPh1*TF_z, PMd, wgd, 10);
margin(avPh2*avPh1*TF_z);

% Retard de phase
if (cas == 1)
    rePh = RetardPhaseBode1(avPh2*avPh1*TF_z, errech1d, wgd, 10);
    FTBO_finale = rePh*avPh2*avPh1*TF_z;
elseif (cas == 2)
    PI = PIBode(wgd, 10);
    FTBO_finale = PI*avPh2*avPh1*TF_z;
end

% Erreur en r�gime permanent

feed = feedback(FTBO_finale,1);
x = linspace (0,.25,10000)';
y = lsim(feed,ones(size(x)),x);
plot(x,y);
hold on
plot(x,ones(size(x)));

disp('--- ERREUR EN R�GIME PERMANENT ---');
erp = ErrRP(FTBO_finale)

%% Informations sur la stabilit�

% allmargin(FTBO_finale)
testdiscret(FTBO_finale)