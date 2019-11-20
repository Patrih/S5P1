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
Wn = 4/(zeta*ts_s);
Kv = 2*zeta*Wn/(num_x(1,3))
Kp = Wn^2/num_x(2,2)

num = [Kp*num_x(2,2)];
den = [1 Kv*num_x(1,3) num_x(2,2)*Kp];

num_i = [1 0 0];
den_i = [1 num_x(1,3)*Kv 0];

is = tf(num_i,den_i)

figure()
margin(Kp*is*TF_x)
figure
rlocus(Kp*is*TF_x)
figure
rlocus(TF_x)

feed = feedback(Kp*is*TF_x,1);

t = linspace (0,10,10000);

x = lsim(feed,ones(size(t)),t);
a = 1.02*ones(size(t));
b = .98*ones(size(t));

figure()
plot(t,x)
hold on
plot(t,a)
plot(t,b)


%% POUR Y


ts_s = 2;
zeta = 0.9;
Wn = 4/(zeta*ts_s);
Kv = 2*zeta*Wn/(num_y(1,3))
Kp = Wn^2/num_y(2,2)

num = [Kp*num_y(2,2)];
den = [1 Kv*num_y(1,3) num_y(2,2)*Kp];

num_i = [1 0 0];
den_i = [1 num_y(1,3)*Kv 0];

is = tf(num_i,den_i)

figure()
margin(Kp*is*TF_y)
figure
rlocus(Kp*is*TF_y)
figure
rlocus(TF_y)

feed = feedback(Kp*is*TF_y,1);

t = linspace (0,10,10000);

x = lsim(feed,ones(size(t)),t);
a = 1.02*ones(size(t));
b = .98*ones(size(t));

figure()
plot(t,x)
hold on
plot(t,a)
plot(t,b)




%%

%de 2 a 4
FTBO = TF_y;
[num,den] = tfdata(FTBO,'v');


ts_s = 4;
zeta = 0.9;

Wn = 5.2/(zeta*ts_s);
phi = acosd(zeta);
poles = [-Wn*zeta+Wn*sqrt(1-zeta^2)*1i -Wn*zeta-Wn*sqrt(1-zeta^2)*1i];


plot(real(poles(1)),imag(poles(1)),'p')
hold on
rlocus(FTBO)


delta_phi = rad2deg(-pi - angle(polyval(num,poles(1))) + angle(polyval(den,poles(1))))-12;

alpha = 180-phi;

phi_z = (alpha + delta_phi)/2;
phi_p = (alpha - delta_phi)/2;

zero_v = real(poles(1))-imag(poles(1))/tand(phi_z);
pole_v = real(poles(1))-imag(poles(1))/tand(phi_p);

num_c = [1 -zero_v];
den_c = [1 -pole_v];

Gc = tf (num_c,den_c);

Gs_v = polyval(num,poles(1))/polyval(den,poles(1));
Gc_v = (poles(1)-zero_v)/(poles(1)-pole_v);


Ka = 1/abs(Gc_v*Gs_v);


 rlocus(Gc*FTBO)

figure
margin(Gc*FTBO)


feed = feedback(Gc*FTBO,1);


t = linspace (0,10,10000);

x = lsim(feed,ones(size(t)),t);
a = 1.02*ones(size(t));
b = .98*ones(size(t));

% figure
% plot(t,x)
% hold on
% plot(t,a)
% plot(t,b)







