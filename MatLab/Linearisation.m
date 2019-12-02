clc 
clear all
close all
addpath('Data')

%Fait par : PHIL
%Date : 2019-11-11

%% Linearisation
disp("--------------------------------Syms-----------------------------------")

syms Axeq Ayeq Pzeq
syms Fk
syms Ik
syms Jx Jy
syms mP mS g
syms Ae1 Ae2 Ae3 Ae4
syms Be
syms As1 As2 As3 As4
syms ZK XK YK
syms XA XB XC XD XE XF YA YB YC YD YE YF
syms IA_eq IB_eq IC_eq
syms Xs Ys
syms RA RB RC LA LB LC
syms VA VB VC

%% dérivées utiles 
disp("-------------------------------Dérivées--------------------------------")
%Partons d'une force Fk = Fsk +  Fek
Fk = (Ik*abs(Ik) + Be*Ik)/(Ae1 + Ae2*ZK + Ae3*ZK^2 + Ae4*ZK^3)-1/(As1 + As2*ZK + As3*ZK^2 + As4*ZK^3);
%remplacement de la variable z par z0-Xktheta+Ykphi tel que proposé par
%l'équation à la page 23 des specs

Fk = subs (Fk,ZK,Pzeq-XK*Ayeq+YK*Axeq);
%Faire la dérivée partielle de la force FK par phi,theta,z et I
DFk_Dphi = diff(Fk,Axeq);
DFk_Dtheta = diff(Fk,Ayeq);
DFk_Dz = diff(Fk,Pzeq);
DFk_DI = diff(Fk,Ik);

%Remplacer les XK,Yk et Ik par les valeurs A, B et C et ce dans chaque
%équations pour avec la dérivée partielle d'une force

DFa_Dphi = subs(DFk_Dphi,[Ik XK YK],[IA_eq XA YA]);
DFb_Dphi = subs(DFk_Dphi,[Ik XK YK],[IB_eq XB YB]);
DFc_Dphi = subs(DFk_Dphi,[Ik XK YK],[IC_eq XC YC]);

DFa_Dtheta = subs(DFk_Dtheta,[Ik XK YK],[IA_eq XA YA]);
DFb_Dtheta = subs(DFk_Dtheta,[Ik XK YK],[IB_eq XB YB]);
DFc_Dtheta = subs(DFk_Dtheta,[Ik XK YK],[IC_eq XC YC]);

DFa_Dz = subs(DFk_Dz,[Ik XK YK],[IA_eq XA YA]);
DFb_Dz = subs(DFk_Dz,[Ik XK YK],[IB_eq XB YB]);
DFc_Dz = subs(DFk_Dz,[Ik XK YK],[IC_eq XC YC]);

DFa_DIa = subs(DFk_DI,[Ik XK YK],[IA_eq XA YA]);
DFb_DIb = subs(DFk_DI,[Ik XK YK],[IB_eq XB YB]);
DFc_DIc = subs(DFk_DI,[Ik XK YK],[IC_eq XC YC]);
%% PP 
disp("---------------------------------PP------------------------------------")

%À partir des dérivée partielles, construire les équations des moments de forces soit 
%Ophidot = YA*Fa +YB*FB+YC*Fc+YsFs, Othetadot = -XAFA-XBFB-XCFC-XSFS et Vzdot = FA+FB+FC+FS+FG

DOphidot_Dphi     = 1/Jx*(YA*DFa_Dphi + YB*DFb_Dphi + YC*DFc_Dphi);
DOphidot_Dtheta   = 1/Jx*(YA*DFa_Dtheta + YB*DFb_Dtheta + YC*DFc_Dtheta);
DOphidot_Dz       = 1/Jx*(YA*DFa_Dz + YB*DFb_Dz + YC*DFc_Dz);

DOthetadot_Dphi   = - 1/Jy*(XA*DFa_Dphi + XB*DFb_Dphi + XC*DFc_Dphi);
DOthetadot_Dtheta = - 1/Jy*(XA*DFa_Dtheta + XB*DFb_Dtheta + XC*DFc_Dtheta);
DOthetadot_Dz     = - 1/Jy*(XA*DFa_Dz + XB*DFb_Dz + XC*DFc_Dz);

DVzdot_Dphi       = 1/(mP+mS) *(DFa_Dphi + DFb_Dphi + DFc_Dphi);
DVzdot_Dtheta     = 1/(mP+mS) *(DFa_Dtheta + DFb_Dtheta + DFc_Dtheta);
DVzdot_Dz         = 1/(mP+mS) *(DFa_Dz + DFb_Dz + DFc_Dz);
% de cette facon on construit la matrice PP et la matrice PC

PP  = [DOphidot_Dphi   DOphidot_Dtheta   DOphidot_Dz;
       DOthetadot_Dphi DOthetadot_Dtheta DOthetadot_Dz;
       DVzdot_Dphi     DVzdot_Dtheta     DVzdot_Dz];
   
   


%% PS
disp("---------------------------------PS------------------------------------")

%La matrice PS est la suivante sorties des mêmes équations de

DOphidot_DXs = 0; 
DOphidot_DYs = mS*g/Jx;

DOthetadot_DXs = - mS*g/Jy;
DOthetadot_DYs = 0;

DOVzdot_DXs = 0;
DOVzdot_DYs = 0;

PS = [DOphidot_DXs   DOphidot_DYs;
      DOthetadot_DXs DOthetadot_DYs;
      DOVzdot_DXs    DOVzdot_DYs];


  
%% PC
disp("---------------------------------PC------------------------------------")

DOphidot_DIa = 1/Jx*(YA*DFa_DIa);
DOphidot_DIb = 1/Jx*(YB*DFb_DIb);
DOphidot_DIc = 1/Jx*(YC*DFc_DIc);

DOthetadot_DIa = - 1/Jy*(XA*DFa_DIa);
DOthetadot_DIb = - 1/Jy*(XB*DFb_DIb);
DOthetadot_DIc = - 1/Jy*(XC*DFc_DIc);

DOVzdot_DIa = 1/(mP+mS)*(DFa_DIa);
DOVzdot_DIb = 1/(mP+mS)*(DFb_DIb);
DOVzdot_DIc = 1/(mP+mS)*(DFc_DIc);

PC = [DOphidot_DIa   DOphidot_DIb   DOphidot_DIc;
      DOthetadot_DIa DOthetadot_DIb DOthetadot_DIc;
      DOVzdot_DIa    DOVzdot_DIb    DOVzdot_DIc;];

%% SP
disp("---------------------------------SP------------------------------------")

DVxs_Dphi = 0;
DVxs_Dtheta = -5*g/7; 
DVxs_Dz = 0;

DVys_Dphi = 5*g/7;
DVys_Dtheta = 0;
DVys_Dz = 0;

SP = [DVxs_Dphi DVxs_Dtheta DVxs_Dz;
      DVys_Dphi DVys_Dtheta DVys_Dz];
  
%% CC
disp("---------------------------------CC------------------------------------")
DIadot_DIa = -RA/LA;
DIadot_DIb = 0;
DIadot_DIc = 0;

DIbdot_DIa = 0;
DIbdot_DIb = -RB/LB;
DIbdot_DIc = 0;

DIcdot_DIa = 0;
DIcdot_DIb = 0;
DIcdot_DIc = -RC/LC;

CC = [DIadot_DIa DIadot_DIb DIadot_DIc;
      DIbdot_DIa DIbdot_DIb DIbdot_DIc;
      DIcdot_DIa DIcdot_DIb DIcdot_DIc;];

%% CV
disp("---------------------------------CV------------------------------------")

DIadot_DVA = 1/LA;
DIadot_DVB = 0;
DIadot_DVC = 0;

DIbdot_DVA = 0;
DIbdot_DVB = 1/LB;
DIbdot_DVC = 0;

DIcdot_DVA = 0;
DIcdot_DVB = 0;
DIcdot_DVC = 1/LC;

CV = [DIadot_DVA DIadot_DVB DIadot_DVC;
      DIbdot_DVA DIbdot_DVB DIbdot_DVC;
      DIcdot_DVA DIcdot_DVB DIcdot_DVC;];
  
%% Section découplage
disp("--------------------------Section Découplage---------------------------")
PP_dec = [2*YC*DFc_Dphi/Jx 0                 0              ;
          0               3*XB*DFa_Dtheta/Jy 0              ;
          0               0                  3*DFb_Dz/(mP+mS);];

PC_dec = [DFa_DIa/Jx      0                  0               ;
          0               DFb_DIb/Jy         0               ;
          0               0                  DFc_DIc/(mP+mS) ;];
  
PS_dec = zeros([3,3]);

SP_dec = SP;

CC_dec = CC;

CV_dec = CV;
disp("---------------------------------Save----------------------------------")
save('Data/Linearisation');

disp("---------------------------End Linearistion----------------------------")  
  
