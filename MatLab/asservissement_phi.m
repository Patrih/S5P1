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
wa = wn*sqrt(1-zeta^2);

pole1 = -(zeta*wn) + (wn*sqrt(1-(zeta^2)))*1i;
pole2 = -(zeta*wn) - (wn*sqrt(1-(zeta^2)))*1i;
% figure()
% plot(real(pole1),imag(pole1),'p')
% hold on
% plot(real(pole2),imag(pole2),'p')
% rlocus(FCT_phi)

% -----------------------------------------
% AVANCE DE PHASE -------------------------
% -----------------------------------------


Phase_fct = rad2deg((angle(polyval(phi_num,pole1))-angle(polyval(phi_denum,pole1))));
delta_phi = -180 - Phase_fct+360;
t = linspace(0,1,10000)';
u = ones(size(t));
wwwjjjw = 0;
ts=1;
mpaa = 1;
b = 2;
% for d = 0:1:28
%     for c = 1:0.1:1.5
%         for a = 1:0.1:1.5
%             for e = 250:1:250
%                 f=-d;
% % b = 5 limite rad/s = 950  
% d = 72;
% f = -d;
% c = 0.6;
% a = 1.3;
% e = 250;
% % b = 2 lim rad/5 = 5000
d = 25;
f = -d;
c = 1.5;
a = 1.5;
e = 250;
delta_phi1 = (delta_phi/b);
alpha = rad2deg(angle(pole1));
% phi_z = (alpha + delta_phi1-20)/2;% marge max vs gain max
% phi_p = (alpha - delta_phi1-63)/2;% valeur limite pour respecter rad max
% phi_z = (alpha + delta_phi1-45.08)/2;% marge max vs gain max
% phi_p = (alpha - delta_phi1-45.08)/2;% valeur limite pour respecter rad max
phi_z = (alpha + delta_phi1+f)/2;
phi_p = (alpha - delta_phi1-d)/2;
% Emplacement du pole et du zéro
z = real(pole1) - (imag(pole1)/tand(phi_z));
p = real(pole1) - (imag(pole1)/tand(phi_p));

% Num/Dénum de l'avance de phase
num_avancedephase = [1 -z];
den_avancedephase = [1 -p];

% Kacc = norm(polyval(phi_denum,pole1)*polyval(den_avancedephase,pole1)/(polyval(phi_num,pole1)*polyval(num_avancedephase,pole1)) );
% Kacc = 1/norm((polyval(num_avancedephase,pole1)/polyval(den_avancedephase,pole1))*(polyval(phi_num,pole1)/polyval(phi_denum,pole1)));

Fct_avance_de_phase = tf(num_avancedephase,den_avancedephase);

[numint, denint] = tfdata(Fct_avance_de_phase^b,'v');
Kacc = c*norm(polyval(phi_denum,pole1)*polyval(denint,pole1)/(polyval(phi_num,pole1)*polyval(numint,pole1)) );

% CASCADE avec les compensateur 

fct_avph_phi = Fct_avance_de_phase^b*FCT_phi*Kacc;
% figure()
% plot(real(pole1),imag(pole1),'p')
% hold on
% plot(real(pole2),imag(pole2),'p')
% rlocus(fct_avph_phi)
[num_avph_phi,denum_avph_phi]=tfdata(fct_avph_phi,'v');

% Erreur régime permanent (rampe unitaire)
FTBF = feedback(fct_avph_phi,1);

% systeme original
% t_a = [0:0.01:5];
% u_a = t_a;
% y_avph_phi_BF = lsim(num_avph_phi_BF,denum_avph_phi_BF,u_a,t_a);
% figure(1)
% plot(t_a,(u_a)'-y_avph_phi_BF,'k')
% title('original')

% Réponse à l'échelon avec systeme original 
% [num_cascade_BF_original,den_cascade_BF_original] = feedback(num_avph_phi_BF,denum_avph_phi_BF,1,1);
% figure()
% t = linspace(0,2,100000)';
% u = ones(size(t));
% lsim(FTBF,u,t)
% y_avph_phi = lsim(FTBF,u,t);
% figure()
% plot(t,y_avph_phi)
% title('Réponse a lechelon systeme original');
% figure()
% margin(fct_avph_phi)
% figure()
% nyquist(fct_avph_phi)

%
% -----------------------------------------
% RETARD DE PHASE -------------------------
% -----------------------------------------

z = real(pole1)/e;

num_re = [1 -z];
denum_re = [1 0];
Kp = a*abs((polyval(num_re,pole1)*polyval(num_avph_phi,pole1))/(polyval(denum_re,pole1)*polyval(denum_avph_phi,pole1)));
G_re = tf(num_re,denum_re);

% CASCADE avec les compensateur 

fct_avph_phi_re = fct_avph_phi*Kp*G_re;
% figure()
% plot(real(pole1),imag(pole1),'p')
% hold on
% plot(real(pole2),imag(pole2),'p')
% rlocus(fct_avph_phi_re)
[num_avph_phi_re,denum_avph_phi_re]=tfdata(fct_avph_phi_re,'v');

% Erreur régime permanent (rampe unitaire)
FTBF_Re = feedback(fct_avph_phi_re,1);

%Réponse à l'échelon avec systeme original 
% [num_cascade_BF_original,den_cascade_BF_original] = feedback(num_avph_phi_BF,denum_avph_phi_BF,1,1);
% figure()
test = lsim(FTBF_Re,u,t);
% plot(t,test)
% hold on
% plot(t,1.05*u,':');
% plot(t,1.02*u,':');
% plot(t,0.98*u,':');
% axis([0 0.1 0.7 1.5])
wwwjjjw = wwwjjjw+1;
mp = max(test(6:end))-1;
position = find(test < 0.98 | test > 1.02,1, 'last');
if t(position)<Ts & mp<1
    
if mp<0.05
disp('------------------------------------------------------------------------------')    
disp(['mp = ', num2str(mp),' Pour module Ka = ',num2str(c),' et module Kr =',num2str(a)])
disp(['pour un ordre ', num2str(b), ' une modulation d''angle ',num2str(d),' et relge du pouce ' num2str(e)]) 
disp('------------------------------------------------------------------------------')
valeur = [mp,c,a,b,d,e];
else
    disp(['test no ', num2str(wwwjjjw),' Avec mp = ',num2str(mp),' et ts = ',num2str(t(position))])
    if mp<mpaa
        mpaa=mp
        valeurmin = [mp,c,a,b,d,e,f];
    end
    if t(position)<ts && mp<0.3
            mpaav = mp;
            ts = t(position);
            valeurmints = [mp,ts,c,a,b,d,e,f];
    end
end
end
%             end
%         end
%     end
% end

% y_avph_phi = lsim(FTBF,u,t);
% figure()
% plot(t,y_avph_phi)
% title('Réponse a lechelon systeme pi');
% figure()
% margin(fct_avph_phi_re)
% figure()
% nyquist(fct_avph_phi_re)
%%
plot(t,test)
hold on
plot(t,1.05*u,':');
plot(t,1.02*u,':');
plot(t,0.98*u,':');
axis([0 0.1 0.7 1.5])

figure()
plot(real(pole1),imag(pole1),'p')
hold on
plot(real(pole2),imag(pole2),'p')
rlocus(fct_avph_phi_re)