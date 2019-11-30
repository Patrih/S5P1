clc;
clear all;
close all;
addpath('Data');
addpath('Functions');

% Fait par Louis Etienne & El Franscisco !
% Date: 2019-11-18
% Asservissement de Z
% À faire :
% Should be gucci 

% 1   Margin AV
% 2   Step response final
% 3   Margin final
% 4   Rlocus final
% 5   Discret final
% 6   
% 7   
% 8   
% 9   
%Figure  1 2 3 4 5 6 7 8 9
plots = [0 0 1 0 0 0 0 0 0];


%% Définitions & Loading

%Loading
load('equilibre');

%Definition
PMd = 25;
wgd = 185;
errech1d = -0.0004;
errech2d = 0;

%Cas
CasRe = 1;
CasPI = 2;
cas = CasRe;

%% Avance de phase
disp("-----------------------Avance de phase------------------------------")
% Avance de phase 1
[avPh1, ~] = AvancePhaseBode1(TF_z, PMd, wgd, 5);

% Avance de phase 2
[avPh2, ~] = AvancePhaseBode1(avPh1*TF_z, PMd, wgd, 10);

if plots(1)
    margin(avPh2*avPh1*TF_z);
end

%% Retard de phase
disp("-----------------------Retard de phase------------------------------")

% Retard de phase
if (cas == CasRe)
    rePh = RetardPhaseBode1(avPh2*avPh1*TF_z, errech1d, wgd, 10);
    compensateur_final = rePh*avPh2*avPh1;

%Proportionnel Derivee
elseif (cas == CasPI)
    PI = PIBode(wgd, 10);
    compensateur_final = PI*avPh2*avPh1;
end

FTBO_finale = compensateur_final* TF_z;
%% Compensateur discret
disp("----------------------Compensateur discret------------------------------")

if cas == CasPI
    % testdiscret(compensateur_final)

    %Creation du compensateur discret (Data provient de testdiscret.p)
    numDiscret = [1179170.3171991789714 -3242723.3458391698077 2968867.5232145143673 -904880.74232636578381];
    denDiscret = [1 -1.3220086973160070087 0.30974786569838153039 0.012260831617625414167];
    compensateursDiscret = tf(numDiscret,denDiscret);

    %Reajustement du pole > 1 a 0.99
    [zeroes, poles, gain] = tf2zp(compensateursDiscret.Numerator{:}, compensateursDiscret.Denominator{:});
    poles(1) = 1-1e-6;
    [num_comp, den_comp] = zp2tf(zeroes, poles, gain);

    compensateursDiscret = tf(num_comp, den_comp)

elseif cas == CasRe
    testdiscret(compensateur_final)
end



%% Informations
disp("-------------------------Informations-------------------------------")

% Domaine temporel
feed = feedback(FTBO_finale,1);
x = linspace (0,.25,10000)';
y = lsim(feed,ones(size(x)),x);

if plots(2)
    figure()
    plot(x,y);
    hold on
    plot(x,ones(size(x)));
end

disp('--- Step');
erp = ErrRP(FTBO_finale)
info = stepinfo(feed)

%Domaine frequentiel
disp('-- MARGIN');
bw = bandwidth(FTBO_finale)
allmargin(FTBO_finale)

if plots(3)
    margin(FTBO_finale)
end

%Rlocus
if plots(4)
    rlocus(FTBO_finale)
end

%Discret
if plots(5)
    testdiscret(compensateurs)
end 