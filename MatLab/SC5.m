clc 
clear variables
close all
addpath('Data')
addpath('Functions')

%Fait par : Francois
%Date : 2019-11-11
%Reste a faire: 
% - Nada
% - 
% - 

%% Data

load('Data/capteur.mat');

% 1     Original Data
% 2     Y = mx + b
% 3     Y = a + Bx^2
% 4     Y = a cos(x)
% 5     Y = ae^(bx)+c
% 6
% 7
% 8
% 9
%Figure  1 2 3 4 5 6 7 8 9
plots = [0 0 1 1 1 0 0 0];



xn = distance(1:end-1);
yn = voltage(1:end-1);
x = (min(xn):1e-6:max(xn));


%% Original data
if plots(1)
    figure()
    title('Data')
    plot(distance,voltage)
end
%% Y = mx + b
if plots(2)
    disp('---------------Y = mx + b---------------------')
    [b,m,E,R2,RMS] = MoindreCarreeLineaire(xn,yn);

    f = x*m+b;

    figure()
    hold on
    plot(xn,yn,'-O')
    plot(x,f)
    legend('Data','Sim')
    hold off
    
    disp(['Erreur : ' num2str(E,4)])
    disp(['R2 : ' num2str(R2,4)])
    disp(['RMS : ' num2str(RMS,4)])
end

%% Y = a + Bx^2
if plots(3)
    disp('---------------Y = a + Bx^2---------------------')
    [b,m,E,R2,RMS] = MoindreCarreeLineaire(xn.^2,yn);

    beta = b;
    alpha = -m;
    
    f = -alpha.*x.^2+beta;

    figure()
    hold on
    title("Y = a + Bx^2")
    plot(xn,yn,'-O')
    plot(x,f)
    legend('Data', 'Sim')
    hold off
    
    clear f m b alpha beta
    
    disp(['Erreur : ' num2str(E,4)])
    disp(['R2 : ' num2str(R2,4)])
    disp(['RMS : ' num2str(RMS,4)])
end

%% Y = a cos(x)
if plots(4)
    disp('---------------Y = a cos(x)---------------------')
    [b,m,E,R2,RMS] = MoindreCarreeLineaire(cos(xn),yn);

    alpha = m;
    beta = b;
    
    f = alpha*cos(xn)+beta;

    figure()
    hold on
    title("Y = a cos(x)")
    plot(xn,yn,'-O')
    plot(xn,f)
    legend('Data', 'Sim')
    hold off
    
    clear f m b alpha beta
    
    disp(['Erreur : ' num2str(E,4)])
    disp(['R2 : ' num2str(R2,4)])
    disp(['RMS : ' num2str(RMS,4)])
end

%% Y = a exp(b*x)
if plots(5)
    disp("---------------Y = ae^(bx)+c---------------------")
    ynlog = log(-yn+max(yn));
    [b,m,E,R2,RMS] = MoindreCarreeLineaire(xn(1:end-1),ynlog(1:end-1));

    alpha = -exp(b);
    beta = m;

    f = alpha.*exp(beta.*x)+max(yn);

    figure()
    hold on
    title("Y = ae^b^x+c")
    plot(xn,yn,'-O')
    plot(x,f)
    legend('Data', 'Sim')
    hold off

    clear f m b alpha beta
    disp(['Erreur : ' num2str(E,4)])
    disp(['R2 : ' num2str(R2,4)])
    disp(['RMS : ' num2str(RMS,4)])
end


