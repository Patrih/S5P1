clc 
clear variables
close all
addpath('Data')
addpath('Functions')

%Fait par : Francois
%Date : 2019-11-11
%Reste a faire: 
% - PLein
% - 
% - 

%% Data

load('Data/capteur.mat');

% 1
% 2
% 3
% 4
% 5
% 6
% 7
% 8
% 9
%Figure  1 2 3 4 5 6 7 8 9
plots = [0 0 1 0 1 0 0 0 0];



xn = distance(1:end-1);
yn = voltage(1:end-1);
x = flip((min(xn):1e-6:max(xn)));


%% Original data
if plots(1)
    figure()
    title('Data')
    plot(distance,voltage)
end
%% Y = mx + b
if plots(2)
    disp('---------------Y = mx + b---------------------')
    [b,m] = MoindreCarreeLineaire(xn,yn);

    f = x*m+b;

    figure()
    hold on
    plot(xn,yn,'-O')
    plot(x,f)
    legend('Data','Sim')
    hold off
end

%% Y = ae^(Bx)
if plots(3)
    disp('---------------Y = ae^(Bx)---------------------')
    [b,m] = MoindreCarreeLineaire(xn,log(yn));
    alpha = exp(b)
    beta = m
    clear result
    f = alpha.*exp(beta.*x);
    % E = erreurQuad(f,xn,yn,1e-3)

    figure()
    hold on
    plot(xn,yn,'-O')
    plot(x,f)
    legend('Data', 'Sim')
    hold off
end
%% Y = a + B/x
if plots(4)
    disp('---------------Y = a + B/x---------------------')
    [b,m] = MoindreCarreeLineaire(1./xn,yn);

    alpha = b
    beta = m

    f = alpha + beta./x;

    figure()
    hold on
    plot(xn,yn,'-O')
    plot(x,f)
    legend('Data', 'Sim')
    hold off
end

%% Y = ae^bx
if plots(5)
    disp('---------------Y = ae^(Bx)---------------------')
    [b,m] = MoindreCarreeLineaire(xn,log(yn));
    
    alpha = -exp(b)
    beta = m
    
    f = alpha.*exp(beta.*x);

    figure()
    hold on
    plot(xn,yn,'-O')
    plot(x,f)
    legend('Data', 'Sim')
    hold off
end
