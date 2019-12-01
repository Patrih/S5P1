function [Pi , Ltr , E , Vr , Traj , tt , Traj_BE] = compute_trajectories(points_in , v_des , Ts)
    % This function do a Lagrange interpolation.
    % param: points_in - (N,2) vector containing the desired points
    % param: v_des     - The desired speed
    % param: Ts        - The period between each point
    % return: Pi       - Matrix of polynomial coefficients
    % return: Ltr      -(M,2) matrix containing the length points
    % return: E        - Error
    % return: Vr       - Actual speed
    % return: Traj     - Matrix of the trajectory
    % return: tt       - Total time
    % return: Traj_BE  - TODO

    % Interpolation de la trajectoire
    
    addpath('Functions');
    
    x = points_in(:,1);
    y = points_in(:,2);
    
    [Pi, L] = InterpolationLagrange(x', y');

    syms x_sym

    f_sym = poly2sym(Pi , x_sym);
    df_sym = diff(f_sym);

    % Calcul de la longueur

    g_sym = sqrt(1 + df_sym^2);

    m = 101;
    d_ech = (x(end) - x(1))/(m-1);
    ech_g = x(1) : d_ech : x(end);

    g_eval = subs(g_sym , ech_g);

    L = Trapeze(g_eval, ech_g(2) - ech_g(1), 0)';
    L = L(end);
    
    % TODO ERROR
    E = 0;
    
    
    N_arc = round(L/(v_des*Ts));
    Vr = L/(N_arc*Ts);
    
    tt = N_arc*Ts;

    L_stp = L/N_arc;

    ite_max = 100;
    tol = 1e-08;
    
    Ltr = zeros(N_arc+1,1);
    
    x_sep = zeros(N_arc+1,1);
    ite_count   = zeros(N_arc+1,1);
    
    
    
    for i = 2:N_arc+1
        ite = 0;
        X_NR_strt = x_sep(i - 1);
        X_NR = x_sep(i - 1);

        F_NR = eval(vpaintegral(g_sym,x_sym,[X_NR_strt , X_NR])- L_stp);
        dF_NR = eval(subs(g_sym , X_NR));

        while ite < ite_max && abs(F_NR) >= tol

            X_NR = X_NR - (F_NR)/(dF_NR);

            F_NR = eval(vpaintegral(g_sym,x_sym,[X_NR_strt , X_NR])- L_stp);
            dF_NR = eval(subs(g_sym , X_NR));

            ite = ite + 1;
        end
        ite_count(i) = ite;
        x_sep(i) = X_NR;
        
        Ltr (i,2) = Ltr (i-1)+L_stp;
        
    end
    Ltr(:,1) = 0:1:length(Ltr);
    
    y_sep = eval(subs(f_sym , x_sep));
    
    x_eval = x_sep(1) : 0.01 : x_sep(end);
    y_eval = eval(subs(f_sym , x_eval));
    
    Traj = [x_sep , y_sep]

    %TODO WHEN WE KNOW THE FORMAT
    Traj_BE = 0;
    
%     figure
%     hold on 
%     plot(x_sep , y_sep , 'o')
%     plot(x_eval , y_eval)
%     xlim ([0 10])
%     ylim ([0 10])
%     hold off

end

