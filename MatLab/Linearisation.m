clc 
clear all
close all
addpath('Data')

%Fait par : PHIL
%Date : 2019-11-11
%Reste a faire: 
% - 
% - 
% - 


%% Syms
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

save('Data/Linearisation');

disp(' ')
disp(' ')

%% PP
disp("---------------------------------PP------------------------------------")

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
   
save('Data/Linearisation','PP','-append');

disp(' ')
disp(' ')
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

save('Data/Linearisation','PS','-append');

disp(' ')
disp(' ')

%% PC
disp("---------------------------------PC------------------------------------")

DOphidot_DIa = 1/Jx*(YA*DFa_DIa);
DOphidot_DIb = 1/Jx*(YB*DFb_DIb);
DOphidot_DIc = 1/Jx*(YC*DFc_DIc);

DOthetadot_DIa = - 1/Jy*(XA*DFa_DIa);
DOthetadot_DIb = - 1/Jy*(XB*DFb_DIb);
DOthetadot_DIc = - 1/Jy*(XC*DFc_DIc);

DOVzdot_DIa = 1/mP*(DFa_DIa);
DOVzdot_DIb = 1/mP*(DFb_DIb);
DOVzdot_DIc = 1/mP*(DFc_DIc);

PC = [DOphidot_DIa   DOphidot_DIb   DOphidot_DIc;
      DOthetadot_DIa DOthetadot_DIb DOthetadot_DIc;
      DOVzdot_DIa    DOVzdot_DIb    DOVzdot_DIc;];
  
save('Data/Linearisation','PC','-append');

disp(' ')
disp(' ')

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

save('Data/Linearisation','SP','-append');

disp(' ')
disp(' ')

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
  
save('Data/Linearisation','CC','-append');

disp(' ')
disp(' ')
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
  
save('Data/Linearisation','CV','-append');

disp(' ')
disp(' ')  
%% A B C D
disp("-------------------------------A B C D---------------------------------")

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
 
 C = [YD -XD 1 0 0 0 0 0 0 0 0 0 0;
      YE -XE 1 0 0 0 0 0 0 0 0 0 0;
      YF -XF 1 0 0 0 0 0 0 0 0 0 0;
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
  

save('Data/Linearisation','A','B','C','D','-append');

disp(' ')
disp(' ')  
  
  
