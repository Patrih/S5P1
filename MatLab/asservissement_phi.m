% Projet de session 
%% Fonction phi
clc ; clear all ; close all ;
phi_num = [9590];
phi_denum = [1 31.3 -1780 -5.57e4];
FCT_phi = tf(phi_num,phi_denum);


% graphique

% spécifications du client
MP = 5;
Ts = 0.03;
Tp =  0.025;
Tm_10_90 = 0.02;
Err_echelon = 0;

% Traduction en terme d'ingénierie
phi = atan(-pi/log(MP/100));
zeta = cos(phi);

% Pour trouver lequel des Wn est le plus grand 
wn1 = 4/(zeta*Ts) ; % wn avec Ts
wn2 = (1 + 1.1*zeta + 1.4*(zeta^2))/Tm_10_90; % wn avec tm_10_90
wn3 = pi/(Tp*sqrt(1-zeta^2));

wn = max([wn1, wn2, wn3]);

pole_desire1 = -(zeta*wn) + (wn*sqrt(1-(zeta^2)))*1i;
pole_desire2 = -(zeta*wn) - (wn*sqrt(1-(zeta^2)))*1i;

% -----------------------------------------
% AVANCE DE PHASE -------------------------
% -----------------------------------------


Phase_ajouter = rad2deg((angle(polyval(phi_num,pole_desire1))-angle(polyval(phi_denum,pole_desire1))));
delta_phi_par_AvPh = -180 - Phase_ajouter+360;
temps = linspace(0,1,10000)';
echelon = ones(size(temps));
index = 0;
ts=1;
mpaa = 1;

% for d = 0:1:28
%     for c = 1:0.1:1.5
%         for a = 1:0.1:1.5
%             for e = 250:1:250
%                 f=-d;
% % b = 5 limite rad/s = 950  
% nombre_AvPh = 5;
% modification_Dphi_pole = 72;
% modification_Dphi_zero = -modification_Dphi_pole;
% modulation_Gain_Kacc = 0.6;
% modification_Gain_Kp = 1.3;
% modification_Regle_Pouce = 250;
% % b = 2 lim rad/5 = 5000
nombre_AvPh = 2;
modification_Dphi_pole = 25;
modification_Dphi_zero = -modification_Dphi_pole;
modulation_Gain_Kacc = 1.5;
modification_Gain_Kp = 1.5;
modification_Regle_Pouce = 250;

delta_phi_par_AvPh = (delta_phi_par_AvPh/nombre_AvPh);
alpha = rad2deg(angle(pole_desire1));

phi_z_AvPh = (alpha + delta_phi_par_AvPh+modification_Dphi_zero)/2;
phi_p_AvPh = (alpha - delta_phi_par_AvPh-modification_Dphi_pole)/2;
% Emplacement du pole et du zéro
z_AvPh = real(pole_desire1) - (imag(pole_desire1)/tand(phi_z_AvPh));
p_AvPh = real(pole_desire1) - (imag(pole_desire1)/tand(phi_p_AvPh));

% Num/Dénum de l'avance de phase
num_avancedephase = [1 -z_AvPh];
den_avancedephase = [1 -p_AvPh];

Fct_AvPh = tf(num_avancedephase,den_avancedephase);

[num_AvPh_tot, den_AvPh_tot] = tfdata(Fct_AvPh^nombre_AvPh,'v');
Kacc = modulation_Gain_Kacc*norm(polyval(phi_denum,pole_desire1)*polyval(den_AvPh_tot,pole_desire1)/(polyval(phi_num,pole_desire1)*polyval(num_AvPh_tot,pole_desire1)) );

% CASCADE avec les compensateur 

fct_AvPh_phi = Fct_AvPh^nombre_AvPh*FCT_phi*Kacc;

[num_AvPh_phi,denum_AvPh_phi]=tfdata(fct_AvPh_phi,'v');

%
% -----------------------------------------
% RETARD DE PHASE -------------------------
% -----------------------------------------

z_PI = real(pole_desire1)/modification_Regle_Pouce;

num_PI = [1 -z_PI];
denum_PI = [1 0];
Kp = modification_Gain_Kp*abs((polyval(num_PI,pole_desire1)*polyval(num_AvPh_phi,pole_desire1))/(polyval(denum_PI,pole_desire1)*polyval(denum_AvPh_phi,pole_desire1)));
G_PI = tf(num_PI,denum_PI);

% CASCADE avec les compensateur 

fonction_Finale = fct_AvPh_phi*Kp*G_PI;

[num_Finale,den_Finale]=tfdata(fonction_Finale,'v');

% Erreur régime permanent (rampe unitaire)
FTBF_Finale = feedback(fonction_Finale,1);

%Réponse à l'échelon avec systeme original 

test = lsim(FTBF_Finale,echelon,temps);

% wwwjjjw = wwwjjjw+1;
% mp = max(test(6:end))-1;
% position = find(test < 0.98 | test > 1.02,1, 'last');
% if t(position)<Ts & mp<1
%     
% if mp<0.05
% disp('------------------------------------------------------------------------------')    
% disp(['mp = ', num2str(mp),' Pour module Ka = ',num2str(c),' et module Kr =',num2str(a)])
% disp(['pour un ordre ', num2str(b), ' une modulation d''angle ',num2str(d),' et relge du pouce ' num2str(e)]) 
% disp('------------------------------------------------------------------------------')
% valeur = [mp,c,a,b,d,e];
% else
%     disp(['test no ', num2str(wwwjjjw),' Avec mp = ',num2str(mp),' et ts = ',num2str(t(position))])
%     if mp<mpaa
%         mpaa=mp
%         valeurmin = [mp,c,a,b,d,e,f];
%     end
%     if t(position)<ts && mp<0.3
%             mpaav = mp;
%             ts = t(position);
%             valeurmints = [mp,ts,c,a,b,d,e,f];
%     end
% end
% end
%             end
%         end
%     end
% end

%%
plot(temps,test)
hold on
plot(temps,1.05*echelon,':');
plot(temps,1.02*echelon,':');
plot(temps,0.98*echelon,':');
axis([0 0.1 0.7 1.5])

figure()
plot(real(pole_desire1),imag(pole_desire1),'p')
hold on
plot(real(pole_desire2),imag(pole_desire2),'p')
rlocus(fonction_Finale)

figure()
margin(fonction_Finale)
figure()
nyquist(fonction_Finale)
%%
testdiscret(FCT_phi)