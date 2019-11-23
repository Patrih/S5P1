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
cas = 2;

% Avance de phase
[avPh1, ~] = AvancePhaseBode1(TF_z, PMd, wgd, 5);

% Deuxième avance de phase
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

% Erreur en régime permanent

feed = feedback(FTBO_finale,1);
x = linspace (0,.25,10000)';
y = lsim(feed,ones(size(x)),x);
plot(x,y);
hold on
plot(x,ones(size(x)));

disp('--- ERREUR EN RÉGIME PERMANENT ---');
erp = ErrRP(FTBO_finale)

%% Ré-ajustement des poles
compensateurs = PI*avPh2*avPh1;

[zeroes, poles, gain] = tf2zp(compensateurs.Numerator{:}, compensateurs.Denominator{:});
poles(2) = -800;
[num_comp, den_comp] = zp2tf(zeroes, poles, gain);

compensateurs_new = tf(num_comp, den_comp);

[z, p, gain_new] = tf2zp(compensateurs_new.Numerator{:}, compensateurs_new.Denominator{:});

ratio = gain_new/gain;
compensateurs_new = compensateurs_new * ratio;

%% 
figure(55)
margin(compensateurs_new*TF_z)
%% Informations sur la stabilité

% allmargin(FTBO_finale)
% testdiscret(compensateurs_new)
