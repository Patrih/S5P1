close all
clc
name = [ "Ax" , "Ay" , "Pz" , "Wx" , "Wy" , "Vz" , "Px" , "Py" , "Vx" , "Vy" , "IA" , "IB" , "IC" , "Za" , "Zb" , "Zc" , "Zd" , "Ze" , "Zf" , "FA" , "FB" , "FC" , "VA" , "VB" , "VC"];

units= ["angle(rad)" ,"angle(rad)" , "position(m)" , "vitesse angulaire (rad/s)" , "vitesse angulaire (rad/s)" , "vitesse (m/s)" , "position(m)" , "position(m)" ,"vitesse (m/s)" , "vitesse (m/s)" , "Courant (A)" , "Courant (A)","Courant (A)" ,"position(m)" ,"position(m)","position(m)","position(m)","position(m)","position(m)", "force (N)", "force (N)","force (N)","Tension(V)","Tension(V)","Tension(V)"];

%             |            00            |             10             |       20        |      
%figure        1  2  3  4  5  6  7  8  9  0  1  2  3  4  5  6  7  8  9  0  1  2  3  4  5
%name          Ax Ay Pz Wx Wy Vz Px Py Vx Vy IA IB IC Za Zb Zc Zd Ze Zf FA FB FC VA VB VC
%figure_25  = [ 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1 ];

%             |            00            |             10             |       20        |      
%figure        1  2  3  4  5  6  7  8  9  0  1  2  3  4  5  6  7  8  9  0  1  2  3  4  5
%name          Ax Ay Pz Wx Wy Vz Px Py Vx Vy IA IB IC Za Zb Zc Zd Ze Zf FA FB FC VA VB VC
figure_25  = [ 0  0  0  0  0  0  1  1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0 ];

for i = 1 : 25
    if figure_25(i) == 1
        figure(i);
        plot(tsim , ynonlineaire(: , i+1));
        xlabel ('temps (s)')
        ylabel (units(i))
        title(name(i) + " de la simulation non-lin�aire en fonction du temps "  );
    end
end

% t_des_traj = [0 5 10 10 15 15 20 20 25 25  30  30 35 35 40 40 45 50];
% x_des_traj = [0 0 0  25 25 50 50 0  0  -50 -50 0  0  50 50 0  0  0]./1e3;
% y_des_traj = [0 0 0  0  0  0  0  -50 -50 0 0   50 50 0  0  0  0  0]./1e3;
% 
% figure(7);
% hold on
% plot(t_des_traj , x_des_traj)
% legend( 'Trajectoire simul�e' , 'Trajectoire demand�e','Location','southwest')
% hold off
% 
% figure(8);
% hold on
% plot(t_des_traj , y_des_traj)
% legend( {'Trajectoire simul�e' , 'Trajectoire demand�e'},'Location','northwest')
% hold off
R = 0.0625;

x_plot(1) = x_des(1,2);
y_plot(1) = y_des(1,2);
z_plot(1) = z_des(1,2);
t_plot(1) = t_des(1);

for i = 2:length(t_des)
    
    x_plot(2*i-2) = x_des(i-1,2);
    x_plot(2*i-1) = x_des(i,2);
    
    y_plot(2*i-2) = y_des(i-1,2);
    y_plot(2*i-1) = y_des(i,2);
    
    z_plot(2*i-2) = z_des(i-1,2);
    z_plot(2*i-1) = z_des(i,2);
    
    t_plot(2*i-2) = t_des(i);
    t_plot(2*i-1) = t_des(i);
end
t_plot(2*length(t_des)) = tfin;
x_plot(2*length(t_des)) = x_plot(2*length(t_des)-1);
y_plot(2*length(t_des)) = y_plot(2*length(t_des)-1);
z_plot(2*length(t_des)) = z_plot(2*length(t_des)-1);

figure(7);
hold on
plot(t_plot, x_plot)
legend( 'Trajectoire simul�e' , 'Trajectoire demand�e','Location','northwest')
hold off


figure(8);
hold on
plot(t_plot, y_plot)
legend( {'Trajectoire simul�e' , 'Trajectoire demand�e'},'Location','southwest')
hold off

sep = 165000;
th = 0:pi/50:2*pi;
xunit = 0.0625 * cos(th);
yunit = 0.0625 * sin(th);

plot_1 = 3040;

figure
hold on 
plot(xunit, yunit , 'k')
plot(x_plot(1:plot_1), y_plot(1:plot_1) , 'b')
plot(ynonlineaire(1:sep , 8), ynonlineaire(1:sep , 9), 'r')
plot(ynonlineaire(1 , 8), ynonlineaire(1 , 9),'o g');
plot(ynonlineaire(sep , 8), ynonlineaire(sep , 9),'x g');
legend('Contour de la plaque','Trajectoire demand�e' , 'Trajectoire simul�e','D�but' , 'Fin');
title('Comparaison de la position de demand�e et simul�e de l''aller')
xlabel('position x (m)')
ylabel('position y (m)')
xlim ([1.1*-R , 1.1*R])
ylim ([1.1*-R , 1.1*R])
axis equal
hold off  

figure
hold on 
plot(xunit, yunit , 'k')
plot(x_plot(plot_1:end), y_plot(plot_1:end) , 'b')
plot(ynonlineaire(sep:end , 8), ynonlineaire(sep:end , 9), 'r')
plot(ynonlineaire(sep , 8), ynonlineaire(sep , 9),'o g');
plot(ynonlineaire(end , 8), ynonlineaire(end , 9),'x g');
title('Comparaison de la position de demand�e et simul�e du retour')
legend('Contour de la plaque','Trajectoire demand�e' , 'Trajectoire simul�e','D�but' , 'Fin');
xlabel('position x (m)')
ylabel('position y (m)')
xlim ([1.1*-R , 1.1*R])
ylim ([1.1*-R , 1.1*R])
axis equal
hold off 

