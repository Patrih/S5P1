% clear all;
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
Ts = Ts*25;

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
[Pi_al , Ltr , E , Vr , Traj , tt , Traj_BE_al] = ComputeTrajectories([x_al , y_al] , v_des_al , Ts , z , 0);
%retour
[Pi_re , Ltr , E , Vr , Traj , tt , Traj_BE_re] = ComputeTrajectories([x_re , y_re] , v_des_ret , Ts , z , 1);

save('Data/TRAJ_BE_al' , 'Traj_BE_al')
save('Data/TRAJ_BE_re' , 'Traj_BE_re')

save('Data/PARAMS_TRAJ' , 'Pi_al','Ltr','E','Vr','tt')



th = 0:pi/50:2*pi;
xunit = 1000.*R * cos(th);
yunit = 1000.*R * sin(th);

x_al_plot = 1000.*x_al;
y_al_plot = 1000.*y_al;

x_re_plot = 1000.*x_re;
y_re_plot = 1000.*y_re;

x_plot = [x_al_plot ; x_re_plot];
y_plot = [y_al_plot ; y_re_plot];

sign_crois_al = sign(x_al(2)-x_al(1));
x_eval_al = (x_al(1) : sign_crois_al*0.0001 : x_al(end));
y_eval_al = 1000.*polyval (Pi_al , x_eval_al);
x_eval_al = 1000.*x_eval_al;

sign_crois_re = sign(x_re(2)-x_re(1));
x_eval_re = x_re(1) : sign_crois_re*0.0001 : x_re(end);
y_eval_re = 1000.*polyval (Pi_re , x_eval_re);
x_eval_re = 1000.*x_eval_re;

x_eval_plot = [x_eval_al  x_eval_re];
y_eval_plot = [y_eval_al  y_eval_re];

R = R*1000;
% ------------------ PLOT POINTS ---------------
figure(1)
hold on
plot(xunit, yunit, 'k')
plot(x_al_plot,y_al_plot,'x r')
plot(x_re_plot,y_re_plot,'x b')       
legend('Contour de la plaque' , 'Points aller' , 'Points retour')
title('Points à suivre pour le trajet aller retour')
xlabel('Position x (mm)')
ylabel('Position y (mm)')
xlim ([1.1*-R , 1.1*R])
ylim ([1.1*-R , 1.1*R])
axis equal
hold off

% ------------------ PLOT POINTS + curve ---------------

figure(2)
hold on 

plot(xunit, yunit, 'k')
plot(x_plot,y_plot,'x k')
plot(x_eval_al , y_eval_al,'r')
plot(x_eval_re , y_eval_re,'b')
legend('Contour de la plaque' , 'Points' ,'Interpolation aller', 'Interpolation retour')
title('Trajet interpolé pour le trajet aller retour')
xlabel('Position x (mm)')
ylabel('Position y (mm)')
xlim ([1.1*-R , 1.1*R])
ylim ([1.1*-R , 1.1*R])
axis equal
hold off
    
% ------------------ PLOT POINTS + curve _ sep ---------------

figure(3)
hold on 

plot(xunit, yunit, 'k')
plot(x_plot,y_plot,'x k')
plot(x_eval_plot , y_eval_plot,'-- k')
plot(1000.*Traj_BE_al(:,2) , 1000.*Traj_BE_al (:,3),'o r')
plot(1000.*Traj_BE_re(:,2) , 1000.*Traj_BE_re (:,3),'o b')

legend('Contour de la plaque' , 'Points' ,'Interpolation', 'Trajet aller', 'Trajet retour')
title('Trajet séparé pour le trajet aller retour')
xlabel('Position x (mm)')
ylabel('Position y (mm)')
xlim ([1.1*-R , 1.1*R])
ylim ([1.1*-R , 1.1*R])
axis equal
hold off


%-------------- DONNEES FOURNIES -------------

load('Traj_BE_al_fourni')
load('Traj_BE_re_fourni')
Traj_BE_al_plot = Traj_BE_al.*1000;
Traj_BE_re_plot = Traj_BE_re.*1000;

figure
hold on 
plot(xunit, yunit , 'k');
plot(Traj_BE_al_plot(:,2) , Traj_BE_al_plot(:,3),'o r','MarkerSize',5)
plot(Traj_BE_re_plot(:,2) , Traj_BE_re_plot(:,3),'o b','MarkerSize',5)
plot(x_plot,y_plot,'x k','MarkerSize',10)
xlabel('Position x (mm)')
ylabel('Position y (mm)')
legend('Contour de la plaque'  ,'Trajet aller', 'Trajet retour', 'Points')
title('Trajet total demandé')
xlim ([1.1*-R , 1.1*R])
ylim ([1.1*-R , 1.1*R])
axis equal
hold off    




    
    
