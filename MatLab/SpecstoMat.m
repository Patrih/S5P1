clc
clear all
close all

syms Fk
syms Ik Zk
syms Xk Yk
syms Ia_eq Ib_eq Ic_eq

Rabc_ini = 95.2e-3; %mm
Xa =  Rabc_ini;
Ya =  0;
Xb = -Rabc_ini*sind(30);
Yb =  Rabc_ini*cosd(30);
Xc = -Rabc_ini*sind(30);
Yc = -Rabc_ini*cosd(30);

masseP = 442e-3;
masseS = 8e-3;
J = 1347e-6;
g = 9.81;
R = 3.6;
L = 115e-3;


save('Data/Spec.mat')