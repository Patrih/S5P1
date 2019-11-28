clear all;
close all;
clc;

addpath('Functions');

x = 0:2:10;
y = rand([1, 6]);
t = 0:0.1:10;

%% Interpolation de la trajectoire
[C, L] = InterpolationLagrange(x, y);

f_sym = poly2sym(C);
df_sym = diff(f_sym);

%% Calcul de la longueur
g_sym = sqrt(1 + df_sym^2);
L = Trapeze(g_sym, t(2) - t(1), 0)';

%% Calcul de la vitesse
vel = diff(L)./diff(t(1: end-1));

%% Coucou, ça n'a aucun sens.
figure;
hold on;
plot(x, y, 'ro');
plot(t, f, 'b');

figure;
plot(t(1:end-1), L, 'b');