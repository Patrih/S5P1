clear all
% Essai_lineaire;
close all 
clc

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
%% découplage plaque sphère

% changer PS pour 0
A = [1 1 1 1 1 1 1 1 1 1 1 1 1;
     1 1 1 1 1 1 1 1 1 1 1 1 1;
     1 1 1 1 1 1 1 1 1 1 1 1 1;
     1 1 1 1 1 1 1 1 1 1 1 1 1;
     1 1 1 1 1 1 1 1 1 1 1 1 1;
     1 1 1 1 1 1 1 1 1 1 1 1 1;
     1 1 1 1 1 1 1 1 1 1 1 1 1;
     1 1 1 1 1 1 1 1 1 1 1 1 1;
     1 1 1 1 1 1 1 1 1 1 1 1 1;
     1 1 1 1 1 1 1 1 1 1 1 1 1;
     1 1 1 1 1 1 1 1 1 1 1 1 1;
     1 1 1 1 1 1 1 1 1 1 1 1 1;
     1 1 1 1 1 1 1 1 1 1 1 1 1;];
 
B = [0 0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 0 0 0;]';
 
C = [0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0;];

PS1 = [0 0;
       0 0;
       0 0;];
   
A(4:6,7:8) = PS1;

%% Équation d'état de la plaque
A_Eq_Ep = [];
B_Eq_Ep = [];
C_Eq_Sp = [];
D_Eq_Sp = [0 0 0;
           0 0 0;
           0 0 0;];
       
Ttdef = [ Yd  Ye  Yf;
         -Xd -Xe -Xf;
          1   1   1]';
% Équation d'état       
A_Eq_Ep(1:6,1:6) = A(1:6,1:6);
A_Eq_Ep(1:6,7:9) = A(1:6,11:13);
A_Eq_Ep(7:9,1:6) = A(11:13,1:6);
A_Eq_Ep(7:9,7:9) = A(11:13,11:13);

B_Eq_Ep(1:6,1:3) = B(1:6,1:3);
B_Eq_Ep(7:9,1:3) = B(11:13,1:3);
% Équation sortie
%C_Eq_Sp(1:3,1:3) = Ttdef(1:3,1:3);
C_Eq_Sp(1:3,4:9) = C(1:3,4:9);

%% Équation de la sphrère

% Équation d'état   
A_Eq_Es(1:4,1:4) = A(7:10,7:10);
B_Eq_Es(1:4,1:3) = A(7:10,1:3);    
% Équation sortie
C_Eq_Es = [1 1 1 1;
           1 1 1 1;
           1 1 1 1;
           1 1 1 1;];
       
D_Eq_Es = [0 0 0 ;
           0 0 0 ;
           0 0 0 ;
           0 0 0]; 

