%---------------------------------
%Fait par : PHIL
%Date : 2019-11-11
%Reste a faire: 
% - Rien
% - 
% - 
%---------------------------------


clc

Linearisation;
CONSTANTES;
%Ces variables seront remplacées par celle dans banc d'essai si elle sont disponibles
% Position à l'équilibre de la sphère (pour tests statiques)
    sig = 1.0;         % Présence (1) ou non (0) de la sphère

    xSeq = 0.000;      % Position x de la sphère à l'équilibre en metres

    ySeq = 0.000;      % Position y de la sphère à l'équilibre en metres
%Point d'opération choisi pour la plaque

    Axeq = 0;               %en degres

    Ayeq = 0;               %en degres

    Pzeq = 0.015;            %en metres

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%Match and remplace

Ae1 = Ae(1);
Ae2 = Ae(2);
Ae3 = Ae(3);
Ae4 = Ae(4);

As1 = As(1);
As2 = As(2);
As3 = As(3);
As4 = As(4);




%Calcul des forces à l'équilibre
syms FA FB FC 

FB = FC+ySeq*mS*g/-YB;
FA = FC + mS*g*(xSeq*YB-ySeq*XB)/(2*XB*YB);

FC_eq = solve(0 == FA+FB+FC+mS*g+mP*g, FC);
FB_eq = FC_eq+ySeq*mS*g/-YB;
FA_eq = FC_eq + mS*g*(xSeq*YB-ySeq*XB)/(2*XB*YB);

%% Calcul de IA_eq, IB_eq et IC_eq selon 
  
  IA_eq = 1/2.*(-sqrt(Be^2+4.*(Ae(1) + Ae(2)*ZK + Ae(3)*ZK.^2 + Ae(4)*ZK.^3).*(-1./(As(1) + As(2).*ZK + As(3).*ZK.^2 + As(4).*ZK.^3))-4.*(Ae(1) + Ae(2)*ZK + Ae(3)*ZK.^2 + Ae(4)*ZK.^3).*FA_eq)+Be);
  IA_eq = subs(IA_eq,ZK,Pzeq-XA*Ayeq+YA*Axeq);
  
  IB_eq = 1/2.*(-sqrt(Be^2+4.*(Ae(1) + Ae(2)*ZK + Ae(3)*ZK.^2 + Ae(4)*ZK.^3).*(-1./(As(1) + As(2).*ZK + As(3).*ZK.^2 + As(4).*ZK.^3))-4.*(Ae(1) + Ae(2)*ZK + Ae(3)*ZK.^2 + Ae(4)*ZK.^3).*FB_eq)+Be);
  IB_eq = subs(IB_eq,ZK,Pzeq-XB*Ayeq+YB*Axeq);
  
  IC_eq = 1/2.*(-sqrt(Be^2+4.*(Ae(1) + Ae(2)*ZK + Ae(3)*ZK.^2 + Ae(4)*ZK.^3).*(-1./(As(1) + As(2).*ZK + As(3).*ZK.^2 + As(4).*ZK.^3))-4.*(Ae(1) + Ae(2)*ZK + Ae(3)*ZK.^2 + Ae(4)*ZK.^3).*FC_eq)+Be);
  IC_eq = subs(IC_eq,ZK,Pzeq-XC*Ayeq+YC*Axeq);
  
 %% Voltage a l'équilibre (entrées)
  Va_eq = IA_eq*RA;
  Vb_eq = IB_eq*RB;
  Vc_eq = IC_eq*RC;
  
  entrees_eq = [Va_eq Vb_eq Vc_eq];
  
%% Variable d'états à l'équilibre

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
 
%% Sorties à l'équilibre
 dD_eq = Pzeq;
 dE_eq = Pzeq;
 dF_eq = Pzeq;
 %Xs_eq= xSeq;
 %Ys_eq= ySeq;
 Vsx_eq =0;
 Vsy_eq=0;

sorties_eq = [dD_eq dE_eq dF_eq xSeq ySeq Vsx_eq Vsy_eq];
  
  
  %% Matrices ABCD évalues à l'équilibre
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
%% calcul de l'équilibre pour le découplé
% [Iphi_eq Itheta_eq Iz_eq]' == TABC_inv * [IA_eq IB_eq IC_eq]';

Iphi_eq = eval(TABC(1,1)*IA_eq + TABC(1,2)*IB_eq + TABC(1,3)*IC_eq);
Itheta_eq = eval(TABC(2,1)*IA_eq + TABC(2,2)*IB_eq + TABC(2,3)*IC_eq);
Iz_eq = eval(TABC(3,1)*IA_eq + TABC(3,2)*IB_eq + TABC(3,3)*IC_eq);

 %% Voltage a l'équilibre (entrées)
  Vphi_eq = Iphi_eq*RA;
  Vtheta_eq = Itheta_eq*RB;
  Vz_eq = Iz_eq*RC;
 
 %% Variable d'état découplé a l'équilibre
  %phi_eq = Axeq;
  %theta_eq = Ayeq;
  %Z0_eq = Pzeq;
  Ophi_eq  = 0;
  Otheta_eq = 0;
  Vz_eq = 0;
  %Xs_eq= xSeq;
  %Ys_eq= ySeq;
  Vsx_eq =0;
  Vsy_eq=0;
%% Matrices ABCD pour les sys découplés

PP_dec = eval(subs(PP_dec));
PC_dec = eval(subs(PC_dec));
SP_dec = eval(subs(SP_dec));
CC_dec = eval(subs(CC_dec));
CV_dec = eval(subs(CV_dec));


%% 

%% système axe phi

A_phi = [0       1   0      ;
         PP_dec(1,1) 0   PC_dec(1,1);
         0       0   CC_dec(1,1)];
     
B_phi = [0 0 CV_dec(1,1)]';

C_phi = [1 0 0];
         

D_phi = [0];

%[num_phi,den_phi] = ss2tf(A_phi,B_phi,C_phi,D_phi);

%TF_p_phi = tf(num_phi,den_phi);
%% système axe theta
A_theta = [0 1 0 ;
          PP_dec(2,2) 0 PC_dec(2,2);
          0       0 CC_dec(2,2)];
     
B_theta = [0 0 CV_dec(2,2)]';

C_theta = [1 0 0];

D_theta = [0];

%[num_theta,den_theta] = ss2tf(A_theta,B_theta,C_theta,D_theta);

%TF_p_theta = tf(num_theta,den_theta);


%% système z
A_z = [0 1 0 ;
          PP_dec(3,3) 0 PC_dec(3,3);
          0       0 CC_dec(3,3)];
     
B_z = [0 0 CV_dec(3,3)]';

C_z = [1 0 0];

D_z = [0];

%[num_z,den_z] = ss2tf(A_z,B_z,C_z,D_z);

%TF_p_z= tf(num_z(1,:),den_z);

%% système x
A_x = [0 1;
       0 0;];
   
B_x = [0 SP_dec(1,2)]'; % vraiment pas sur pour la matrice B 

C_x = [1 0;
       0 1;];
   
D_x = [0 0]';

% [num_x,den_x] = ss2tf(A_x,B_x,C_x,D_x);
% 
% TF_p_x = tf(num_x(1,:),den_x);
% TF_v_x = tf(num_x(2,1:3),den_x);
%% système y

A_y = [0 1;
       0 0;];
   
B_y = [0 SP_dec(2,1)]'; % vraiment pas sur pour la matrice B 

C_y = [1 0;
       0 1;];
   
D_y = [0 0]';

% [num_y,den_y] = ss2tf(A_y,B_y,C_y,D_y);
% 
% TF_p_y = tf(num_y(1,1:3),den_y);
% TF_v_y = tf(num_y(2,1:3),den_y);

  disp('Équilibre calculé et découplé')
