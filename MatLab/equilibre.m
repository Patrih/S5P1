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

%% Data

load('Constantes_moindre_carré')
load('Constantes_inertiels')
load('Identification_MC')
load('Linearisation')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Ces variables seront remplacées par celle dans banc d'essai si elle sont disponibles
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Position à l'équilibre de la sphère (pour tests statiques)
    sig = 1.0;         % Présence (1) ou non (0) de la sphère

    xSeq = 0.000;      % Position x de la sphère à l'équilibre en metres

    ySeq = 0.000;      % Position y de la sphère à l'équilibre en metres
%Point d'opération choisi pour la plaque

    Axeq = 0;               %en degres

    Ayeq = 0;               %en degres

    Pzeq = 0.015;            %en metres

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Match and remplace
Ae1 = Ae(1);
Ae2 = Ae(2);
Ae3 = Ae(3);
Ae4 = Ae(4);

As1 = As(1);
As2 = As(2);
As3 = As(3);
As4 = As(4);

%1      
%2      
%3      
%4      
%5      
%6      
%7      
%8      
%9      
%Figure  1 2 3 4 5 6 7 8 9
plots = [0 0 0 0 0 0 0 0 0];

%% Calcul des forces à l'équilibre
disp("----------------- Calcul des forces à l'équilibre----------------------")
syms FA FB FC 

FB = FC+ySeq*mS*g/-YB;
FA = FC + mS*g*(xSeq*YB-ySeq*XB)/(2*XB*YB);

FC_eq = solve(0 == FA+FB+FC+mS*g+mP*g, FC);
FB_eq = FC_eq+ySeq*mS*g/-YB;
FA_eq = FC_eq + mS*g*(xSeq*YB-ySeq*XB)/(2*XB*YB);

disp(' ')
disp(' ')

%% Calcul des courants à l'équilibre
disp("----------------- Calcul des courants à l'équilibre-------------------")

%IA
IA_eq = 1/2.*(-sqrt(Be^2+4.*(Ae(1) + Ae(2)*ZK + Ae(3)*ZK.^2 + Ae(4)*ZK.^3).*(-1./(As(1) + As(2).*ZK + As(3).*ZK.^2 + As(4).*ZK.^3))-4.*(Ae(1) + Ae(2)*ZK + Ae(3)*ZK.^2 + Ae(4)*ZK.^3).*FA_eq)+Be);
IA_eq = subs(IA_eq,ZK,Pzeq-XA*Ayeq+YA*Axeq);

%IB
IB_eq = 1/2.*(-sqrt(Be^2+4.*(Ae(1) + Ae(2)*ZK + Ae(3)*ZK.^2 + Ae(4)*ZK.^3).*(-1./(As(1) + As(2).*ZK + As(3).*ZK.^2 + As(4).*ZK.^3))-4.*(Ae(1) + Ae(2)*ZK + Ae(3)*ZK.^2 + Ae(4)*ZK.^3).*FB_eq)+Be);
IB_eq = subs(IB_eq,ZK,Pzeq-XB*Ayeq+YB*Axeq);

%IC
IC_eq = 1/2.*(-sqrt(Be^2+4.*(Ae(1) + Ae(2)*ZK + Ae(3)*ZK.^2 + Ae(4)*ZK.^3).*(-1./(As(1) + As(2).*ZK + As(3).*ZK.^2 + As(4).*ZK.^3))-4.*(Ae(1) + Ae(2)*ZK + Ae(3)*ZK.^2 + Ae(4)*ZK.^3).*FC_eq)+Be);
IC_eq = subs(IC_eq,ZK,Pzeq-XC*Ayeq+YC*Axeq);

disp(' ')
disp(' ')

%% Calcul du voltage à l'équilibre
disp("----------------- Calcul du voltage à l'équilibre----------------------")

Va_eq = IA_eq*RA;
Vb_eq = IB_eq*RB;
Vc_eq = IC_eq*RC;

entrees_eq = [Va_eq Vb_eq Vc_eq];

disp(' ')
disp(' ')

%% Variable d'états à l'équilibre
disp("----------------- Variable d'états à l'équilibre ----------------------")

%phi_eq = Axeq;
%theta_eq = Ayeq;
%Z0_eq = Pzeq;
Ophi_eq  = 0;
Otheta_eq = 0;
Vz_eq = 0;
%Xs_eq = xSeq;
%Ys_eq = ySeq;
Vsx_eq =0;
Vsy_eq =0;
%IA_eq
%IB_eq
%IC_eq

VE_eq = [Axeq Ayeq Pzeq Ophi_eq Otheta_eq Vz_eq xSeq ySeq Vsx_eq Vsy_eq IA_eq IB_eq IC_eq];

disp(' ')
disp(' ')
 
%% Sorties à l'équilibre
disp("-----------------------Sorties à l'équilibre---------------------------")

dD_eq = Pzeq;
dE_eq = Pzeq;
dF_eq = Pzeq;
%Xs_eq= xSeq;
%Ys_eq= ySeq;
Vsx_eq =0;
Vsy_eq=0;

sorties_eq = [dD_eq dE_eq dF_eq xSeq ySeq Vsx_eq Vsy_eq];

disp(' ')
disp(' ')
    
%% Matrices ABCD évalues à l'équilibre
disp("--------------------Matrices ABCD à l'équilibre------------------------")

PP = eval(subs(PP));
PC = eval(subs(PC));
PS = eval(subs(PS));
SP = eval(subs(SP));
CC = eval(subs(CC));
CV = eval(subs(CV));
  

A = [[zeros([3,3]) eye(3) zeros([3,2]) zeros([3,2]) zeros([3,3]) ]; 
     [PP zeros([3,3]) PS zeros([3,2]) PC ];
     [zeros([2,3]) zeros([2,3]) zeros([2,2]) eye(2) zeros([2,3]) ];
     [SP zeros([2,3]) zeros([2,2]) zeros([2,2]) zeros([2,3]) ];
     [zeros([3,3]) zeros([3,3]) zeros([3,2]) zeros([3,2]) CC ]];
B = [[zeros([10,3])];
     [CV]];
     
C = [[TDEF' zeros([3,10])];
     [zeros([4,6]) eye(4) zeros([4,3])]];
 
  
D = zeros([7,3]);


disp(' ')
disp(' ')
