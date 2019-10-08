%-----------------------------------------------------
% Titre : mise_equation
% Date de création : 07-10-2019
% Auteur : Louis Etienne
%-----------------------------------------------------

%% Definitions
run('MAIN.m');

syms ae0 ae1 ae2 ae3
syms as0 as1 as2 as3
syms phi theta z
syms FsA FsB FsC
syms Z
syms Ka Kb Kc
syms Fa Fb Fc


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


%%

syms XS YS FS FP
FB = FA*((XC*YA-XA*YC)/(XB*YC+XB))+FS*((XC*YS-XS*YC)/(XB*YC+XB));
FC = -FA*((XC*YA-XA*YC)/(XB*YC+XB)*YB/YC+YA/YC)-FS*((XC*YS-XS*YC)/(XB*YC+XB)*YB/YC+YS/YC);


FAe = solve(FA == -FS-FP-FB-FC , FA);
FBe = FAe*((XC*YA-XA*YC)/(XB*YC+XB))+FS*((XC*YS-XS*YC)/(XB*YC+XB));
FCe = -FAe*((XC*YA-XA*YC)/(XB*YC+XB)*YB/YC+YA/YC)-FS*((XC*YS-XS*YC)/(XB*YC+XB)*YB/YC+YS/YC);









