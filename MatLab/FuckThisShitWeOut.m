close all 
clear all
clc
syms Ya Yb Yc Xa Xb Xc Fa Fb Fc Dp Do Dz Fk Yk Xk
% A=[1 0 0;
%    0 2 0;
%    0 0 3];
% B=[1 2 3;
%    4 5 6;
%    7 8 9];
% C=[10 0 0;
%    0 11 0;
%    0 0 12];
% 
% D = A*(B*C)
% E = (A*B)*C
% F = (A.*B).*C
% G = A.*(B.*C)
% d = B*C;
% e = A*B;
% H = A*d
% I = e*C

% U = [Yk 0 0;
%      0 -Xk 0;
%      0 0 1];
% Y = [Fa/Dp Fa/Do Fa/Dz;
%      Fb/Dp Fb/Do Fb/Dz;
%      Fc/Dp Fc/Do Fc/Dz;];
% Y1 = [Fk 0 0;
%       0 Fk 0;
%       0 0 Fk];
Y2 =[1 1 1;
     1 1 1;
     1 1 1];
Y3 = [1/Dp 0 0;
      0 1/Do 0;
      0 0 1/Dz];
 Y4 = [Fk*Yk 0        0 ;
      0      -(Fk*Xk) 0 ;
      0      0        Fk;];
 Y5 = subs(Y4,Fk*Yk,Fa*Ya+Fb*Yb+Fc*Yc);
 Y6 = subs(Y5,-(Fk*Xk),-(Fa*Xa+Fb*Xb+Fc*Xc));
 Y7 = subs(Y6,Fk,Fa+Fb+Fc);
 Y8 = subs(Y7,Fa*Ya+Fb*Yb+Fc*Yc,Yb*(Fb-Fc));
 
 