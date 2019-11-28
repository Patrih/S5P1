function [PI, Kp] = PIBode(wgd, marge)
% Retourne le compensateur PI pour la fonction de transfert FTBO
% param: FTBO  - la fonction de transfert à compenser
% param: erpd  - l'erreur désirée
% param: wgd   - la fréquence de traverse en gain désiré
% param: marge - la marge choisie (phase itérative)
% return: PI   - la fonction de transfert du compensateur PI avec son
%                gain

z = -wgd/marge;
Kp = 1;

PI = Kp * tf([1 -z], [1 0]);
end