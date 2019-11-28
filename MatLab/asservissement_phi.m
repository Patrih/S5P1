% Projet de session 
%% Fonction phi
clc ; clear all ; close all ;
%
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
zeta1 = cos(phi);
temps = linspace(0,1,100000)';
echelon = ones(size(temps));
index = 0;
ts=1;
mpaa = 0.5264;
wwwjjjw = 0;
N = 1000;
zeta = linspace(zeta1,0.99,N);
modification_Regle_Pouce = linspace(1,15,N);
modification_Dphi_pole = linspace(-15,15,N);
modification_Dphi_zero = -modification_Dphi_pole;
modulation_Gain_Kacc = linspace(0.1,1.5,N);
modification_Gain_Kp = linspace(0.1,1.5,N);


% zeta = 0.9501;
% modulation_Gain_Kacc = 2.5;
% modification_Dphi_pole = 10;
% nombre_AvPh = 2;
% Pour trouver lequel des Wn est le plus grand 
wn1 = 4./(zeta*Ts) ; % wn avec Ts
wn2 = (1 + 1.1*zeta + 1.4*(zeta.^2))/Tm_10_90; % wn avec tm_10_90
wn3 = pi./(Tp*sqrt(1-zeta.^2));

wn = max([wn1, wn2, wn3]);

pole_desire1 = -(zeta*wn) + (wn*sqrt(1-(zeta.^2)))*1i;
pole_desire2 = -(zeta*wn) - (wn*sqrt(1-(zeta.^2)))*1i;

% -----------------------------------------
% AVANCE DE PHASE -------------------------
% -----------------------------------------


Phase_ajouter = rad2deg((angle(polyval(phi_num,pole_desire1))-angle(polyval(phi_denum,pole_desire1))));
delta_phi_par_AvPh = (-180 - Phase_ajouter+360);


% modification_Dphi_pole = 0;
% modification_Dphi_zero=-modification_Dphi_pole;
% for nombre_AvPh = 3:-1:2
%     for modulation_Gain_Kacc = 0.1:0.1:1.5
%         for modification_Gain_Kp = 0.1:0.1:1.5
%             for modification_Regle_Pouce = 1:1:10
                

% % b = 2 lim rad/5 = 5000
nombre_AvPh = 2;
nombre_AvPh_exp = ones(length(modification_Dphi_zero),1)*nombre_AvPh;
% modification_Dphi_pole = 10;
% modification_Dphi_zero = -modification_Dphi_pole;
% modulation_Gain_Kacc = 1.2;
% modification_Gain_Kp = 1;
% modification_Regle_Pouce = 8;

delta_phi_par_AvPh = (delta_phi_par_AvPh/nombre_AvPh);
alpha = rad2deg(angle(pole_desire1));

phi_z_AvPh = (alpha + delta_phi_par_AvPh+modification_Dphi_zero)/2;
phi_p_AvPh = (alpha - delta_phi_par_AvPh-modification_Dphi_pole)/2;
% Emplacement du pole et du zéro
z_AvPh = (real(pole_desire1) - (imag(pole_desire1)/tand(phi_z_AvPh)));
p_AvPh = (real(pole_desire1) - (imag(pole_desire1)/tand(phi_p_AvPh)));

% Num/Dénum de l'avance de phase
num_avancedephase = num2cell([ones(length(modification_Dphi_zero),1) -z_AvPh'],2);
den_avancedephase = num2cell([ones(length(modification_Dphi_zero),1) -p_AvPh'],2);

Fct_AvPh = tf(num_avancedephase,den_avancedephase);

[num_AvPh_tot, den_AvPh_tot] = (tfdata(Fct_AvPh.*Fct_AvPh,'v'));
num_AvPh_tot = cell2mat(num_AvPh_tot)';
den_AvPh_tot = cell2mat(den_AvPh_tot);
num_AvPh_totk = [mean(num_AvPh_tot(:,1)) mean(num_AvPh_tot(:,2)) mean(num_AvPh_tot(:,3))];
den_AvPh_totk = [mean(den_AvPh_tot(:,1)) mean(den_AvPh_tot(:,2)) mean(den_AvPh_tot(:,3))];
Kacc = modulation_Gain_Kacc.*norm((polyval(phi_denum,pole_desire1).*polyval(den_AvPh_totk,pole_desire1))./(polyval(phi_num,pole_desire1).*polyval(num_AvPh_totk,pole_desire1) ));

% CASCADE avec les compensateur 

fct_AvPh_phi = Fct_AvPh.*Fct_AvPh.*Kacc'*FCT_phi;

[num_AvPh_phi,denum_AvPh_phi]=tfdata(fct_AvPh_phi,'v');
num_AvPh_phik = [mean(num_AvPh_phi(:,1)) mean(num_AvPh_phi(:,2)) mean(num_AvPh_phi(:,3)) mean(num_AvPh_phi(:,4)) mean(num_AvPh_phi(:,5)) mean(num_AvPh_phi(:,6))];
num_AvPh_phik = [mean(den_AvPh_phi(:,1)) mean(den_AvPh_phi(:,2)) mean(den_AvPh_phi(:,3)) mean(den_AvPh_phi(:,4)) mean(den_AvPh_phi(:,5)) mean(den_AvPh_phi(:,6))];
%
% -----------------------------------------
% RETARD DE PHASE -------------------------
% -----------------------------------------

z_PI = real(pole_desire1)./modification_Regle_Pouce;
p_PI = ones(length(modification_Dphi_zero),1)*0;
num_PI = [ones(length(modification_Dphi_zero),1) -z_PI'];
denum_PI = [ones(length(modification_Dphi_zero),1) p_PI];
num_PIk = [mean(num_PI(:,1)) mean(num_PI(:,2))];
den_PIk = [mean(num_PI(:,1)) mean(num_PI(:,2))];
Kp = modification_Gain_Kp.*abs((polyval(num_PIk,pole_desire1).*polyval(num_AvPh_phi,pole_desire1))./(polyval(denum_PIk,pole_desire1)*polyval(denum_AvPh_phi,pole_desire1)));
G_PI = tf(num2cell(num_PI,2),num2cell(denum_PI,2));

% CASCADE avec les compensateur 

fonction_Finale = fct_AvPh_phi.*Kp.*G_PI;

[num_Finale,den_Finale]=tfdata(fonction_Finale,'v');

% Erreur régime permanent (rampe unitaire)
FTBF_Finale = feedback(fonction_Finale,1);

%Réponse à l'échelon avec systeme original 

test = lsim(FTBF_Finale,echelon,temps);

wwwjjjw = wwwjjjw+1;
mp = max(test(6:end))-1;
position = find(test < 0.98 | test > 1.02,1, 'last');
if temps(position)<Ts & mp<1 & p_AvPh>-1000
    

    disp(['test no ', num2str(wwwjjjw),' Avec mp = ',num2str(mp),' ts = ',num2str(temps(position)),' Pour module règle = ',num2str(modification_Regle_Pouce), ' une modulation d''angle ',num2str(modification_Dphi_pole),' et zeta = ' num2str(zeta)])
    if mp<mpaa
        mpaa=mp
        if mp<0.05
            disp('------------------------------------------------------------------------------')    
            disp(['mp = ', num2str(mp),' Pour module Ka = ',num2str(modulation_Gain_Kacc),' et module Kr =',num2str(modification_Gain_Kp)])
            disp(['pour un ordre ', num2str(nombre_AvPh), ' une modulation d''angle ',num2str(modification_Dphi_pole)]) 
            disp('------------------------------------------------------------------------------')
            valeur = [mp,temps(position),zeta,modulation_Gain_Kacc,modification_Gain_Kp,nombre_AvPh,modification_Dphi_pole,modification_Regle_Pouce,modification_Dphi_zero];
        else        
            valeurmin = [mp,temps(position),zeta,modulation_Gain_Kacc,modification_Gain_Kp,nombre_AvPh,modification_Dphi_pole,modification_Regle_Pouce,modification_Dphi_zero];
    end
    if temps(position)<ts && mp<0.6
            mpaav = mp;
            ts = temps(position);
            valeurmints = [mp,ts,zeta,modulation_Gain_Kacc,modification_Gain_Kp,nombre_AvPh,modification_Dphi_pole,modification_Regle_Pouce,modification_Dphi_zero];
    end
end
elseif  mod(wwwjjjw,50)==0
    disp(['essai no ', num2str(wwwjjjw)])
end


%%
figure()
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
testdiscret(G_PI*Fct_AvPh^nombre_AvPh*Kacc)