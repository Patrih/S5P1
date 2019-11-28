function [a, b] = Fp(f, h)
    a = (f(2) - f(1)) / h;
    b = (f(end) - f(end-1)) / h;
end