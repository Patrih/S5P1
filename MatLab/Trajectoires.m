% clear all;
% close all;
% clc;

%Fait par : Louis-D
%Date : 2019-12-02
%Description: Script d'appel de la fonciton de génération de trajectoire
%Reste a faire: 
% - Erreur :(
% - 
% - 


addpath('Functions');
addpath('Data');

load('trajectoire.mat');

% input for the radius of the test bench and the number of wanted input
% points

R = 0.0625;
N_pts = 6;

% x = (0:R/N_pts:R-R/N_pts).';
% y = ones(size(x));
% y(1) = 0;
% 
% 
% %loop generating y values and assuring they are not outside the radius
% 
% for i = 2 : N_pts
%     while sqrt((x(i)^2+y(i)^2)) > R;
%         y(i) = R*rand([1,1]) ;
%     end
% end

x_al = NAB(:,1) ;
y_al = NAB(:,2) ;

x_re = NBA(:,1) ;
y_re = NBA(:,2) ;


%Input for the back and forth speeds and Period
v_des_al = vAB;
v_des_ret = vBA;
Ts = Ts;

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


% %aller
% [Pi , Ltr , E , Vr , Traj , tt , Traj_BE_al] = ComputeTrajectories([x_al , y_al] , v_des_al , Ts , z);
% %retour
% [Pi , Ltr , E , Vr , Traj , tt , Traj_BE_re] = ComputeTrajectories([x_re , y_re] , v_des_ret , Ts , z);
% 
% save('Data/TRAJ_BE_al' , 'Traj_al')
% save('Data/TRAJ_BE_re' , 'Traj_re')
% 
% save('Data/PARAMS_TRAJ' , 'Pi','Ltr','E','Vr','tt')

th = 0:pi/50:2*pi;
xunit = R * cos(th);
yunit = R * sin(th);

load('Traj_BE_al')
load('Traj_BE_re')

figure
hold on 
plot(x_al , y_al , 'x')
plot(x_re , y_re , 'x')
plot(Traj_BE_al(:,2) , Traj_BE_al(:,3),'o')
plot(Traj_BE_re(:,2) , Traj_BE_re(:,3),'o')
plot(xunit, yunit)
plot(x_al,y_al,'x')
plot(x_re,y_re,'x')
xlim ([1.1*-R , 1.1*R])
ylim ([1.1*-R , 1.1*R])
axis equal
hold off    
    
    
    
