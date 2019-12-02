clear all;
close all;
clc;

addpath('Functions');

R = 0.0625;
N_pts = 6;

x = (0:R/N_pts:R-R/N_pts).';
y = ones(size(x));
y(1) = 0;

for i = 2 : N_pts
    while sqrt((x(i)^2+y(i)^2)) > R;
        y(i) = R*rand([1,1]) ;
    end
end



t = 0:0.1:10;

v_des_al = 1;
v_des_ret = 1;
Ts = 0.01;

th = 0:pi/50:2*pi;
xunit = R * cos(th);
yunit = R * sin(th);

figure
hold on
plot(x , y)
plot(xunit, yunit)
axis equal
hold off

[Pi , Ltr , E , Vr , Traj , tt , Traj_BE] = ComputeTrajectories([x , y] , v_des_al , Ts);

save('TRAJ_OUT' , 'Traj')
save('PARAMS_TRAJ' , 'Pi','Ltr','E','Vr','tt')




