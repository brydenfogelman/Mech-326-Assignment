% Finds the reaction forces at the springs
% Location of A,B,C in cm
function [Fk1, Fk2] = spring_forces(F,A,B,C)
	% Given
	L = 40; % cm, shaft length

	x1 = (L - C); % Distance from C to D
	x2 = (L - B); % Distance from B to D
	x3 = (L - A); % Distance from A to D

	% Row 1 - Sum of moments about the end of the shaft
	A = [x2 -x1 F*x3; 1 -1 F];
	X = rref(A);
	Fk1 = -X(1,3)
	Fk2 = X(2,3)

	% Force Required to lift the shaft for maintence
	force_required = check_spring_condition(B,C,Fk1,Fk2)
end