addpath ../../Matlab
run ('systeme_matriciel') % Contient identification MC

%Préparation pour le modèle simulink

%Équilibre

%% Équilibre
%------------------------------------------------------------------------------%
%section a mettre en commentaire (Ctrl+R) si on veut les équations avec les
%variables Z0_eq, Xs_eq et Ys_eq

%     Z0_eq   Xs_eq  Ys_eq
 E =  [0.015   0       0];

A = eval(subs (A,[Z0_eq,Xs_eq,Ys_eq],E));

B = eval(subs (B,[Z0_eq,Xs_eq,Ys_eq],E));

C = eval(subs (C,[Z0_eq,Xs_eq,Ys_eq],E));

D = eval(subs (D,[Z0_eq,Xs_eq,Ys_eq],E));


%------------------------------------------------------------------------------%

Ophi_eq = 0;
Otheta_eq = 0;
Vz_eq = 0;
Vsx_eq = 0;
Vsy_eq = 0;

%Entrées à l'équilibre ont déjà une valeur 

entrees_eq = [Va_eq Vb_eq Vc_eq]';

VE_eq = [phi_eq theta_eq Z0_eq Ophi_eq Otheta_eq Vz_eq Xs_eq Ys_eq Vsx_eq Vsy_eq Ia_eq Ib_eq Ic_eq]';

sorties_eq = [Z0_eq Z0_eq Z0_eq Xs_eq Ys_eq Vsx_eq Vsy_eq]';



entrees_eq = eval(subs (entrees_eq,[Z0_eq,Xs_eq,Ys_eq],E));

VE_eq = eval(subs (VE_eq,[Z0_eq,Xs_eq,Ys_eq],E));

sorties_eq = eval(subs (sorties_eq,[Z0_eq,Xs_eq,Ys_eq],E));


