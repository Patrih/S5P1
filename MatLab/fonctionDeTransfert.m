clear all
close all
clc

% Fonction de transfert
% 
%     Fait par : 
%     Ce qu'il reste a faire :
%         -
%         -
%         -
%         -
%         
%     


%% Data

load('Decouplage')

%% système axe phi

A_phi = [0 1 0 ;
         A_plaque(4:1) 0 A_plaque(4:7);
         0 0 A_plaque(7:7); ];
     
B_phi = [0 0 B_plaque(7:1)]';

C_phi = [C_plaque(1:1) 0 0];

D_phi = [];

[num_phi,den_phi] = ss2tf(A_phi,B_phi,C_phi,D_phi);

TF_phi = tf(num_phi,den_phi);
%% système axe theta
A_theta = [0 1 0 ;
         A_plaque(5:2) 0 A_plaque(5:8);
         0 0 A_plaque(8:8); ];
     
B_theta = [0 0 B_plaque(8:2)]';

C_theta = [C_plaque(2:2) 0 0];

D_theta = [];

[num_theta,den_theta] = ss2tf(A_theta,B_theta,C_theta,D_theta);

TF_theta = tf(num_theta,den_theta);

%% système z
A_z = [0 1 0 ;
         A_plaque(6:3) 0 A_plaque(6:9);
         0 0 A_plaque(9:9); ];
     
B_z = [0 0 B_plaque(9:3)]';

C_z = [C_plaque(3:3) 0 0];

D_z = [];

[num_z,den_z] = ss2tf(A_z,B_z,C_z,D_z);

TF_z= tf(num_z,den_z);

%% système x
A_x = [0 1;
       0 0;];
   
B_x = [];

C_x = [1 0;
       0 1;];
   
D_x = [];

[num_x,den_x] = ss2tf(A_x,B_x,C_x,D_x);

TF_x = tf(num_x,den_x);
%% système y

A_y = [0 1;
       0 0;];
   
B_y = [];

C_y = [1 0;
       0 1;];
   
D_y = [];

[num_y,den_y] = ss2tf(A_y,B_y,C_y,D_y);

TF_y = tf(num_y,den_y);
