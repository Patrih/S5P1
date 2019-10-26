%% Force magnétique

clc
clear all
close all

load('ACT_Fe_attraction.mat');
load('ACT_Fs');
% Array to choose the dissplayed figures ; a one in the position displays
%Figure  1 2 3 4 5 6 7 8 9 
plots = [0 0 0 0 0 0 0 0 0];

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
% Building the P matrix and the Y vector
% Here we try to find the best value for the offset by iteration
tolerance = 1e-10;
maxiter = 1e4;
alpha = 0.0001; % step size
i = 0;
offset = 7; % After tests, the best offset is after 7 and before 8
last_error = 1000;

while i < maxiter
    P = [ones(size(z_pos)) z_pos z_pos.^2 z_pos.^3];
    Y = -1./(Fs - offset);
    As = pinv(P)*Y;

    %Evaluating the sim to verify
    Fs_sim = offset - 1./(As(1) + As(2).*z_pos + As(3).*z_pos.^2 + As(4).*z_pos.^3);
    
    % Compute error
    error = sqrt(mean((Fs_sim - Fs).^2));
    
    if last_error - error <= tolerance
        break
    end
    
    last_error = error;
    offset = offset + alpha;
    i = i + 1;
end

% Clear useless variables
clear alpha error last_error maxiter i tolerance

%% Figure 2 : Original vs sim for Fs
if plots(2)
    figure()
    hold on
    plot (z_pos, Fs)
    plot(z_pos,Fs_sim)
    title('Comparaison Fs_sim')
    legend('original','Moindre carre')
    hold off
end

% Figure 2 : Original vs sim error
if plots(3)
    figure()
    plot (z_pos, Fs_sim - Fs)
    title('Erreur Comparaison Fs_sim')
end

%% Approximating Fe
% Using m1A
iK = -1;
bE1 = 13.029359254409743;
numerator = (iK^2 + bE1*abs(iK)) * sign(iK);

P = [ones(size(z_m1A)) z_m1A z_m1A.^2 z_m1A.^3];
Y = numerator ./ Fe_m1A;
Ae = pinv(P) * Y;

Fe_m1A_sim = numerator ./ (Ae(1) + Ae(2)*z_m1A + Ae(3)*z_m1A.^2 + Ae(4)*z_m1A.^3);

if plots(4)
    figure
    plot(z_m1A, Fe_m1A); hold on;
    plot(z_m1A, Fe_m1A_sim);
    legend("Originale", "Moindres carrés");
end

if plots(5)
    figure
    plot(z_m1A, Fe_m1A_sim - Fe_m1A);
    title("Erreur comparaison Fe_m1A_sim");
end

% Using m2A
iK = -2;
numerator = (iK^2 + bE1*abs(iK)) * sign(iK);

P = [ones(size(z_m2A)) z_m2A z_m2A.^2 z_m2A.^3];
Y = numerator ./ Fe_m2A;
Ae2 = pinv(P) * Y;

Fe_m2A_sim = numerator ./ (Ae2(1) + Ae2(2)*z_m2A + Ae2(3)*z_m2A.^2 + Ae2(4)*z_m2A.^3);

if plots(6)
    figure
    plot(z_m2A, Fe_m2A); hold on;
    plot(z_m2A, Fe_m2A_sim);
    legend("Originale", "Moindres carrés");
end

if plots(7)
    figure
    plot(z_m2A, Fe_m2A_sim - Fe_m2A);
    title("Erreur comparaison Fe_m2A_sim");
end

%% Errors
rms_Fs = rms(Fs_sim - Fs);
r2_Fs = (Fs_sim' - mean(Fs)) / (Fs' - mean(Fs));

rms_Fe_m1A = rms(Fe_m1A_sim - Fe_m1A);
r2_Fe_m1A = (Fe_m1A_sim' - mean(Fe_m1A)) / (Fe_m1A' - mean(Fe_m1A));

rms_Fe_m2A = rms(Fe_m2A_sim - Fe_m2A);
r2_Fe_m2A = (Fe_m2A_sim' - mean(Fe_m2A)) / (Fe_m2A' - mean(Fe_m2A));

%% Calculate force

z = 30e-3;

F = -1./(As(1) + As(2).*z + As(3).*z.^2 + As(4).*z.^3);


% % di = 0.0001;
% % x = linspace(0.0001,0.03,2000);
% % for z = 0.0001:di:0.03
% % F(round(z/di)) = -1/(A(1)+A(2)*z^1+A(3)*z^2+A(4)*z^3);
% % F1 = ((452+8.2)*10^-3)*9.81;
% % Fres(round(z/di)) = F1+F(round(z/di));
% % Ares(round(z/di)) = Fres(round(z/di))/((452+8.2)*10^-3);
% % end
% % figure()
% % plot(x,F)