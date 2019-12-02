clear all;
close all;
clc;

%Fait par : Louis-D
%Date : 2019-12-02
%Description: Script d'appel de la fonciton de génération de trajectoire
%Reste a faire: 
% - Erreur :(
% - 
% - 


addpath('Functions');

% input for the radius of the test bench and the number of wanted input
% points

R = 0.0625;
N_pts = 6;

x = (0:R/N_pts:R-R/N_pts).';
y = ones(size(x));
y(1) = 0;


%loop generating y values and assuring they are not outside the radius

for i = 2 : N_pts
    while sqrt((x(i)^2+y(i)^2)) > R;
        y(i) = R*rand([1,1]) ;
    end
end

%Input for the back and forth speeds and Period

v_des_al = 1;
v_des_ret = 0.5;
Ts = 0.01;

z = 0.015;

% th = 0:pi/50:2*pi;
% xunit = R * cos(th);
% yunit = R * sin(th);
% 
% figure
% hold on
% plot(x , y)
% plot(xunit, yunit)
% axis equal
% hold off


%aller
[Pi , Ltr , E , Vr , Traj , tt , Traj_BE] = ComputeTrajectories([x , y] , v_des_al , Ts , z);
%retour
[Pi , Ltr , E , Vr , Traj , tt , Traj_BE] = ComputeTrajectories([flip(x) , flip(y)] , v_des_ret , Ts , z);

save('Data/TRAJ_OUT' , 'Traj')
save('Data/PARAMS_TRAJ' , 'Pi','Ltr','E','Vr','tt')




