%-----------------------------------------------------
% Titre : LINEARISATION
% Date de création : 08-10-2019
% Auteur : Louis-Daniel Gaulin
%-----------------------------------------------------
clc
close all
clear all

syms masseS     % Masse  de la sphère

syms masseP inertiePx inertiePy % masse et inertie plaque

syms Ra La      % resistance et inductance des actionneurs

syms XA YA ZA   % position inertielle des éléments fixes
syms XB YB ZB 
syms XC YC ZC 
syms XD YD ZD 
syms XE YE ZE 
syms XF YF ZF 


syms Px Py Pz   % position de la sphère dans le repère inertiel 
% syms Vx Vy Vz   % vitesse de la sphère dans le repère inertiel

syms Ax Ay      % angle de rotation de la plaque phy autour de l’axe Tx et theta autour de l'axe Iy
syms Wx Wy      % vitesse angulaire de la plaque Wx autour de l’axe Ix et Wy autour de l'axe Iy

% syms FA FB FC   % forces appliquée par les actionneurs sur la plaque (positif vers le bas) 
syms MA MB MC   % couple appliquée par les actionneurs sur la plaque 
syms VA VB VC   % tension électrique appliquée aux actionneurs
syms IA IB IC   % courant électrique dans les actionneurs 

syms Ya Yb Yc   % 

syms ae0 ae1 ae2 ae3
syms be1
syms as0 as1 as2 as3

syms theta phi z0

syms Jp Mp Fs

syms g 

Za = z0 - XA*theta + YA*phi;
Zb = z0 - XB*theta + YB*phi;
Zc = z0 - XC*theta + YC*phi;

Fek_A = ((IA^2 + be1*abs(IA))*sign(IA))/(ae0 + ae1*Za + ae2*Za^2 + ae3*Za^3);
Fsk_A = -1/(as0 + as1*Za + as2*Za^2 + as3*Za^3) ;
FA = Fek_A + Fsk_A;

Fek_B = ((IB^2 + be1*abs(IB))*sign(IB))/(ae0 + ae1*Zb + ae2*Zb^2 + ae3*Zb^3);
Fsk_B = -1/(as0 + as1*Zb + as2*Zb^2 + as3*Zb^3) ;
FB = Fek_B + Fsk_B;

Fek_C = ((IC^2 + be1*abs(IC))*sign(IC))/(ae0 + ae1*Zc + ae2*Zc^2 + ae3*Zc^3);
Fsk_C = -1/(as0 + as1*Zc + as2*Zc^2 + as3*Zc^3) ;
FC = Fek_C + Fsk_C;

dIA = VA/La - IA*Ra/La;      %F1
dIB = VB/La - IB*Ra/La;      %F2
dIC = VC/La - IC*Ra/La;      %F3

Az = (-FA - FB - FC + masseP*g + masseS *g)/masseP;         %F4
alpha_phi = (FA*XA + FB*XB +FC*XC + Px*Fs)/inertiePx;       %F5
alpha_theta = (-FA*YA - FB*YB - FC*YC - Fs*Py)/inertiePy;   %F6

Vx = -(5*g*theta/7);         %F7
Vy = (5*g*phi/7);            %F8

PP = jacobian([Az , alpha_phi , alpha_theta] , [phi , theta , z0]);

PS = jacobian([Az , alpha_phi , alpha_theta] , [Px , Py]);

PC = jacobian([Az , alpha_phi , alpha_theta] , [IA , IB , IC]);

SP = jacobian([Vx , Vy],[phi , theta]);

CC = jacobian([dIA , dIB , dIC],[IA , IB , IC]);

Tdef = jacobian([dIA , dIB , dIC],[VA , VB , VC]);