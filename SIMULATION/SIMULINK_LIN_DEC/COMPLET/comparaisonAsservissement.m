clc   
close all
clear all

load Tamp

%%           1   2    3    4     5    6   7    8    10   11   12   13   14   15   16   17   18
% name = [ "Er","Ax","Ay","Pz","Px","Py","Vx","Vy","Za","Zb","Zc","Zd","Ze","Zf","Va","Vb","Vc"];

t_des     = [0:1:8]'*5;
x_des     = [t_des, [0 0 0.5 1  0 -1 0 1 0]'*0.05];
y_des     = [t_des, [0 0 0 0 -1  0 1 0 0]'*0.05];
z_des     = [t_des, [1 1 1 1  1  1 1 1 1]'*.015];
t_des_traj = [0 5 10 10 15 15 20 20 25 25  30  30 35 35 40 40 45 50];
x_des_traj = [0 0 0  25 25 50 50 0  0  -50 -50 0  0  50 50 0  0  0]./1e3;
y_des_traj = [0 0 0  0  0  0  0  -50 -50 0 0   50 50 0  0  0  0  0]./1e3;
tfin = 50;


% figure()
% hold on
% plot(t_des_traj,x_des_traj)
% plot(Phi1PI_nonlineaire(:,end),Phi1PI_nonlineaire(:,5))
% plot(Phi2PI_nonlineaire(:,end),Phi2PI_nonlineaire(:,5))
% plot(Phi1RE_nonlineaire(:,end),Phi1RE_nonlineaire(:,5))
% plot(Phi2RE_nonlineaire(:,end),Phi2RE_nonlineaire(:,5))
% legend('x_des','Phi1PI','Phi2PI','Phi1RE','Phi2RE')

figure()
hold on
plot(t_des_traj,x_des_traj)
plot(Phi2PI_nonlineaire(:,end),Phi2PI_nonlineaire(:,5))
plot(JB_nonlineaire(:,end),JB_nonlineaire(:,5))
legend('x_des','Phi2PI','JB')





