function [F, err] = Trapeze(f, h, initial)
    % Trapzeoidal integration
    % param: f       - the function
    % param: h       - the step of x
    % param: initial - the initial conditions
    % return: F      - the cumulative integration of f
    % return: err    - the method error
    
    F = zeros(length(f), 1);
    F(1) = initial;
    
    for i = 2:length(f)
        F(i) = (h/2) * (f(1) + f(i) + 2*sum(f(2:i-1))) + initial;
    end
%     
%     [fpa, fpb] = Fp(f, h);
%     err = (h^2/12) * (fpb-fpa);
end