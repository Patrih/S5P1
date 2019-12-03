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
figure_25  = [ 1  1  0  0  0  0  1  1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0 ];

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
legend( 'Trajectoire simul�e' , 'Trajectoire demand�e','Location','southeast')
hold off


figure(8);
hold on
plot(t_plot, y_plot)
legend( {'Trajectoire simul�e' , 'Trajectoire demand�e'},'Location','northeast')
hold off






