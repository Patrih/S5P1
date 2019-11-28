function [b,m,E,R2,RMS] = MoindreCarreeLineaire(xn,yn)
%MOINDRECARREELINEAIRE Summary of this function goes here
%   Detailed explanation goes here
N = length(xn);

MatriceA = inv([N sum(xn); sum(xn) sum(xn.^2)]);
MatriceB = [sum(yn); sum(yn.*xn)];

Result = MatriceA*MatriceB;
b = Result(1);
m = Result(2);

h = b + m*xn;

% calcul des erreurs
% E
E = sum((h-yn).^2);
% R2
R2 = sum((h-mean(yn)).^2)/sum((yn-mean(yn)).^2);
% RMS
RMS =sqrt(1/numel(xn)*sum((h-yn).^2));

end

