clc 
clear variables
close all
addpath('Data')
addpath('Functions')

%Fait par : Francois
%Date : 2019-11-11
%Reste a faire: 
% - e^x
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
plots = [1 1 1 1 0 1 0 0];



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
    [b,m] = MoindreCarreeLineaire(xn,yn);

    f = x*m+b;

    figure()
    hold on
    plot(xn,yn,'-O')
    plot(x,f)
    legend('Data','Sim')
    hold off
end

%% Y = a + Bx^2
if plots(3)
    disp('---------------Y = a + Bx^2---------------------')
    [b,m] = MoindreCarreeLineaire(xn.^2,yn);

    beta = b
    alpha = -m
    
    f = -alpha.*x.^2+beta;

    figure()
    hold on
    title("Y = a + Bx^2")
    plot(xn,yn,'-O')
    plot(x,f)
    legend('Data', 'Sim')
    hold off
    
    clear f m b alpha beta
end

%% Y = a cos(x)
if plots(4)
    disp('---------------Y = a cos(x)---------------------')
    [b,m] = MoindreCarreeLineaire(cos(xn),yn);
    
    alpha = m
    beta = b
    
    f = alpha*cos(xn)+b;

    figure()
    hold on
    title("Y = a cos(x)")
    plot(xn,yn,'-O')
    plot(xn,f)
    legend('Data', 'Sim')
    hold off
    
    clear f m b alpha beta
end

%%
P = [ones(size(xn)) log(xn) xn];
Y =log(yn);
tamp = pinv(P)*Y

a = tamp(3);
b = tamp(2);
c = tamp(1);

clear tamp

f = a.*exp(b.*x) + c;

    figure()
    hold on
    title("Y = a e^B^x + c")
%     plot(xn,yn,'-O')
    plot(x,f)
%     legend('Data', 'Sim')
    hold off

%%
f = fittype('a*exp(b*x)+c'); 
[fit1,gof,fitinfo] = fit(xdata,ydata,f,'StartPoint',[1 1]);

