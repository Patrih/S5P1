equilibre;

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
%% syst�me axe phi

A_phi = [0       1   0      ;
         PP_dec(1,1) 0   PC_dec(1,1);
         0       0   CC_dec(1,1)];
     
B_phi = [0 0 CV_dec(1,1)]';

C_phi = [1 0 0];
         

D_phi = [0];

[num_phi,den_phi] = ss2tf(A_phi,B_phi,C_phi,D_phi);

TF_p_phi = tf(num_phi,den_phi);
figure()
rlocus(TF_p_phi)
title('P�le et z�ro du sous syst�me phi')
%% syst�me axe theta
A_theta = [0 1 0 ;
          PP_dec(2,2) 0 PC_dec(2,2);
          0       0 CC_dec(2,2)];
     
B_theta = [0 0 CV_dec(2,2)]';

C_theta = [1 0 0];

D_theta = [0];

[num_theta,den_theta] = ss2tf(A_theta,B_theta,C_theta,D_theta);

TF_p_theta = tf(num_theta,den_theta);

figure()
rlocus(TF_p_theta)
title('P�le et z�ro du sous syst�me theta')
%% syst�me z
A_z = [0 1 0 ;
          PP_dec(3,3) 0 PC_dec(3,3);
          0       0 CC_dec(3,3)];
     
B_z = [0 0 CV_dec(3,3)]';

C_z = [1 0 0];

D_z = [0];

[num_z,den_z] = ss2tf(A_z,B_z,C_z,D_z);

TF_p_z= tf(num_z(1,:),den_z);
figure()
rlocus(TF_p_z)
title('P�le et z�ro du sous syst�me z')
%% syst�me x
A_x = [0 1;
       0 0;];
   
B_x = [0 SP_dec(1,2)]'; % vraiment pas sur pour la matrice B 

C_x = [1 0;
       0 1;];
   
D_x = [0 0]';

[num_x,den_x] = ss2tf(A_x,B_x,C_x,D_x);

TF_p_x = tf(num_x(1,:),den_x);
TF_v_x = tf(num_x(2,1:3),den_x);
figure()
rlocus(TF_p_x)
title('P�le et z�ro du sous syst�me position sph�re x')
figure()
rlocus(TF_v_x)
title('P�le et z�ro du sous syst�me vitesse sph�re x')
%% syst�me y

A_y = [0 1;
       0 0;];
   
B_y = [0 SP_dec(2,1)]'; % vraiment pas sur pour la matrice B 

C_y = [1 0;
       0 1;];
   
D_y = [0 0]';

[num_y,den_y] = ss2tf(A_y,B_y,C_y,D_y);

TF_p_y = tf(num_y(1,1:3),den_y);
TF_v_y = tf(num_y(2,1:3),den_y);

figure()
rlocus(TF_p_y)
title('P�le et z�ro du sous syst�me position sph�re y')
figure()
rlocus(TF_v_y)
title('P�le et z�ro du sous syst�me vitesse sph�re y')