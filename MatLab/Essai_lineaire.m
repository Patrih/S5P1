clear all 
close all
clc
%% Essai lineraire

syms phi_e theta_e Z0_e
syms Fk
syms Ik
syms J
syms masseP masseS g
syms ae0 ae1 ae2 ae3
syms be1
syms as0 as1 as2 as3
syms Zk 
syms Xk Yk
syms Xa Xb Xc Xd Xe Xf Ya Yb Yc Yd Ye Yf
syms Ia_e Ib_e Ic_e
syms Xs Ys
syms R L
syms A
syms Va Vb Vc

%%------------------I positif -------------------------%

Fk = (Ik*abs(Ik) + be1*Ik)/(ae0 + ae1*Zk + ae2*Zk^2 + ae3*Zk^3)-1/(as0 + as1*Zk + as2*Zk^2 + as3*Zk^3);

Fk = subs (Fk,Zk,Z0_e-Xk*theta_e+Yk*phi_e);

DFk_Dtheta = diff(Fk,theta_e);
DFk_Dphi = diff(Fk,phi_e);
DFk_Dz = diff(Fk,Z0_e);
DFk_DI = diff(Fk,Ik);

DFa_Dphi = subs(DFk_Dphi,[Ik Xk Yk],[Ia_e Xa Ya]);
DFb_Dphi = subs(DFk_Dphi,[Ik Xk Yk],[Ib_e Xb Yb]);
DFc_Dphi = subs(DFk_Dphi,[Ik Xk Yk],[Ic_e Xc Yc]);

DFa_Dtheta = subs(DFk_Dtheta,[Ik Xk Yk],[Ia_e Xa Ya]);
DFb_Dtheta = subs(DFk_Dtheta,[Ik Xk Yk],[Ib_e Xb Yb]);
DFc_Dtheta = subs(DFk_Dtheta,[Ik Xk Yk],[Ic_e Xc Yc]);

DFa_Dz = subs(DFk_Dz,[Ik Xk Yk],[Ia_e Xa Ya]);
DFb_Dz = subs(DFk_Dz,[Ik Xk Yk],[Ib_e Xb Yb]);
DFc_Dz = subs(DFk_Dz,[Ik Xk Yk],[Ic_e Xc Yc]);

DFa_DIa = subs(DFk_DI,[Ik Xk Yk],[Ia_e Xa Ya]);
DFb_DIb = subs(DFk_DI,[Ik Xk Yk],[Ib_e Xb Yb]);
DFc_DIc = subs(DFk_DI,[Ik Xk Yk],[Ic_e Xc Yc]);


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
  
%%

Ttdef = [ Yd  Ye  Yf;
         -Xd -Xe -Xf;
          1   1   1]';


% A = zeros(13:13);
% A(1:3,4:6) = 1;
% A(4,1) = PP(1,1)

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

%% Calcul des matrices selon l'équilibre suivant

syms Zeq I_e I_eq


% phi_e = 0;
% theta_e = 0;
% Z0_e = Zeq;
% 
% Ia_e = I_e;
% Ib_e = I_e;
% Ic_e = I_e;





syms Xs Ys FS FP FA FB FC FAe FBe FCe
FB = FA*((Xc*Ya-Xa*Yc)/(Xb*Yc+Xb))+FS*((Xc*Ys-Xs*Yc)/(Xb*Yc+Xb));
FC = -FA*((Xc*Ya-Xa*Yc)/(Xb*Yc+Xb)*Yb/Yc+Ya/Yc)-FS*((Xc*Ys-Xs*Yc)/(Xb*Yc+Xb)*Yb/Yc+Ys/Yc);


FAe = solve(FA == -FS-FP-FB-FC , FA);
FBe = FAe*((Xc*Ya-Xa*Yc)/(Xb*Yc+Xb))+FS*((Xc*Ys-Xs*Yc)/(Xb*Yc+Xb));
FCe = -FAe*((Xc*Ya-Xa*Yc)/(Xb*Yc+Xb)*Yb/Yc+Ya/Yc)-FS*((Xc*Ys-Xs*Yc)/(Xb*Yc+Xb)*Yb/Yc+Ys/Yc);

FAe = subs(FAe,[FS FP],[masseS*g masseP*g]);
FBe = subs(FBe,[FS FP],[masseS*g masseP*g]);
FCe = subs(FCe,[FS FP],[masseS*g masseP*g]);

% I_e = solve(FAe == -1/(as0+as1*Zeq+as2*Zeq^2+as3*Zeq^3)+((I_e^2 + be1*abs(I_e)*sign(I_e)))/(ae0+ae1*Zeq+ae2*Zeq^2+ae3*Zeq^3), I_e);
A_e = subs(A,[phi_e theta_e Z0_e Ia_e Ib_e Ic_e], [0 0 Zeq I_e I_e I_e]);

I_eq = solve(FAe == -1/(as0+as1*Zeq+as2*Zeq^2+as3*Zeq^3)+((I_e^2 + be1*I_e))/(ae0+ae1*Zeq+ae2*Zeq^2+ae3*Zeq^3), I_e);
A_ep = subs (A_e,I_e,I_eq);


%% Calcul des matrices selon l'équilibre suivant

syms Zeq I_e I_eq


% phi_e = 0;
% theta_e = 0;
% Z0_e = Zeq;
% 
% Ia_e = I_e;
% Ib_e = I_e;
% Ic_e = I_e;





syms Xs Ys FS FP FA FB FC FAe FBe FCe
FB = FA*((Xc*Ya-Xa*Yc)/(Xb*Yc+Xb))+FS*((Xc*Ys-Xs*Yc)/(Xb*Yc+Xb));
FC = -FA*((Xc*Ya-Xa*Yc)/(Xb*Yc+Xb)*Yb/Yc+Ya/Yc)-FS*((Xc*Ys-Xs*Yc)/(Xb*Yc+Xb)*Yb/Yc+Ys/Yc);


FAe = solve(FA == -FS-FP-FB-FC , FA);
FBe = FAe*((Xc*Ya-Xa*Yc)/(Xb*Yc+Xb))+FS*((Xc*Ys-Xs*Yc)/(Xb*Yc+Xb));
FCe = -FAe*((Xc*Ya-Xa*Yc)/(Xb*Yc+Xb)*Yb/Yc+Ya/Yc)-FS*((Xc*Ys-Xs*Yc)/(Xb*Yc+Xb)*Yb/Yc+Ys/Yc);

FAe = subs(FAe,[FS FP],[masseS*g masseP*g]);
FBe = subs(FBe,[FS FP],[masseS*g masseP*g]);
FCe = subs(FCe,[FS FP],[masseS*g masseP*g]);

% I_e = solve(FAe == -1/(as0+as1*Zeq+as2*Zeq^2+as3*Zeq^3)+((I_e^2 + be1*abs(I_e)*sign(I_e)))/(ae0+ae1*Zeq+ae2*Zeq^2+ae3*Zeq^3), I_e);


A_e = subs(A,[phi_e theta_e Z0_e Ia_e Ib_e Ic_e], [0 0 Zeq I_e I_e I_e]);


%-----------------------negatif---------------------%



I_eq = solve(FAe == -1/(as0+as1*Zeq+as2*Zeq^2+as3*Zeq^3)+(-I_e^2 + be1*I_e)/(ae0+ae1*Zeq+ae2*Zeq^2+ae3*Zeq^3), I_e);
A_em = subs (A_e,I_e,I_eq(1));




