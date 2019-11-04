
IDENTIFICATION_MC;
close all
clc

syms Fk
syms Ik Zk
syms Xk Yk
syms Ia_eq Ib_eq Ic_eq

Rabc_ini = 95.2e-3; %mm
Xa =  Rabc_ini;
Ya =  0;
Xb = -Rabc_ini*sind(30);
Yb =  Rabc_ini*cosd(30);
Xc = -Rabc_ini*sind(30);
Yc = -Rabc_ini*cosd(30);
masseP = 442e-3;
masseS = 8e-3;
J = 1347e-6;
g = 9.81;
R = 3.6;
L = 115e-3;
%% calcul de l'équilibre avec sphère/horizontale
syms FS FP FA FB FC FA_eq FB_eq FC_eq Xs_eq Ys_eq

FB = FC+Ys_eq*FS/-Yb;
FA = FC + Ys_eq*Xb/-Yb*FS+Xs_eq*FS;


FC_eq = solve(0 == FA+FB+FC+FS+FP, FC);
FB_eq = FC_eq+Ys_eq*FS/-Yb;
FA_eq = FC_eq + Ys_eq*Xb/-Yb*FS+Xs_eq*FS;



FA_eq = subs(FA_eq,[FS FP],[masseS*g masseP*g]);
FB_eq = subs(FB_eq,[FS FP],[masseS*g masseP*g]);
FC_eq = subs(FC_eq,[FS FP],[masseS*g masseP*g]);


% Condition d'équilibre
phi_eq = 0;
theta_eq = 0;
syms Z0_eq
Dphi_eq = 0;
Dtheta_eq = 0;
DZ0_eq = 0;
syms Xs_eq
syms Ys_eq
DXs_eq = 0;
DYs_eq =0;

  Ia_eq = 1/2.*(-sqrt(bE1^2+4.*(Ae(1) + Ae(2)*Zk + Ae(3)*Zk.^2 + Ae(4)*Zk.^3).*(-1./(As(1) + As(2).*Zk + As(3).*Zk.^2 + As(4).*Zk.^3)+offset)-4.*(Ae(1) + Ae(2)*Zk + Ae(3)*Zk.^2 + Ae(4)*Zk.^3).*FA_eq)+bE1);
  Ia_eq = subs(Ia_eq,Zk,Z0_eq-Xk*theta_eq+Yk*phi_eq);
  Ia_eq = subs(Ia_eq,[Xk Yk],[Xa Ya]);
  
  Ib_eq = 1/2.*(-sqrt(bE1^2+4.*(Ae(1) + Ae(2)*Zk + Ae(3)*Zk.^2 + Ae(4)*Zk.^3).*(-1./(As(1) + As(2).*Zk + As(3).*Zk.^2 + As(4).*Zk.^3)+offset)-4.*(Ae(1) + Ae(2)*Zk + Ae(3)*Zk.^2 + Ae(4)*Zk.^3).*FB_eq)+bE1);
  Ib_eq = subs(Ib_eq,Zk,Z0_eq-Xk*theta_eq+Yk*phi_eq);
  Ib_eq = subs(Ib_eq,[Xk Yk],[Xb Yb]);
  
  Ic_eq = 1/2.*(-sqrt(bE1^2+4.*(Ae(1) + Ae(2)*Zk + Ae(3)*Zk.^2 + Ae(4)*Zk.^3).*(-1./(As(1) + As(2).*Zk + As(3).*Zk.^2 + As(4).*Zk.^3)+offset)-4.*(Ae(1) + Ae(2)*Zk + Ae(3)*Zk.^2 + Ae(4)*Zk.^3).*FC_eq)+bE1);
  Ic_eq = subs(Ic_eq,Zk,Z0_eq-Xk*theta_eq+Yk*phi_eq);
  Ic_eq = subs(Ic_eq,[Xk Yk],[Xc Yc]);

  Va_eq = Ia_eq*R;
  Vb_eq = Ib_eq*R;
  Vc_eq = Ic_eq*R;



%% Remplacement dans les matrices 

Fk = (Ik*abs(Ik) + bE1*Ik)/(Ae(1) + Ae(2)*Zk + Ae(3)*Zk^2 + Ae(4)*Zk^3)+(-1/(As(1) + As(2)*Zk + As(3)*Zk^2 + As(4)*Zk^3)+offset);

Fk = subs (Fk,Zk,Z0_eq-Xk*theta_eq+Yk*phi_eq);

DFk_Dtheta = diff(Fk,theta_eq);
DFk_Dphi = diff(Fk,phi_eq);
DFk_Dz = diff(Fk,Z0_eq);
DFk_DI = diff(Fk,Ik);

DFa_Dphi = subs(DFk_Dphi,[Ik Xk Yk],[Ia_eq Xa Ya]);
DFb_Dphi = subs(DFk_Dphi,[Ik Xk Yk],[Ib_eq Xb Yb]);
DFc_Dphi = subs(DFk_Dphi,[Ik Xk Yk],[Ic_eq Xc Yc]);

DFa_Dtheta = subs(DFk_Dtheta,[Ik Xk Yk],[Ia_eq Xa Ya]);
DFb_Dtheta = subs(DFk_Dtheta,[Ik Xk Yk],[Ib_eq Xb Yb]);
DFc_Dtheta = subs(DFk_Dtheta,[Ik Xk Yk],[Ic_eq Xc Yc]);

DFa_Dz = subs(DFk_Dz,[Ik Xk Yk],[Ia_eq Xa Ya]);
DFb_Dz = subs(DFk_Dz,[Ik Xk Yk],[Ib_eq Xb Yb]);
DFc_Dz = subs(DFk_Dz,[Ik Xk Yk],[Ic_eq Xc Yc]);

DFa_DIa = subs(DFk_DI,[Ik Xk Yk],[Ia_eq Xa Ya]);
DFb_DIb = subs(DFk_DI,[Ik Xk Yk],[Ib_eq Xb Yb]);
DFc_DIc = subs(DFk_DI,[Ik Xk Yk],[Ic_eq Xc Yc]);


DOphidot_Dphi     = 1/J*(Ya*DFa_Dphi + Yb*DFb_Dphi + Yc*DFc_Dphi);
DOphidot_Dtheta   = 1/J*(Ya*DFa_Dtheta + Yb*DFb_Dtheta + Yc*DFc_Dtheta);
DOphidot_Dz       = 1/J*(Ya*DFa_Dz + Yb*DFb_Dz + Yc*DFc_Dz);

DOthetadot_Dphi   = 1/J*(Xa*DFa_Dphi + Xb*DFb_Dphi + Xc*DFc_Dphi);
DOthetadot_Dtheta = 1/J*(Xa*DFa_Dtheta + Xb*DFb_Dtheta + Xc*DFc_Dtheta);
DOthetadot_Dz     = 1/J*(Xa*DFa_Dz + Xb*DFb_Dz + Xc*DFc_Dz);

DVzdot_Dphi       = 1/masseP *(DFa_Dphi + DFb_Dphi + DFc_Dphi);
DVzdot_Dtheta     = 1/masseP *(DFa_Dtheta + DFb_Dtheta + DFc_Dtheta);
DVzdot_Dz         = 1/masseP *(DFa_Dz + DFb_Dz + DFc_Dz);




PP  = [DOphidot_Dphi   DOphidot_Dtheta   DOphidot_Dz;
       DOthetadot_Dphi DOthetadot_Dtheta DOthetadot_Dz;
       DVzdot_Dphi     DVzdot_Dtheta     DVzdot_Dz];
%%


DOphidot_DXs = 0; 
DOphidot_DYs = masseS*g;

DOthetadot_DXs = masseS*g;
DOthetadot_DYs = 0;

DOVzdot_DXs = 0;
DOVzdot_DYs = 0;

PS = [DOphidot_DXs   DOphidot_DYs;
      DOthetadot_DXs DOthetadot_DYs;
      DOVzdot_DXs    DOVzdot_DYs];

  
%%

DOphidot_DIa = 1/J*(Ya*DFa_DIa);
DOphidot_DIb = 1/J*(Yb*DFb_DIb);
DOphidot_DIc = 1/J*(Yc*DFc_DIc);

DOthetadot_DIa = 1/J*(Xa*DFa_DIa);
DOthetadot_DIb = 1/J*(Xb*DFb_DIb);
DOthetadot_DIc = 1/J*(Xc*DFc_DIc);

DOVzdot_DIa = 1/masseP*(DFa_DIa);
DOVzdot_DIb = 1/masseP*(DFb_DIb);
DOVzdot_DIc = 1/masseP*(DFc_DIc);

PC = [DOphidot_DIa   DOphidot_DIb   DOphidot_DIc;
      DOthetadot_DIa DOthetadot_DIb DOthetadot_DIc;
      DOVzdot_DIa    DOVzdot_DIb    DOVzdot_DIc;];
%%

DVxs_Dphi = 0;
DVxs_Dtheta = -5*g/7; 
DVxs_Dz = 0;

DVys_Dphi = 5*g/7;
DVys_Dtheta = 0;
DVys_Dz = 0;

SP = [DVxs_Dphi DVxs_Dtheta DVxs_Dz;
      DVys_Dphi DVys_Dtheta DVys_Dz];
  
%%


DIadot_DIa = -R/L;
DIadot_DIb = 0;
DIadot_DIc = 0;

DIbdot_DIa = 0;
DIbdot_DIb = -R/L;
DIbdot_DIc = 0;

DIcdot_DIa = 0;
DIcdot_DIb = 0;
DIcdot_DIc = -R/L;

CC = [DIadot_DIa DIadot_DIb DIadot_DIc;
      DIbdot_DIa DIbdot_DIb DIbdot_DIc;
      DIcdot_DIa DIcdot_DIb DIcdot_DIc;];

%%


DIadot_DVa = 1/L;
DIadot_DVb = 0;
DIadot_DVc = 0;

DIbdot_DVa = 0;
DIbdot_DVb = 1/L;
DIbdot_DVc = 0;

DIcdot_DVa = 0;
DIcdot_DVb = 0;
DIcdot_DVc = 1/L;

CV = [DIadot_DVa DIadot_DVb DIadot_DVc;
      DIbdot_DVa DIbdot_DVb DIbdot_DVc;
      DIcdot_DVa DIcdot_DVb DIcdot_DVc;];
  
%% Calcul des courants à équilibres

 Ia_eq = 1/2.*(-sqrt(bE1^2+4.*(Ae(1) + Ae(2)*Zk + Ae(3)*Zk.^2 + Ae(4)*Zk.^3).*(-1./(As(1) + As(2).*Zk + As(3).*Zk.^2 + As(4).*Zk.^3)+offset)-4.*(Ae(1) + Ae(2)*Zk + Ae(3)*Zk.^2 + Ae(4)*Zk.^3).*FA_eq)+bE1);
  Ia_eq = subs(Ia_eq,Zk,Z0_eq-Xk*theta_eq+Yk*phi_eq);
  Ia_eq = subs(Ia_eq,[Xk Yk],[Xa Ya]);
  
  Ib_eq = 1/2.*(-sqrt(bE1^2+4.*(Ae(1) + Ae(2)*Zk + Ae(3)*Zk.^2 + Ae(4)*Zk.^3).*(-1./(As(1) + As(2).*Zk + As(3).*Zk.^2 + As(4).*Zk.^3)+offset)-4.*(Ae(1) + Ae(2)*Zk + Ae(3)*Zk.^2 + Ae(4)*Zk.^3).*FB_eq)+bE1);
  Ib_eq = subs(Ib_eq,Zk,Z0_eq-Xk*theta_eq+Yk*phi_eq);
  Ib_eq = subs(Ib_eq,[Xk Yk],[Xb Yb]);
  
  Ic_eq = 1/2.*(-sqrt(bE1^2+4.*(Ae(1) + Ae(2)*Zk + Ae(3)*Zk.^2 + Ae(4)*Zk.^3).*(-1./(As(1) + As(2).*Zk + As(3).*Zk.^2 + As(4).*Zk.^3)+offset)-4.*(Ae(1) + Ae(2)*Zk + Ae(3)*Zk.^2 + Ae(4)*Zk.^3).*FC_eq)+bE1);
  Ic_eq = subs(Ic_eq,Zk,Z0_eq-Xk*theta_eq+Yk*phi_eq);
  Ic_eq = subs(Ic_eq,[Xk Yk],[Xc Yc]);

%%
Rdef_ini = 80e-3;
Xd =  Rdef_ini*sind(30);
Yd =  Rdef_ini*cosd(30);
Xe = -Rdef_ini;
Ye =  0;
Xf =  Rdef_ini*sind(30);
Yf = -Rdef_ini*cosd(30);

Ttabc = [Ya  Yb  Yc;
        -Xa -Xb -Xc;
          1   1   1]';

Ttdef = [ Yd  Ye  Yf;
         -Xd -Xe -Xf;
          1   1   1]';

A = [ 0 0 0 1 0 0 0 0 0 0 0 0 0;
      0 0 0 0 1 0 0 0 0 0 0 0 0;
      0 0 0 0 0 1 0 0 0 0 0 0 0;
      PP(1,1) PP(1,2) PP(1,3) 0 0 0 PS(1,1) PS(1,2) 0 0 PC(1,1) PC(1,2) PC(1,3);
      PP(2,1) PP(2,2) PP(2,3) 0 0 0 PS(2,1) PS(2,2) 0 0 PC(2,1) PC(2,2) PC(2,3);
      PP(3,1) PP(3,2) PP(3,3) 0 0 0 PS(3,1) PS(3,2) 0 0 PC(3,1) PC(3,2) PC(3,3);
      0 0 0 0 0 0 0 0 1 0 0 0 0;
      0 0 0 0 0 0 0 0 0 1 0 0 0;
      SP(1,1) SP(1,2) SP(1,3) 0 0 0 0 0 0 0 0 0 0;
      SP(2,1) SP(2,2) SP(2,3) 0 0 0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0 0 0 CC(1,1) CC(1,2) CC(1,3);
      0 0 0 0 0 0 0 0 0 0 CC(2,1) CC(2,2) CC(2,3);
      0 0 0 0 0 0 0 0 0 0 CC(3,1) CC(3,2) CC(3,3)];
  
B = [0 0 0;
     0 0 0;
     0 0 0;
     0 0 0;
     0 0 0;
     0 0 0;
     0 0 0;
     0 0 0;
     0 0 0;
     0 0 0;
     CV(1,1) CV(1,2) CV(1,3);
     CV(2,1) CV(2,2) CV(2,3);
     CV(3,1) CV(3,2) CV(3,3)];
 
 C = [Ttdef(1,1) Ttdef(1,2) Ttdef(1,3) 0 0 0 0 0 0 0 0 0 0;
      Ttdef(2,1) Ttdef(2,2) Ttdef(2,3) 0 0 0 0 0 0 0 0 0 0;
      Ttdef(3,1) Ttdef(3,2) Ttdef(3,3) 0 0 0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 1 0 0 0 0 0 0;
      0 0 0 0 0 0 0 1 0 0 0 0 0;
      0 0 0 0 0 0 0 0 1 0 0 0 0;
      0 0 0 0 0 0 0 0 0 1 0 0 0;];
  
 D = [0 0 0;
      0 0 0;
      0 0 0;
      0 0 0;
      0 0 0;
      0 0 0;
      0 0 0;];
  
%% Create .mat
save('systeme_matriciel.mat', 'A', 'B', 'C', 'D', 'Ia_eq');