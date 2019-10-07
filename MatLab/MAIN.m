%-----------------------------------------------------
% Titre : MAIN
% Date de création : 07-10-2019
% Auteur : Louis-Daniel Gaulin
%-----------------------------------------------------

syms masseS     % Masse  de la sphère

syms masseP inertiePx intertiePy % masse et inertie plaque

syms XA YA ZA   % position inertielle des éléments fixes K (K = A, B, C, D, E, F) 
syms XB YB ZB 
syms XC YC ZK 
syms XK YK ZK 
syms XK YK ZK 
syms XK YK ZK 


syms Px Py Pz   % position de la sphère dans le repère inertiel 
syms Vx Vy Vz   % vitesse de la sphère dans le repère inertiel

syms Ax Ay      % angle de rotation de la plaque phy autour de l’axe Tx et theta autour de l'axe Iy
syms Wx Wy      % vitesse angulaire de la plaque Wx autour de l’axe Ix et Wy autour de l'axe Iy

syms FA FB FC   % forces appliquée par les actionneurs sur la plaque (positif vers le bas) 
syms MA MB MC   % couple appliquée par les actionneurs sur la plaque 
syms VA VB VC   % tension électrique appliquée aux actionneurs
syms IA IB IC   % courant électrique dans les actionneurs 

syms Ya Yb Yc   % 

% ? _??? : réfère à des variables mesurées
% ? _??? : réfère aux variables désirées ou commandées
% ? _??? : réfère aux variables initiales
% ? _??? : réfère aux variables finales
% ? _?? : réfère aux variables à l’équilibre

















