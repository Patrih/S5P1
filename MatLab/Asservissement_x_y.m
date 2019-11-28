clc;
clear all;
close all;
addpath('Data');
addpath('Functions');

% Fait par PA
% Date: 2019-11-18
% Asservissement de X,Y
% À faire :
% Les itérations pour atteindre les perf désirées

load('equilibre');
%% POUR X


ts_s = 2;
zeta = 0.9;
Wn_x = 4/(zeta*ts_s);
Kv_x = 2*zeta*Wn_x/(num_x(1,3))
Kp_x = Wn_x^2/num_x(2,2)

NUM_x = [Kp_x*num_x(2,2)];
DEN_x = [1 Kv_x*num_x(1,3) num_x(2,2)*Kp_x];

FTBF_x = tf(NUM_x,DEN_x);

% num_i = [1 0];
% den_i = [1 num_x(1,3)*Kv];
% 
% is = tf(num_i,den_i)
% 
% figure()
% margin(Kp*is*TF_x)
% figure
% rlocus(Kp*is*TF_x)
% figure
% rlocus(TF_x)
% 
% feed = feedback(Kp*is*TF_x,1);
% 
% t = linspace (0,10,10000);
% 
% x = lsim(feed,ones(size(t)),t);
% a = 1.02*ones(size(t));
% b = .98*ones(size(t));
% 
% figure()
% plot(t,x)
% hold on
% plot(t,a)
% plot(t,b)


%% POUR Y

ts_s = 2;
zeta = 0.9;
Wn_y = 4/(zeta*ts_s);
Kv_y = 2*zeta*Wn_y/(num_y(1,3))
Kp_y = Wn_y^2/num_y(2,2)

NUM_y = [Kp_y*num_y(2,2)];
DEN_y = [1 Kv_y*num_y(1,3) num_y(2,2)*Kp_y];

FTBF_y = tf(NUM_y,DEN_y);


% num_i = [1 0];
% 
% den_i = [1 num_y(1,3)*Kv];
% 
% is = tf(num_i,den_i)
% 
% figure()
% margin(Kp*is*TF_y)
% figure
% rlocus(Kp*is*TF_y)
% figure
% rlocus(TF_y)
% 
% feed = feedback(Kp*is*TF_y,1);
% 
% t = linspace (0,10,10000);
% 
% x = lsim(feed,ones(size(t)),t);
% a = 1.02*ones(size(t));
% b = .98*ones(size(t));
% 
% figure()
% plot(t,x)
% hold on
% plot(t,a)
% plot(t,b)