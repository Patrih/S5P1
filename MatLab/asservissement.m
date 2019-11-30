clc;
clear all;
close all;

% Fait par Francois Gauthier
% Date: 2019-11-30
% Asservissement de Z
% À faire :
% Should be gucci 

% !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% Warning, everything is hardcoded in this script, please act accordingly
% !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

%%
disp('Warning, everything is hardcoded in this script, please act accordingly')

%Asservissement en Z
z.pi.num =    1.0e+06 *[1.179170317199179  -3.242723345839170   2.968867523214514  -0.904880742326366];
z.pi.den =    [1.000000000000000  -1.322007697316007   0.309747543689684   0.012260819356794];

z.re.num = [1179050.4692867584527 -3242393.7635745150037 2968565.7749685486779 -904788.77251812396571];
z.re.den = [1 -1.321805422334144442 0.30968240938627561443 0.012258339297300559212];

%Asservissement en Phi
phi.num =   1.0e+04 *[1.141141634965296 -3.585884974935766 4.191095186120298 -2.162151280256048 0.415840763803559];
phi.den =   [1.000000000000000 -0.961508031692077 -0.037997078269861 -0.000491738961660 -0.000002112089471];

save('Data/asservissement')