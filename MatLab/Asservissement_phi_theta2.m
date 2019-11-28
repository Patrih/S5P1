<<<<<<< HEAD
%% Fonction phi
clear all ; close all ;
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
temps = linspace(0,0.4,100000)';
echelon = ones(size(temps));

% Traduction en terme d'ingénierie
phi = atan(-pi/log(MP/100));
zeta1 = cos(phi);

nombre_AvPh = 3;
modification_Dphi_zero = -46;
modification_Regle_Pouce = 200;
modification_Dphi_pole = -modification_Dphi_zero;
gain_Kp = 1.76;
gain_Ka = 0.54;
zeta = zeta1+0.11*zeta1;

wn1 = 4/(zeta*Ts) ; % wn avec Ts
wn2 = (1 + 1.1*zeta + 1.4*(zeta.^2))/Tm_10_90; % wn avec tm_10_90
wn3 = pi/(Tp*sqrt(1-zeta^2));

wn = max([wn1, wn2, wn3]);

pole_desire1 = -(zeta*wn) + (wn*sqrt(1-(zeta^2)))*1i;
pole_desire2 = -(zeta*wn) - (wn*sqrt(1-(zeta^2)))*1i;

% -----------------------------------------
% AVANCE DE PHASE -------------------------
% -----------------------------------------


Phase_ajouter = rad2deg((angle(polyval(phi_num,pole_desire1))-angle(polyval(phi_denum,pole_desire1))));
delta_phi_par_AvPh = (-180 - Phase_ajouter+360);



delta_phi_par_AvPh = (delta_phi_par_AvPh)/nombre_AvPh;
alpha = rad2deg(angle(pole_desire1));

phi_z_AvPh = (alpha + delta_phi_par_AvPh+modification_Dphi_zero)/2;
phi_p_AvPh = (alpha - delta_phi_par_AvPh-modification_Dphi_pole)/2;

% Emplacement du pole et du zéro
z_AvPh = (real(pole_desire1) - (imag(pole_desire1)/tand(phi_z_AvPh)));
p_AvPh = (real(pole_desire1) - (imag(pole_desire1)/tand(phi_p_AvPh)));

num_avancedephase = [1 -z_AvPh];
den_avancedephase = [1 -p_AvPh];

Fct_AvPh = tf(num_avancedephase,den_avancedephase);

[num_AvPh_tot, den_AvPh_tot] = (tfdata(Fct_AvPh^nombre_AvPh,'v'));

Kacc = gain_Ka*norm((polyval(phi_denum,pole_desire1)*polyval(den_AvPh_tot,pole_desire1))/(polyval(phi_num,pole_desire1)*polyval(num_AvPh_tot,pole_desire1) ));

fct_AvPh = Fct_AvPh^nombre_AvPh *Kacc;
[num_AvPh_phi,denum_AvPh_phi]=tfdata(fct_AvPh*FCT_phi,'v');

% PI

z_PI = real(pole_desire1)/modification_Regle_Pouce;
p_PI = 0;

num_PI = [1 -z_PI];
denum_PI = [1 -p_PI];

Kp = abs((polyval(num_PI,pole_desire1)*polyval(num_AvPh_phi,pole_desire1))/(polyval(denum_PI,pole_desire1)*polyval(denum_AvPh_phi,pole_desire1)));
G_PI = tf(num_PI,denum_PI)*Kp;

Com_Finale = fct_AvPh*G_PI;
fonction_Finale = gain_Kp*Com_Finale*FCT_phi;
FTBF_Finale = feedback(fonction_Finale,1);

test = lsim(FTBF_Finale,echelon,temps);
wwwjjjw = 0;
wwwjjjw = wwwjjjw+1;
mp = max(test(6:end))-1;
position = find(test < 0.98 | test > 1.02,1, 'last');
% if temps(position)<Ts & mp<1 & p_AvPh>-1000
%     
%     disp(['test no ', num2str(wwwjjjw),' Avec mp = ',num2str(mp),' ts = ',num2str(temps(position)),' Pour module règle = ',num2str(modification_Regle_Pouce), ' une modulation d''angle ',num2str(modification_Dphi_pole),' et zeta = ' num2str(zeta)])
%     if mp<mpaa
%         mpaa=mp
%         if mp<0.05
%             disp('------------------------------------------------------------------------------')    
%             disp(['mp = ', num2str(mp),' Pour module Ka = ',num2str(modulation_Gain_Kacc),' et module Kr =',num2str(modification_Gain_Kp)])
%             disp(['pour un ordre ', num2str(nombre_AvPh), ' une modulation d''angle ',num2str(modification_Dphi_pole)]) 
%             disp('------------------------------------------------------------------------------')
%             valeur = [mp,temps(position),zeta,modulation_Gain_Kacc,modification_Gain_Kp,nombre_AvPh,modification_Dphi_pole,modification_Regle_Pouce,modification_Dphi_zero];
%         else        
%             valeurmin = [mp,temps(position),zeta,modulation_Gain_Kacc,modification_Gain_Kp,nombre_AvPh,modification_Dphi_pole,modification_Regle_Pouce,modification_Dphi_zero];
%     end
%     if temps(position)<ts && mp<0.6
%             mpaav = mp;
%             ts = temps(position);
%             valeurmints = [mp,ts,zeta,modulation_Gain_Kacc,modification_Gain_Kp,nombre_AvPh,modification_Dphi_pole,modification_Regle_Pouce,modification_Dphi_zero];
%     end
% end
% elseif  mod(wwwjjjw,50)==0
%     disp(['essai no ', num2str(wwwjjjw)])
% end


%%
disp('------------------------------------------------------------------------------')    
disp(['mp = ', num2str(mp*100), '% ts = ', num2str(temps(position)),' Gain Kp = ', num2str(gain_Kp), ' et gain Kp = ', num2str(gain_Ka)])
disp(['pour un ordre ', num2str(nombre_AvPh), ', une modulation d''angle ',num2str(modification_Dphi_pole), ' et règle du pouce = ', num2str(modification_Regle_Pouce)]) 
if temps(position)<Ts & mp<0.05
    disp('Oh oui, oh fuck oui')
end
if p_AvPh<-1000
    disp('a fuck!!!!')
end
disp('------------------------------------------------------------------------------')
figure()
plot(real(pole_desire1),imag(pole_desire1),'p')
hold on
plot(real(pole_desire2),imag(pole_desire2),'p')
rlocus(fonction_Finale)

figure()
margin(fonction_Finale)
figure()
nyquist(fonction_Finale)

figure()
plot(temps,test)
hold on
plot(temps,1.05*echelon,':');
plot(temps,1.02*echelon,':');
plot(temps,0.98*echelon,':');
% axis([0 0.1 0.7 2])
%%
testdiscret(Com_Finale)
=======
%% Fonction phi
clear all ; close all ;
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
temps = linspace(0,0.4,100000)';
echelon = ones(size(temps));

% Traduction en terme d'ingénierie
phi = atan(-pi/log(MP/100));
zeta1 = cos(phi);

nombre_AvPh = 2;
modification_Dphi_zero = -7;
Regle_Pouce = 10;
modification_Dphi_pole = 7;
gain_Kp = 1.01;
gain_Ka = 1.1;
zeta = zeta1+0.125*zeta1;

wn1 = 4/(zeta*Ts) ; % wn avec Ts
wn2 = (1 + 1.1*zeta + 1.4*(zeta.^2))/Tm_10_90; % wn avec tm_10_90
wn3 = pi/(Tp*sqrt(1-zeta^2));

wn = max([wn1, wn2, wn3]);

pole_desire1 = -(zeta*wn) + (wn*sqrt(1-(zeta^2)))*1i;
pole_desire2 = -(zeta*wn) - (wn*sqrt(1-(zeta^2)))*1i;

% -----------------------------------------
% AVANCE DE PHASE -------------------------
% -----------------------------------------


Phase_ajouter = rad2deg((angle(polyval(phi_num,pole_desire1))-angle(polyval(phi_denum,pole_desire1))));
delta_phi_par_AvPh = (-180 - Phase_ajouter+360);



delta_phi_par_AvPh = (delta_phi_par_AvPh)/nombre_AvPh;
alpha = rad2deg(angle(pole_desire1));

phi_z_AvPh = (alpha + delta_phi_par_AvPh+modification_Dphi_zero)/2;
phi_p_AvPh = (alpha - delta_phi_par_AvPh-modification_Dphi_pole)/2;

% Emplacement du pole et du zéro
z_AvPh = (real(pole_desire1) - (imag(pole_desire1)/tand(phi_z_AvPh)));
p_AvPh = (real(pole_desire1) - (imag(pole_desire1)/tand(phi_p_AvPh)));

num_avancedephase = [1 -z_AvPh];
den_avancedephase = [1 -p_AvPh];

Fct_AvPh = tf(num_avancedephase,den_avancedephase);

[num_AvPh_tot, den_AvPh_tot] = (tfdata(Fct_AvPh^nombre_AvPh,'v'));

Kacc = gain_Ka*norm((polyval(phi_denum,pole_desire1)*polyval(den_AvPh_tot,pole_desire1))/(polyval(phi_num,pole_desire1)*polyval(num_AvPh_tot,pole_desire1) ));

fct_AvPh = Fct_AvPh^nombre_AvPh *Kacc;
[num_AvPh_phi,denum_AvPh_phi]=tfdata(fct_AvPh*FCT_phi,'v');

% PI

z_PI = real(pole_desire1)/Regle_Pouce;
p_PI = 0;

num_PI = [1 -z_PI];
denum_PI = [1 -p_PI];

Kp = abs((polyval(num_PI,pole_desire1)*polyval(num_AvPh_phi,pole_desire1))/(polyval(denum_PI,pole_desire1)*polyval(denum_AvPh_phi,pole_desire1)));
G_PI = tf(num_PI,denum_PI)*Kp;

Com_Finale = fct_AvPh*G_PI;
fonction_Finale = gain_Kp*Com_Finale*FCT_phi;
FTBF_Finale = feedback(fonction_Finale,1);

test = lsim(FTBF_Finale,echelon,temps);
wwwjjjw = 0;
wwwjjjw = wwwjjjw+1;
mp = max(test(6:end))-1;
position = find(test < 0.98 | test > 1.02,1, 'last');
% if temps(position)<Ts & mp<1 & p_AvPh>-1000
%     
%     disp(['test no ', num2str(wwwjjjw),' Avec mp = ',num2str(mp),' ts = ',num2str(temps(position)),' Pour module règle = ',num2str(modification_Regle_Pouce), ' une modulation d''angle ',num2str(modification_Dphi_pole),' et zeta = ' num2str(zeta)])
%     if mp<mpaa
%         mpaa=mp
%         if mp<0.05
%             disp('------------------------------------------------------------------------------')    
%             disp(['mp = ', num2str(mp),' Pour module Ka = ',num2str(modulation_Gain_Kacc),' et module Kr =',num2str(modification_Gain_Kp)])
%             disp(['pour un ordre ', num2str(nombre_AvPh), ' une modulation d''angle ',num2str(modification_Dphi_pole)]) 
%             disp('------------------------------------------------------------------------------')
%             valeur = [mp,temps(position),zeta,modulation_Gain_Kacc,modification_Gain_Kp,nombre_AvPh,modification_Dphi_pole,modification_Regle_Pouce,modification_Dphi_zero];
%         else        
%             valeurmin = [mp,temps(position),zeta,modulation_Gain_Kacc,modification_Gain_Kp,nombre_AvPh,modification_Dphi_pole,modification_Regle_Pouce,modification_Dphi_zero];
%     end
%     if temps(position)<ts && mp<0.6
%             mpaav = mp;
%             ts = temps(position);
%             valeurmints = [mp,ts,zeta,modulation_Gain_Kacc,modification_Gain_Kp,nombre_AvPh,modification_Dphi_pole,modification_Regle_Pouce,modification_Dphi_zero];
%     end
% end
% elseif  mod(wwwjjjw,50)==0
%     disp(['essai no ', num2str(wwwjjjw)])
% end


%%
disp('------------------------------------------------------------------------------')    
disp(['mp = ', num2str(mp*100), '% ts = ', num2str(temps(position)),' Gain Kp = ', num2str(gain_Kp), ' et gain Kp = ', num2str(gain_Ka)])
disp(['pour un ordre ', num2str(nombre_AvPh), ', une modulation d''angle ',num2str(modification_Dphi_pole), ' et règle du pouce = ', num2str(Regle_Pouce)]) 
if temps(position)<Ts & mp<0.05
    disp('Oh oui, oh fuck oui')
end
if p_AvPh<-1000
    disp(['a fuck!!!! les pôles sont à : ', num2str(p_AvPh)])
end
disp('------------------------------------------------------------------------------')
figure()
plot(real(pole_desire1),imag(pole_desire1),'p')
hold on
plot(real(pole_desire2),imag(pole_desire2),'p')
rlocus(fonction_Finale)

figure()
nyquist(fonction_Finale)
grid on
figure()
margin(fonction_Finale)


figure()
plot(temps,test)
hold on
plot(temps,1.05*echelon,':');
plot(temps,1.02*echelon,':');
plot(temps,0.98*echelon,':');
axis([0 0.1 0.7 2])
%%
<<<<<<< HEAD
testdiscret(Com_Finale)
%%
numDiscret = [0.96826350433224783743 0.87241036731407162197 0.87241019943908271195];
denDiscret = [1 -0.017813316233156323287 -0.017813316233156323287];
compensateursDiscret = tf(numDiscret,denDiscret);

[zeroes, poles, gain] = tf2zp(compensateursDiscret.Numerator{:}, compensateursDiscret.Denominator{:});
    poles(1) = 1-1e-6;
    [num_comp, den_comp] = zp2tf(zeroes, poles, gain);

compensateursDiscret = tf(num_comp, den_comp)

=======
% testdiscret(Com_Finale)
>>>>>>> 2491c1aa9a34795ac5dadf10bc5f678ec2d6e94e
>>>>>>> 9cbfb8652b834512335d92666aa420ceef63edaa
