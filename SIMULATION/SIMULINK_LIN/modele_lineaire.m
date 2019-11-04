

%% Constantes à l'équilibres 
% À REMPLIR OU LIER AVEC D'AUTRES FICHIERS
%Entrées
Va_eq = 1;
Vb_eq = 1;
Vc_eq = 1;

IN_eq = [Va_eq Vb_eq Vc_eq];
%Variable d'État à l'Équilibre
phi_eq = 0;
theta_eq = 0;
Z_eq = 15e-3;
Ophi_eq = 0;
Otheta_eq = 0;
Vz_eq = 0;
Xs_eq = 0; %input 
Ys_eq = 0;
Vxs_eq = 0;
Vys_eq = 0;
Ia_eq = 0;
Ib_eq = 0;
Ic_eq = 0;

%VE pour variables d'états
VE_Eq = [phi_eq theta_eq Z_eq Ophi_eq Otheta_eq Vz_eq Xs_eq Ys_eq Vxs_eq Vys_eq Ia_eq Ib_eq Ic_eq];

%Sortie à l'équilibre

dD_eq = 0;
dE_eq = 0;
dF_eq = 0;
%S pour sortie
S_eq = [dD_eq dE_eq dF_eq];






