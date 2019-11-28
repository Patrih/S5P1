function [b,m] = MoindreCarreeLineaire(xn,yn)
%MOINDRECARREELINEAIRE Summary of this function goes here
%   Detailed explanation goes here
N = length(xn);

MatriceA = inv([N sum(xn); sum(xn) sum(xn.^2)]);
MatriceB = [sum(yn); sum(yn.*xn)];

Result = MatriceA*MatriceB;
b = Result(1)
m = Result(2)

end

