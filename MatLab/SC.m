%% Clean matlab
clear all;
close all;
clc;

load('systeme_matriciel.mat');
load('identification_mc.mat');
load('identification_i.mat');

bE1 = 13.029359254409743;

% Equilibrium values
Xs_eq_val = 0;
Ys_eq_val = 0;
Z0_eq_val = 0;
zke = 0;

%% symbols
syms iKe ae0 ae1 ae2 ae3 dz0 Xs_eq Ys_eq Z0_eq


dik = -(((iKe^2+bE1*iKe)*(ae1 + 2*ae2*zke))/(ae0^2 + 2*ae0*ae1*zke)) * ((ae0 + ae1*zke + ae2*zke^2 + ae3*zke^3)/(bE1+2*iKe)) * dz0;

iKe_val = subs(Ia_eq, [Xs_eq, Ys_eq, Z0_eq], [Xs_eq_val, Ys_eq_val, Z0_eq_val]);
dik = subs(dik, iKe, iKe_val);
dik = subs(dik, [ae0, ae1, ae2, ae3], Ae');
dik = subs(dik, dz0, z0);

plot(z0, dik); hold on;
plot(z0, Ie_val);