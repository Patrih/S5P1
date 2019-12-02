% clear all;
% close all;
% clc;

addpath('Functions');

x = (0:2:10)';
y = 10.*rand([1, 6])';
t = 0:0.1:10;

v_des = 2;
Ts = 0.5;

[Pi , Ltr , E , Vr , Traj , tt , Traj_BE] = compute_trajectories([x , y] , v_des , Ts);




plot(t,Traj)

