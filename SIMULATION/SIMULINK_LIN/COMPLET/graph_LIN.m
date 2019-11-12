%---------------------------------
%Fait par : LD
%Date : 2019-11-11
%Reste a faire: 
% - Rien
% - 
% - 
%---------------------------------


close all
clc

%             |            00            |             10             |       20        |      
%figure        1  2  3  4  5  6  7  8  9  0  1  2  3  4  5  6  7  8  9  0  1  2  3  4  5
%name          Ax Ay Pz Wx Wy Vz Px Py Vx Vy IA IB IC Za Zb Zc Zd Ze Zf FA FB FC VA VB VC
%figure_25  = [ 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1 ];

%             |        00       |         10        |    20     |      
%figure        1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5
figure_25  = [ 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ];

for i = 1 : 25
    if figure_25(i) == 1
        figure(i);
        plot(tsim , ynonlineaire(: , i));
    end
end

