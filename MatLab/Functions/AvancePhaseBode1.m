function [avPh, Ka] = AvancePhaseBode1(FTBO, PMd, wgd, marge)
% Retourne le compensateur avance de phase pour la fonction de transfert
% FTBO
% param: FTBO  - la fonction de transfert à compenser
% param: PMd   - la marge de phase désirée
% param: wgd   - la fréquence de traverse en gain désiré
% param: marge - la marge choisie (phase itérative)
% return: avPh - la fonction de transfert du compensateur avPh avec son
%                gain


Kd = 1 / abs(evalfr(FTBO, 1i*wgd));
[~, PM] = margin(Kd*FTBO);

if PM >= PMd
    disp('No need for a FT, just a gain')
    Ka = Kd;
    avPh = tf(1, 1);
else 
    dPhi = PMd + marge - PM;
    
    alpha = (1-sind(dPhi))/(1+sind(dPhi));
    T = 1 / (wgd * sqrt(alpha));

    % Calcul du z et p
    z = -1/T;
    p = -1/(alpha*T);

    Ka = Kd/sqrt(alpha);
    avPh = Ka * tf([1 -z], [1 -p]); 
end
end

