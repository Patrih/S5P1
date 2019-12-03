function [FP_out] = ErreurFp( t_des , x_des , y_des , ynonlineaire , tsim)
    % Calculation of the Performance factor
    % param: t_des        - desired input time
    % param: x_des        - desired input x
    % param: y_des        - desired input y
    % param: ynonlineaire - output of the simulation
    % param: tsim         - time array of the simulation
    % return: FP_out      - the cumulative integration of f

    
    xm = ynonlineaire(: , 8);
    ym = ynonlineaire(: , 9);
    
    x_des_out = zeros(size(tsim));
    y_des_out = zeros(size(tsim));
    
    j = 1;
    
    for i = 1 : length(tsim)
        if t_des(j) ~= t_des(end)
            if tsim(i) >= t_des(j)
                j = j+1;
            end
        end
        
        x_des_out(i) = x_des(j,2);
        y_des_out(i) = y_des(j,2);

    end
    
    err = (x_des_out - xm).^2 + (y_des_out - ym).^2;
    
    err_mid = zeros(size(tsim));
    
    for i = 1 : length(tsim)-1
        err_mid(i) = (err(i+1)+err(i))*(tsim(i+1) - tsim(i))/2;
    end
    FP_out = sqrt(sum(err_mid));
end

