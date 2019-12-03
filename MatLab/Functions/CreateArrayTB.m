function [TRAJ_BE_tot] = CreateArrayTB(TRAJ_BE_al , TRAJ_BE_ret)
    % Back and forth points array concatenation
    % param: TRAJ_BE_al   - array of t,x,y,z for the trip to go
    % param: TRAJ_BE_ret  - array of t,x,y,z for the return trip
    % return: TRAJ_BE_tot - array of t,x,y,z for the whole trip  
    
    middle_t = TRAJ_BE_al(end,1) + TRAJ_BE_al(end,1)-TRAJ_BE_al(end-1,1);

    middle_x = TRAJ_BE_al(end,2);
    middle_y = TRAJ_BE_al(end,3);
    middle_z = TRAJ_BE_al(end,4);
    
    TRAJ_BE_mid = cat(1,TRAJ_BE_al,[middle_t , middle_x , middle_y , middle_z]);
    
    TRAJ_BE_ret(:,1) = TRAJ_BE_ret(:,1) + 1 + TRAJ_BE_mid(end,1); 
    
    TRAJ_BE_tot = cat(1 , TRAJ_BE_mid , TRAJ_BE_ret);
    
end

