%% Function: fatigueLife
%
% This script calculates the infinite lift safety factor of a rotating 
%cylindrical shaft Usig the Modified Goodman Failure Criteria. 
%
%All units are in MPA.
%
% Sut is the ultimate tensile strength, Smax is the Maximum bending stress,
% Smin is the minimum bending stress. NO Axial Stress. TauMax is the shear
% stress due to torque from the motor. 
%
%Kf and Kfs are fatigue stress concentrations for bending and shear.
%
% Finish should be 1 (ground), 2 (machined or CD), 3 (Hot-Rolled),
% 4 (As-Forged).  

%%% Code

function fatigueLife(Sut, Smax, Smin, TauMid, finish, diam, Kf, Kfs) 

Sy = 580; % MPa

% Initialize Parameters
a = 0;
b = 0;
Se = 0;
Ka = 0;
Kb = 0;

%Midrange and Alternating Stresses

Smid = (Smax+Smin)/2;
Salt = abs(Smax-Smin)/2;

%Von Mises Alternating and Midrange stress 
SaVM = Kf*Salt;
SmidVM = sqrt( (Kf*Smid)^2 + 3*(TauMid*Kfs)^2);

%Switch case takes material finish code and sets parameters for Surface
%Finish. 
switch finish
    case 1
        a = 1.58;
        b = -0.085;
    case 2
        a = 4.51;
        b = -.265;
    case 3 
        a = 57.7;
        b = -.718;
    case 4
        a = 272;
        b = -.995;
    otherwise 
        'Invalid material finish.';
end 

% Ka is the Surface Factor
Ka = a*Sut^b;

% Kb is the Size Factor
 if( 2.79<= diam <=51)
        Kb = 1.24*diam^-0.107;
 elseif( 51< diam <254)
        Kb = 1.51*diam^-0.157;  
 end 


if (Sut > 1400)  
    Se = 700*Ka*Kb;
else
    Se = 0.5*Sut*Ka*Kb;
end

nYield = Sy / (SaVM + SmidVM)

nGoodman = ( (SaVM / Se) + (SmidVM/Sut) ) ^ (-1)

nGerber = 0.5*((Sut/SmidVM)^2)*(SaVM/Se)*(-1 + sqrt(1+( (2*SmidVM*Se) / (Sut*SaVM))^2));

end