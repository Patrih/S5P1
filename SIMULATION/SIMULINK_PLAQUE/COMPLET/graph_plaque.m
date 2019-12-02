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
figure_25  = [ 1  1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0 ];

for i = 1 : 25
    if figure_25(i) == 1
        figure(i);
        plot(tsim , ynonlineaire(: , i+1));
        xlabel ('temps (s)')
        ylabel (units(i))
        title(name(i) + " de la simulation non-linéaire en fonction du temps "  );
    end
end







