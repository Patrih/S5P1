%-----------------------------------------------------
% Titre : mise_equation
% Date de création : 07-10-2019
% Auteur : Philippe
%-----------------------------------------------------

%% Definitions
run('MAIN.m');

syms ae0 ae1 ae2 ae3
syms as0 as1 as2 as3
syms phi theta z ze
syms FsA FsB FsC
syms Z
syms Ka Kb Kc
syms Fk Fe iep ien bE1
syms XK YK

%% 
Tabc = [ YA  YB  YC;
        -XA -XB -XC;
          1   1   1; ];

Z = (Tabc') * ([phi theta z].');

ZA = Z(1);
ZB = Z(2);
ZC = Z(3);


FsA = -1/(as0+as1*ZA+as2*ZA^2+as3*ZA^3);
FsB = -1/(as0+as1*ZB+as2*ZB^2+as3*ZB^3);
FsC = -1/(as0+as1*ZC+as2*ZC^2+as3*ZC^3);

FeA = Ka/(ae0+ae1*ZA+ae2*ZA^2+ae3*ZA^3);
FeB = Kb/(ae0+ae1*ZB+ae2*ZB^2+ae3*ZB^3);
FeC = Kc/(ae0+ae1*ZC+ae2*ZC^2+ae3*ZC^3);



isolate(FsA,theta)

%% Identification de i
% pour i < 0
solve(Fe == (ien^2 - bE1*ien)*(-1) / (ae0 + ae1*z + ae2*z^2 + ae3*z^3), ien)

% pour i > 0
solve(Fe == (iep^2 + bE1*iep) / (ae0 + ae1*z + ae2*z^2 + ae3*z^3), iep)


%% SS1-2
% pour i < 0
solve(Fe == (ien^2 - bE1*ien)*(-1) / (ae0 + ae1*(ze-XK*theta+YK*phi) + ae2*(ze-XK*theta+YK*phi)^2 + ae3*(ze-XK*theta+YK*phi)^3), ien)

% pour i > 0
solve(Fe == (iep^2 + bE1*iep) / (ae0 + ae1*(ze-XK*theta+YK*phi) + ae2*(ze-XK*theta+YK*phi)^2 + ae3*(ze-XK*theta+YK*phi)^3), iep)