close all
clc
name = [ "Ax" , "Ay" , "Pz" , "Wx" , "Wy" , "Vz" , "Px" , "Py" , "Vx" , "Vy" , "IA" , "IB" , "IC" , "Za" , "Zb" , "Zc" , "Zd" , "Ze" , "Zf" , "FA" , "FB" , "FC" , "VA" , "VB" , "VC"];

units= ["Erreur" ,"angle(rad)" ,"angle(rad)" , "position(m)" , "position(m)" , "position(m)" ,"vitesse (m/s)" , "vitesse (m/s)" ,"position(m)" ,"position(m)","position(m)","position(m)","position(m)","position(m)","Tension(V)","Tension(V)","Tension(V)"];

%             |            00            |             10           
%figure        1  2  3  4  5  6  7  8  9  0  1  2  3  4  5  6  7
%name          Er Ax Ay Pz Px Py Vx Vy Za Zb Zc Zd Ze Zf VA VB VC
%figure_25  = [ 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1];

%             |            00            |             10           
%figure        1  2  3  4  5  6  7  8  9  0  1  2  3  4  5  6  7
%name          Er Ax Ay Pz Px Py Vx Vy Za Zb Zc Zd Ze Zf VA VB VC
figure_25  = [ 0  0  0  0  1  1  0  0  0  0  0  0  0  0  0  0  0 ];

for i = 1 : 17
    if figure_25(i) == 1
        figure(i);
        plot(tsim , ynonlineaire(: , i));
        xlabel ('temps (s)')
        ylabel (units(i))
        title(name(i) + " de la simulation lin�aire d�coupl�e en fonction du temps "  );
    end
end

t_des_traj = [0 5 10 10 15 15 20 20 25 25  30  30 35 35 40 40 45 50];
x_des_traj = [0 0 0  25 25 50 50 0  0  -50 -50 0  0  50 50 0  0  0]./1e3;
y_des_traj = [0 0 0  0  0  0  0  -50 -50 0 0   50 50 0  0  0  0  0]./1e3;

figure(5);
hold on
plot(t_des_traj , x_des_traj)
legend( 'Trajectoire simul�e' , 'Trajectoire demand�e','Location','southwest')
hold off

figure(6);
hold on
plot(t_des_traj , y_des_traj)
legend( {'Trajectoire simul�e' , 'Trajectoire demand�e'},'Location','northwest')
hold off

