function [C, L] = InterpolationLagrange(X, Y)
% This function do a Lagrange interpolation.
% param: pointx - Vector of x of the points we want to interpolate
% param: pointy - Vector of y of the points we want to interpolate
% return: C     - Matrix of polynomial coefficients
% return: L     - Matrix of Lagrange coefficients

w = length(X);
n = w - 1;
L = zeros(w, w);

for k=1:n+1
    S = 1;
    for j=1:n+1
        if k ~= j
            S = conv(S, poly(X(j)))/(X(k) - X(j));
        end
    end
    L(k, :) = S;
end

C = Y * L;
end