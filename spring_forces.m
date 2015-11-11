% Location of A,B,C in cm
function [Fk1, Fk2] = spring_forces(A,B,C)
	% Given
	shaft_length = 40; % cm
	Fr = 500;

	x1 = (shaft_length - C); % Distance from C to D
	x2 = (shaft_length - B); % Distance from B to D
	x3 = (shaft_length - A); % Distance from A to D
	% Row 1 - Sum of moments about the end of the shaft
	A = [x2 -x1 Fr*x3; 1 -1 Fr];
	X = rref(A);
	Fk1 = -X(1,3);
	Fk2 = X(2,3);

	% Force Required to lift the shaft for maintence
	force_required = check_spring_condition(A,B,C, Fk1, Fk2)

end