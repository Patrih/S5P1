function [a, b] = Fp(f, h)
%Dérivée au point inital (a) et final (b)
    a = (f(2) - f(1)) / h;
    b = (f(end) - f(end-1)) / h;
end