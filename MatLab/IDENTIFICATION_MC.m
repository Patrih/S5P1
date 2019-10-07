clc
clear all
close all

load('ACT_Fe_attraction.mat');
load('ACT_Fs');

% Array to choose the displayed figures ; a one in the position displays
%Figure  1 2 3 4 5 6 7 8 9 
plots = [0 1 1 0 0 0 0 0 0];

%figures 1 : Original data
if plots(1)
    figure()
    plot (z_m1A , Fe_m1A)
    figure()
    plot (z_m2A , Fe_m2A)
    figure()
    plot (z_pos, Fs)
end
    
%Building the P matrix and the Y vector

P = [ones(size(z_pos)) z_pos z_pos.^2 z_pos.^3];
Y = -1./(Fs);
A = inv(P.'*P)*P.'*Y

%Evaluating the sim to verify
Fs_sim = -1./(A(1) + A(2).*z_pos + A(3).*z_pos.^2 + A(4).*z_pos.^3);

% TODO : Repair the sim ; it doesnt work

% Figure 2 : Original vs sim
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


