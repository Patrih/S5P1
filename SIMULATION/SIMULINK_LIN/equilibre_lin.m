addpath ../../Matlab
run ('systeme_matriciel') % Contient identification MC

%Préparation pour le modèle simulink

%Équilibre

%% Équilibre
%------------------------------------------------------------------------------%
%section a mettre en commentaire (Ctrl+R) si on veut les équations avec les
%variables Z0_eq, Xs_eq et Ys_eq

%     Z0_eq Xs_eq  Ys_eq
dr = 100;
% % for x = linspace(-Rabc_ini,Rabc_ini,100)
    for y = linspace(-Rabc_ini,Rabc_ini,dr) 

 E = [ 0.005 0 y];

% E = [0.020 0 0]

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


VA_EQ(floor(dr/2*y/Rabc_ini+dr/2+1))= entrees_eq(1);

VB_EQ(floor(dr/2*y/Rabc_ini+dr/2+1))= entrees_eq(2);

VC_EQ(floor(dr/2*y/Rabc_ini+dr/2+1))= entrees_eq(3);

    end
    sda = -Rabc_ini:Rabc_ini*2/dr:Rabc_ini;
plot ( sda,VA_EQ)
hold on 
plot (sda, VB_EQ)
plot (sda, VC_EQ)
legend('va','vb','vc')

