%% Function Description: fatigue_stress_concentration
%
% Finds Kfs and Kf using the Neuber Equation.
%
% Parameters:
% 
% * Kt (or Kts) - theoretical stress concentration factor
% * r - fillet radius in mm
% * Sut - ultimate tensile strength of the material in MPa
% * bending - 0 for torsion (Kfs), 1 for bending (Kf)
%
% Returns - the fatigue stress concentration factor (in bending or in shear) 

%%% Code

function K = fatigue_stress_concentration(Kt,r,Sut,bending)
	Sut = Sut * 145.038/1000; % kpsi
	% r, notch radius
	if(bending == 1) 
		% Bending case
		sqrt_a = (0.246 - 3.08*(10^-3)*Sut + 1.51*(10^-5)*Sut^2 - 2.67*(10^-8)*Sut^3) * sqrt(25.4); % sqrt(mm)
	else
		% Torsion case
		sqrt_a = (0.190 - 2.51*(10^-3)*Sut + 1.35*(10^-5)*Sut^2 - 2.67*(10^-8)*Sut^3) * sqrt(25.4);
	end

	K = 1 + (Kt - 1) / (1 + sqrt_a/sqrt(r));
end