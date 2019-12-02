clc ;
clear all;
close all;
addpath('Data')

%Fait par : LD/Louis
%Date : 2019-11-11

%% Force magnétique

load('Data/ACT_Fe_attraction.mat');
load('Data/ACT_Fs');
% 1     Fs data
% 2     Fs vs sim
% 3     Error of Fs vs sim
% 4     Fe vs Moindres carrés m1A
% 5     Error of Fe vs Moindres carrés m1A
% 6     Fe vs Moindres carrés m2A
% 7     Error of Fe vs Moindres carrés m2A
% 8     Comparaison m1A m2A
% 9
%Figure  1 2 3 4 5 6 7 8 9
plots = [0 0 0 0 0 0 0 0 0];
disp("--------------------------Original Data--------------------------------")
%figures 1 : Original data
if plots(1)
    figure()
    plot (z_m1A , Fe_m1A)
    figure()
    plot (z_m2A , Fe_m2A)
    figure()
    plot (z_pos, Fs)
end
   
%% Approximating Fs
disp("-------------------------Aproximating Fs-------------------------------")
% Building the P matrix and the Y vector
nbr_value = 110;

z_pos_red = z_pos(1:nbr_value+1);
Fs_red = Fs(1:nbr_value+1);

P = [ones(size(z_pos_red)) z_pos_red z_pos_red.^2 z_pos_red.^3];
Y = -1./(Fs_red);
As = pinv(P)*Y;

Fs_approx = -1./(As(4).*z_pos.^3 + As(3).*z_pos.^2 + As(2).*z_pos + As(1));

if plots(2)
    figure()
    hold on
    plot (z_pos, Fs)
    plot(z_pos,Fs_approx)
    title('Comparaison Fs_sim')
    legend('original','Moindre carre')
    hold off
end

% Figure 2 : Original vs sim error
if plots(3)
    figure()
    plot (z_pos, Fs_approx - Fs)
    title('Erreur sur Fe du moindre carré')
    ylabel('Erreur (N)')
    xlabel('Courant (A)')
end

%% Approximating Fe
disp("-------------------------Aproximating Fe-------------------------------")

% Using m1A
iK = -1;
Be = 13.029359254409743;
numerator_1 = (iK^2 + Be*abs(iK)) * sign(iK);

P = [ones(size(z_m1A)) z_m1A z_m1A.^2 z_m1A.^3];
Y = numerator_1 ./ Fe_m1A;
Ae1 = pinv(P) * Y;

% Using m2A
iK = -2;
numerator_2 = (iK^2 + Be*abs(iK)) * sign(iK);

P = [ones(size(z_m2A)) z_m2A z_m2A.^2 z_m2A.^3];
Y = numerator_2 ./ Fe_m2A;
Ae2 = pinv(P) * Y;

Fe_m1A_approx = numerator_1 ./ (Ae1(1) + Ae1(2)*z_m1A + Ae1(3)*z_m1A.^2 + Ae1(4)*z_m1A.^3);
Fe_m2A_approx = numerator_2 ./ (Ae2(1) + Ae2(2)*z_m2A + Ae2(3)*z_m2A.^2 + Ae2(4)*z_m2A.^3);

if plots(4)
    figure
    plot(z_m1A, Fe_m1A); hold on;
    plot(z_m1A, Fe_m1A_approx);
    legend("Originale", "Moindres carrés");
end

if plots(5)
    figure
    plot(z_m1A, Fe_m1A_approx - Fe_m1A);
    title("Erreur comparaison Fe_m1A_sim");
end

if plots(6)
    figure
    plot(z_m2A, Fe_m2A); hold on;
    plot(z_m2A, Fe_m2A_approx);
    legend("Originale", "Moindres carrés");
end

if plots(7)
    figure
    plot(z_m2A, Fe_m2A_approx - Fe_m2A);
    title("Erreur comparaison Fe_m2A_sim");
end

Ae = (Ae1 + Ae2)./2;
Fe_m1A_sim_avg = numerator_1 ./ (Ae(1) + Ae(2)*z_m1A + Ae(3)*z_m1A.^2 + Ae(4)*z_m1A.^3);
Fe_m2A_sim_avg = numerator_2 ./ (Ae(1) + Ae(2)*z_m2A + Ae(3)*z_m2A.^2 + Ae(4)*z_m2A.^3);

if plots(8)
    figure
    hold on
    plot(z_m1A, Fe_m1A_sim_avg - Fe_m1A);
    plot(z_m2A, Fe_m2A_sim_avg - Fe_m2A);
    title('Erreur sur Fs du moindre carré')
    ylabel('Erreur (N)')
    xlabel('Courant (A)')
    legend('Erreur à -1A' , 'Erreur à -2A')
    hold off
end

%% Errors
disp("------------------------------Error------------------------------------")

[r2_Fe1,rmse_Fe1] = rsquare(Fe_m1A,Fe_m1A_sim_avg);
[r2_Fe2,rmse_Fe2] = rsquare(Fe_m2A,Fe_m2A_sim_avg);
[r2_Fs,rmse_Fs] = rsquare(Fs,Fs_approx);

%% Save
disp("------------------------------Save-------------------------------------")
save('Data/Identification_MC','Be', 'Ae', 'As');
disp("----------------------End IDENTIFICATION_MC----------------------------")
