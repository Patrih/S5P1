function [PI, Kp] = PIBode(wgd, marge)
% Retourne le compensateur PI pour la fonction de transfert FTBO
% param: FTBO  - la fonction de transfert � compenser
% param: erpd  - l'erreur d�sir�e
% param: wgd   - la fr�quence de traverse en gain d�sir�
% param: marge - la marge choisie (phase it�rative)
% return: PI   - la fonction de transfert du compensateur PI avec son
%                gain

z = -wgd/marge;
Kp = 1;

PI = Kp * tf([1 -z], [1 0]);
end