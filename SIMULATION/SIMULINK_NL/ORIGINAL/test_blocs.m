% BLOC TEST ; DO NOT USE AS OFFICIAL DOCUMENT
%             |            00            |             10             |       20        |      
%figure        1  2  3  4  5  6  7  8  9  0  1  2  3  4  5  6  7  8  9  0  1  2  3  4  5
%name          Ax Ay Pz Wx Wy Vz Px Py Vx Vy IA IB IC Za Zb Zc Zd Ze Zf FA FB FC VA VB VC
%figure_25  = [ 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1 ];

%% Xa Xb Xc
close all
clc
% Ax Ay Vz
phi   = ynonlineaire(: , 1);
theta = ynonlineaire(: , 2);
z     = ynonlineaire(: , 3);

%------ BLOC ------
zA = z - XA*theta + YA*phi;

zB = z - XB*theta + YB*phi;

zC = z - XC*theta + YC*phi;
%------------------

% zA zB zC
figure()
hold on
plot (tsim , ynonlineaire(: , 14))
plot (tsim , zA,'--')
legend('OR' , 'FCT')
hold off

figure()
hold on
plot (tsim , ynonlineaire(: , 15))
plot (tsim , zB,'--')
legend('OR' , 'FCT')
hold off

figure()
hold on
plot (tsim , ynonlineaire(: , 16))
plot (tsim , zC,'--')
legend('OR' , 'FCT')
hold off
%% Xd Xe Xf
close all
clc
% Ax Ay Vz
phi   = ynonlineaire(: , 1);
theta = ynonlineaire(: , 2);
z     = ynonlineaire(: , 3);

%------ BLOC ------
zD = z - XD*theta + YD*phi;

zE = z - XE*theta + YE*phi;

zF = z - XF*theta + YF*phi;
%------------------

% zD zE zF
figure()
hold on
plot (tsim , ynonlineaire(: , 17))
plot (tsim , zD,'--')
legend('OR' , 'FCT')
hold off

figure()
hold on
plot (tsim , ynonlineaire(: , 18))
plot (tsim , zE,'--')
legend('OR' , 'FCT')
hold off

figure()
hold on
plot (tsim , ynonlineaire(: , 19))
plot (tsim , zF,'--')
legend('OR' , 'FCT')
hold off

%% Fi
close all
clc

z = ynonlineaire(: , 14);
i = ynonlineaire(: , 11);

FSK = offset-1./(as0 + as1.*z + as2.*z.^2 +as3.*z.^3);

FEK = ((i.^2 + be1.*abs(i)).*sign(i))./(ae0 + ae1.*z + ae2.*z.^2 +ae3.*z.^3);

F = FEK + FSK;

figure()
hold on
plot (tsim , ynonlineaire(: , 20))
plot (tsim , F,'--')
legend('OR' , 'FCT')
hold off

%% Vz
close all
clc

FA = ynonlineaire(: , 20);
FB = ynonlineaire(: , 21); 
FC = ynonlineaire(: , 22); 

Az = (FA + FB + FC + mS*g + mP*g)/mP;

Az_OR = diff(ynonlineaire(: , 6))./diff(tsim);

figure()
hold on
plot (tsim(1:end-1) , Az_OR)
plot (tsim , Az,'--')
legend('OR' , 'FCT')
hold off

figure()
plot (tsim , ynonlineaire(: , 6))
legend('Vz')

figure()
plot (tsim , Az)
legend('Az')


%% Ax
close all
clc

FA = ynonlineaire(: , 20);
FB = ynonlineaire(: , 21); 
FC = ynonlineaire(: , 22); 
Ys = ynonlineaire(: , 8);

Ax = (1/Jx)*(FA*YA + FB*YB + FC*YC + mS*g*Ys);

Ax_OR = diff(ynonlineaire(: , 4))./diff(tsim);

figure()
hold on
plot (tsim(1:end-1) , Ax_OR)
plot (tsim , Ax,'--')
legend('OR' , 'FCT')
hold off



%% Ay
close all
clc

FA = ynonlineaire(: , 20);
FB = ynonlineaire(: , 21); 
FC = ynonlineaire(: , 22); 
Xs = ynonlineaire(: , 7);

Ay = (1/Jx)*(-FA*XA - FB*XB - FC*XC - Xs*mS*g);

Ay_OR = diff(ynonlineaire(: , 5))./diff(tsim);

figure()
hold on
plot (tsim(1:end-1) , Ay_OR)
plot (tsim , Ay,'--')
legend('OR' , 'FCT')
hold off

%% I
IA = ynonlineaire(: , 11);
VA = ynonlineaire(: , 23); 

di_1 = VA/LL - RR/LL*IA;

di_2 = diff(IA)./diff(tsim);

figure()
hold on
plot (tsim(1:end-1) , di_2)
plot (tsim , di_1,'--')
legend('OR' , 'FCT')
hold off

%% Vx

Ay = ynonlineaire(: , 2);
Vx_dot = Ay *-5*g/7;

Vx_dot_OR = diff(ynonlineaire(: , 9))./diff(tsim);

figure()
hold on
plot (tsim(1:end-1) , Vx_dot_OR)
plot (tsim , Vx_dot,'--')
legend('OR' , 'FCT')
hold off

%% Vy

Ax = ynonlineaire(: , 1);
Vy_dot = Ax *5*g/7;

Vy_dot_OR = diff(ynonlineaire(: , 10))./diff(tsim);

figure()
hold on
plot (tsim(1:end-1) , Vy_dot_OR)
plot (tsim , Vy_dot,'--')
legend('OR' , 'FCT')
hold off
