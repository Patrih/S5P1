function [Pi , Ltr , E , Vr , Traj , tt , Traj_BE] = ComputeTrajectories(points_in , v_des , Ts , z , al_re)
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
    
    R = 0.0625;
    
    addpath('Functions');
    
    
    x = points_in(:,1);
    y = points_in(:,2);
    
    [Pi, L] = InterpolationLagrange(x', y');

    syms x_sym

    f_sym = poly2sym(Pi , x_sym);
    df_sym = diff(f_sym);
    ddf_sym = diff(df_sym);
    
    % Calcul de la longueur

    g_sym = sqrt(1 + df_sym^2);
    dg_sym = (ddf_sym*df_sym)/g_sym;

    m = 101;
    d_ech = (x(end) - x(1))/(m-1);
    ech_g = x(1) : d_ech : x(end);

    g_eval = subs(g_sym , ech_g);

    [L,err_trap] = Trapeze(g_eval, ech_g(2) - ech_g(1), 0);
    L1 = L';
    L = L1(end)';
    
    fp_b = eval(subs(dg_sym , x(end)));
    fp_a = eval(subs(dg_sym , x(1)));
    E_eval = (d_ech^2/12)*(fp_b - fp_a);
    E_trap = eval(err_trap);
    
    E = E_eval;
    
    L = L - E
    
    N_arc = abs(round(L/(v_des*Ts)));
    Vr = L/(N_arc*Ts);
    
    tt = N_arc*Ts;

    L_stp = L/N_arc;

    ite_max = 100;
    tol = 1e-08;
    
    Ltr = zeros(N_arc+1,1);
    
    x_sep = zeros(N_arc+1,1);
    x_sep(1) = x(1);
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
        
        if ite >= ite_max
            % Detects an error from NR and displays an error
            
            % The plot is for debug
            
            x_eval = x(1) : 0.0001 : x(end)+0.0001;
            y_eval = eval(subs(f_sym , x_eval));
            
            figure
            hold on
            plot(x , y , 'o')
            plot(x_eval , y_eval)
            axis equal
            hold off
            
            error('ComputeTrajectories (line 72) : Reached max iteration at arc No %d' , [i]);

        end
        
            ite_count(i) = ite;
            x_sep(i) = X_NR;

            clc
            fprintf('%d / %d \n', [i; N_arc+1]);

            Ltr (i,2) = Ltr (i-1)+L_stp;
    end
        

    
    Ltr(:,1) = 1:1:length(Ltr);
    
    y_sep = eval(subs(f_sym , x_sep));
    
    sign_crois = sign(x(2)-x(1));
    
    x_eval = x(1) : sign_crois*0.0001 : x(end);
    y_eval = eval(subs(f_sym , x_eval));
    
    Traj = [x_sep , y_sep];
    
    z_out = z.*ones(size(x_sep));
    t_out = (0 : Ts : tt)';
    
    Traj_BE = [t_out, x_sep , y_sep , z_out];
    
    th = 0:pi/50:2*pi;
    xunit = R * cos(th);
    yunit = R * sin(th);
    
%     figure(2)
%     hold on 
% 
%     if al_re == 0
%         plt(1) = plot(x,y,'x k')
%         plt(2) = plot(x_eval , y_eval,'r','DisplayName','Interpolation all�')
%         plt(3) = plot(xunit, yunit, 'k','DisplayName','Contour de la plaque')
%         legend(plt(2:3))
%     else
%         plt(1) = plot(x_eval , y_eval,'g','DisplayName','Interpolation retour')
%         plt(2) = plot(x,y,'x k','DisplayName','Points all�')
%         legend(plt(1:2))
%     end
%     
%     xlim ([1.1*-R , 1.1*R])
%     ylim ([1.1*-R , 1.1*R])
%     axis equal
%     hold off
%     
%     figure(3)
%     hold on 
%     
%     if al_re == 0
%         plot(x_sep , y_sep , 'o r')
%         plot(xunit, yunit , 'k')
%         plot(x,y,'x g')
%         plot(x_eval , y_eval,'k')
%     else
%         plot(x_sep , y_sep , 'o b')
%         legend('Interpolation', 'Contour de la plaque' , 'Points du prcours')
%         plot(xunit, yunit , 'k')
%         plot(x,y,'x g')
%         plot(x_eval , y_eval,'k')
%     end
%     xlim ([1.1*-R , 1.1*R])
%     ylim ([1.1*-R , 1.1*R])
%     axis equal
%     hold off

end

