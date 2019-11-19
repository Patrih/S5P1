function [rePh, Kr] = RetardPhaseBode1(FTBO, erpd, wgd, marge)
% Retourne le compensateur retard de phase pour la fonction de transfert
% FTBO
% param: FTBO  - la fonction de transfert � compenser
% param: erpd  - l'erreur d�sir�e
% param: wgd   - la fr�quence de traverse en gain d�sir�
% param: marge - la marge choisie (phase it�rative)
% return: rePh - la fonction de transfert du compensateur rePh avec son
%                gain

class = GetClass(FTBO);

Kveld = 1/erpd;
Kvel = FTBO.Numerator{:}(end)/FTBO.Denominator{:}(end-class);
Kd = Kveld/Kvel;

att = abs(wgd*evalfr(FTBO, 1i*wgd));

if att == 1
    beta = Kd;
else
    beta = abs(Kd*evalfr(FTBO, 1i*wgd));
end

T = marge/wgd;

z = -1/T;
p = -1/(beta*T);
Kr = Kd/beta;

rePh = Kr * tf([1 -z],[1 -p]);
end

