
systeme_matriciel;
close all 
clc


%% �quation d'�tat de la plaque

%aller meetre ne commentaire l'�quilibre dans systeme_matriciel si on veut
%les matrices en fonction de Z0_eq, Xs_eq et Ys_eq
syms A_plaque B_plaque C_plaque D_plaque

% �quation d'�tat       
A_plaque(1:6,1:6) = A(1:6,1:6);
A_plaque(1:6,7:9) = A(1:6,11:13);   %
A_plaque(7:9,1:6) = A(11:13,1:6);   %0
A_plaque(7:9,7:9) = A(11:13,11:13); % CC

B_plaque(1:6,1:3) = B(1:6,1:3);
B_plaque(7:9,1:3) = B(11:13,1:3);
% �quation sortie

C_plaque(1:3,4:9) = C(1:3,4:9);
D_plaque(1:3,1:3) = D(1:3,1:3);

%% �quation de la sphr�re
syms A_sphere B_sphere C_sphere D_sphere


% �quation d'�tat   
A_sphere(1:4,1:4) = A(7:10,7:10);
B_sphere(1:4,1:3) = A(7:10,1:3);    
% �quation sortie
C_sphere(1:4,1:4) = C(4:7,7:10);
       
D_sphere(1:4,1:3) = D(4:7,1:3); 



%% D�couplage des axes spheres

%syst�me sph�re axe X/ D�couplage final

syms A_sphere_x B_sphere_x C_sphere_x D_sphere_x

A_sphere_x(1,1) = A_sphere(1,1);
A_sphere_x(1,2) = A_sphere(1,3);
A_sphere_x(2,1) = A_sphere(3,1);
A_sphere_x(2,2) = A_sphere(3,3);


B_sphere_x(1,1) = B_sphere(1,2);
B_sphere_x(2,1) = B_sphere(3,2);

C_sphere_x(1,1) = C_sphere(1,1);
C_sphere_x(1,2) = C_sphere(3,3);

D_sphere_x(1,1) = D_sphere(1,2);
D_sphere_x(2,1) = D_sphere(3,2);

%syst�me sph�re axe Y/d�couplage final

syms A_sphere_y B_sphere_y C_sphere_y D_sphere_y


A_sphere_y(1,1) = A_sphere(2,2);
A_sphere_y(1,2) = A_sphere(2,4);
A_sphere_y(2,1) = A_sphere(4,2);
A_sphere_y(2,2) = A_sphere(4,4);


B_sphere_y(1,1) = B_sphere(2,1);
B_sphere_y(2,1) = B_sphere(4,1);

C_sphere_y(1,1) = C_sphere(2,2);
C_sphere_y(1,2) = C_sphere(4,4);

D_sphere_y(1,1) = D_sphere(2,1);
D_sphere_y(2,1) = D_sphere(4,1);

%D�couplage des axes de la plaque

% calcul de l'�quilbre pour le d�couplage final 

syms I_phi_eq V_phi_eq I_theta_eq V_theta_eq I_z_eq V_z_eq

%quand phi_eq,theta_eq, F_phi_eq, F_theta_eq =0

I_phi_eq = 1/2.*(-sqrt(bE1^2+4.*(Ae(1) + Ae(2)*Zk + Ae(3)*Zk.^2 + Ae(4)*Zk.^3).*(-1./(As(1) + As(2).*Zk + As(3).*Zk.^2 + As(4).*Zk.^3)+offset)));
I_phi_eq = subs(I_phi_eq,Zk,Z0_eq);

I_theta_eq = 1/2.*(-sqrt(bE1^2+4.*(Ae(1) + Ae(2)*Zk + Ae(3)*Zk.^2 + Ae(4)*Zk.^3).*(-1./(As(1) + As(2).*Zk + As(3).*Zk.^2 + As(4).*Zk.^3)+offset)));
I_theta_eq = subs(I_theta_eq,Zk,Z0_eq);


I_z_eq = 1/2.*(-sqrt(bE1^2+4.*((Ae(1) + Ae(2)*Zk + Ae(3)*Zk.^2 + Ae(4)*Zk.^3).*(-1./(As(1) + As(2).*Zk + As(3).*Zk.^2 + As(4).*Zk.^3)+offset)-masseP*g)));
I_z_eq = subs(I_z_eq,Zk,Z0_eq);



V_phi_eq = R*I_phi_eq;
V_theta_eq = R*I_theta_eq;
V_z_eq = R*I_z_eq;






