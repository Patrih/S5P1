clear all 
close all
clc

% Essai lineaire
% 
%     Fait par : 
%     Ce qu'il reste a faire :
%         -
%         -
%         -
%         -
%         
%     


%% Data

load('Identification_MC')

%% Essai lineraire

syms phi_e theta_e Z0_e
syms Fk
syms Ik
syms J
syms masseP masseS g
syms ae0 ae1 ae2 ae3
syms be1
syms as0 as1 as2 as3
syms ZK XK YK
syms Xa Xb Xc Xd Xe Xf Ya Yb Yc Yd Ye Yf
syms IA_eq IB_eq IC_eq
syms Xs Ys
syms R L
syms A
syms VA VB VC

%Partons d'une force Fk = Fsk +  Fek
Fk = (Ik*abs(Ik) + be1*Ik)/(ae0 + ae1*ZK + ae2*ZK^2 + ae3*ZK^3)-1/(as0 + as1*ZK + as2*ZK^2 + as3*ZK^3);
%remplacement de la variable z par z0-Xktheta+Ykphi tel que proposé par
%l'équation à la page 23 des specs
Fk = subs (Fk,ZK,Z0_e-XK*theta_e+YK*phi_e);
%Faire la dérivée partielle de la force FK par phi,theta,z et I
DFk_Dphi = diff(Fk,phi_e);
DFk_Dtheta = diff(Fk,theta_e);
DFk_Dz = diff(Fk,Z0_e);
DFk_DI = diff(Fk,Ik);

%Remplacer les XK,Yk et Ik par les valeurs A, B et C et ce dans chaque
%équations pour avec la dérivée partielle d'une force

DFa_Dphi = subs(DFk_Dphi,[Ik XK YK],[IA_eq Xa Ya]);
DFb_Dphi = subs(DFk_Dphi,[Ik XK YK],[IB_eq Xb Yb]);
DFc_Dphi = subs(DFk_Dphi,[Ik XK YK],[IC_eq Xc Yc]);

DFa_Dtheta = subs(DFk_Dtheta,[Ik XK YK],[IA_eq Xa Ya]);
DFb_Dtheta = subs(DFk_Dtheta,[Ik XK YK],[IB_eq Xb Yb]);
DFc_Dtheta = subs(DFk_Dtheta,[Ik XK YK],[IC_eq Xc Yc]);

DFa_Dz = subs(DFk_Dz,[Ik XK YK],[IA_eq Xa Ya]);
DFb_Dz = subs(DFk_Dz,[Ik XK YK],[IB_eq Xb Yb]);
DFc_Dz = subs(DFk_Dz,[Ik XK YK],[IC_eq Xc Yc]);

DFa_DIa = subs(DFk_DI,[Ik XK YK],[IA_eq Xa Ya]);
DFb_DIb = subs(DFk_DI,[Ik XK YK],[IB_eq Xb Yb]);
DFc_DIc = subs(DFk_DI,[Ik XK YK],[IC_eq Xc Yc]);

%À partir des dérivée partielles, construire les équations des moments de forces soit 
%Ophidot = YA*Fa +YB*FB+YC*Fc+YsFs,Othetadot = -XAFA-XBFB-XCFC-XSFS et Vzdot = FA+FB+FC+FS+FG

DOphidot_Dphi     = 1/J*(Ya*DFa_Dphi + Yb*DFb_Dphi + Yc*DFc_Dphi);
DOphidot_Dtheta   = 1/J*(Ya*DFa_Dtheta + Yb*DFb_Dtheta + Yc*DFc_Dtheta);
DOphidot_Dz       = 1/J*(Ya*DFa_Dz + Yb*DFb_Dz + Yc*DFc_Dz);

DOthetadot_Dphi   = - 1/J*(Xa*DFa_Dphi + Xb*DFb_Dphi + Xc*DFc_Dphi);
DOthetadot_Dtheta = - 1/J*(Xa*DFa_Dtheta + Xb*DFb_Dtheta + Xc*DFc_Dtheta);
DOthetadot_Dz     = - 1/J*(Xa*DFa_Dz + Xb*DFb_Dz + Xc*DFc_Dz);

DVzdot_Dphi       = 1/masseP *(DFa_Dphi + DFb_Dphi + DFc_Dphi);
DVzdot_Dtheta     = 1/masseP *(DFa_Dtheta + DFb_Dtheta + DFc_Dtheta);
DVzdot_Dz         = 1/masseP *(DFa_Dz + DFb_Dz + DFc_Dz);
% de cette facon on construit la matrice PP et la matrice PC

PP  = [DOphidot_Dphi   DOphidot_Dtheta   DOphidot_Dz;
       DOthetadot_Dphi DOthetadot_Dtheta DOthetadot_Dz;
       DVzdot_Dphi     DVzdot_Dtheta     DVzdot_Dz];
%%
%La matrice PS est la suivante sorties des mêmes équations de

DOphidot_DXs = 0; 
DOphidot_DYs = masseS*g/J;

DOthetadot_DXs = - masseS*g/J;
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

DOthetadot_DIa = - 1/J*(Xa*DFa_DIa);
DOthetadot_DIb = - 1/J*(Xb*DFb_DIb);
DOthetadot_DIc = - 1/J*(Xc*DFc_DIc);

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


DIadot_DVA = 1/L;
DIadot_DVB = 0;
DIadot_DVC = 0;

DIbdot_DVA = 0;
DIbdot_DVB = 1/L;
DIbdot_DVC = 0;

DIcdot_DVA = 0;
DIcdot_DVB = 0;
DIcdot_DVC = 1/L;

CV = [DIadot_DVA DIadot_DVB DIadot_DVC;
      DIbdot_DVA DIbdot_DVB DIbdot_DVC;
      DIcdot_DVA DIcdot_DVB DIcdot_DVC;];
  
%%
%La matrice Ttabc est utilisée au découplage
Tabc = [Ya  Yb  Yc;
       -Xa -Xb -Xc;
         1   1   1];
Ttabc = Tabc';




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
  
  
  

%% Calcul des matrices selon l'équilibre suiVAnt

syms Z_eq I_e I_eq


% phi_e = 0;
% theta_e = 0;
% Z0_e = Z_eq;
% 
% IA_eq = I_e;
% IB_eq = I_e;
% IC_eq = I_e;





syms Xs_eq Ys_eq FS FP FA FB FC FA_eq FB_eq FC_eq

FB = FC+Ys_eq*FS/-Yb;
FA = FC + FS*(Xs_eq*Yb-Ys_eq*Xb)/(2*Xb*Yb);


FC_eq = solve(0 == FA+FB+FC+FS+FP, FC);
FB_eq = FC_eq+Ys_eq*FS/-Yb;
FA_eq =  FC_eq + FS*(Xs_eq*Yb-Ys_eq*Xb)/(2*Xb*Yb);

FA_eq = subs(FA_eq,[FS FP],[masseS*g masseP*g]);
FB_eq = subs(FB_eq,[FS FP],[masseS*g masseP*g]);
FC_eq = subs(FC_eq,[FS FP],[masseS*g masseP*g]);



%% Calcul de IA_eq, IB_eq et IC_eq selon 
  
  IA_eq = 1/2.*(-sqrt(bE1^2+4.*(Ae(1) + Ae(2)*ZK + Ae(3)*ZK.^2 + Ae(4)*ZK.^3).*(-1./(As(1) + As(2).*ZK + As(3).*ZK.^2 + As(4).*ZK.^3)+offset)-4.*(Ae(1) + Ae(2)*ZK + Ae(3)*ZK.^2 + Ae(4)*ZK.^3).*FA_eq)+bE1);
  IA_eq = subs(IA_eq,ZK,Z0_e-XK*theta_e+YK*phi_e);
  IA_eq = subs(IA_eq,[XK YK],[Xa Ya]);
  
  IB_eq = 1/2.*(-sqrt(bE1^2+4.*(Ae(1) + Ae(2)*ZK + Ae(3)*ZK.^2 + Ae(4)*ZK.^3).*(-1./(As(1) + As(2).*ZK + As(3).*ZK.^2 + As(4).*ZK.^3)+offset)-4.*(Ae(1) + Ae(2)*ZK + Ae(3)*ZK.^2 + Ae(4)*ZK.^3).*FB_eq)+bE1);
  IB_eq = subs(IB_eq,ZK,Z0_e-XK*theta_e+YK*phi_e);
  IB_eq = subs(IB_eq,[XK YK],[Xb Yb]);
  
  IC_eq = 1/2.*(-sqrt(bE1^2+4.*(Ae(1) + Ae(2)*ZK + Ae(3)*ZK.^2 + Ae(4)*ZK.^3).*(-1./(As(1) + As(2).*ZK + As(3).*ZK.^2 + As(4).*ZK.^3)+offset)-4.*(Ae(1) + Ae(2)*ZK + Ae(3)*ZK.^2 + Ae(4)*ZK.^3).*FC_eq)+bE1);
  IC_eq = subs(IC_eq,ZK,Z0_e-XK*theta_e+YK*phi_e);
  IC_eq = subs(IC_eq,[XK YK],[Xc Yc]);
  
  %%
% I_e = solve(FA_eq == -1/(as0+as1*Z_eq+as2*Z_eq^2+as3*Z_eq^3)+((I_e^2 + be1*abs(I_e)*sign(I_e)))/(ae0+ae1*Z_eq+ae2*Z_eq^2+ae3*Z_eq^3), I_e);
A_e = subs(A,[phi_e theta_e Z0_e], [0 0 Z_eq]);


A_ep = subs (A_e,I_e,I_eq);


%% Calcul des matrices selon l'équilibre suiVAnt

syms Z_eq I_e I_eq
% phi_e = 0;
% theta_e = 0;
% Z0_e = Z_eq;
% 
% IA_eq = I_e;
% IB_eq = I_e;
% IC_eq = I_e;





syms Xs Ys FS FP FA FB FC FA_eq FB_eq FC_eq
FB = FA*((Xc*Ya-Xa*Yc)/(Xb*Yc+Xb))+FS*((Xc*Ys-Xs*Yc)/(Xb*Yc+Xb));
FC = -FA*((Xc*Ya-Xa*Yc)/(Xb*Yc+Xb)*Yb/Yc+Ya/Yc)-FS*((Xc*Ys-Xs*Yc)/(Xb*Yc+Xb)*Yb/Yc+Ys/Yc);


FA_eq = solve(FA == -FS-FP-FB-FC , FA);
FB_eq = FA_eq*((Xc*Ya-Xa*Yc)/(Xb*Yc+Xb))+FS*((Xc*Ys-Xs*Yc)/(Xb*Yc+Xb));
FC_eq = -FA_eq*((Xc*Ya-Xa*Yc)/(Xb*Yc+Xb)*Yb/Yc+Ya/Yc)-FS*((Xc*Ys-Xs*Yc)/(Xb*Yc+Xb)*Yb/Yc+Ys/Yc);

FA_eq = subs(FA_eq,[FS FP],[masseS*g masseP*g]);
FB_eq = subs(FB_eq,[FS FP],[masseS*g masseP*g]);
FC_eq = subs(FC_eq,[FS FP],[masseS*g masseP*g]);
