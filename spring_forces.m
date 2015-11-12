%% Function: spring_forces
% Finds the reaction forces at bearing F and G due to the springs.
%
% Parameters:
%
% * F - Force Applied to the shaft
% * A - location of the pulley
% * B - location of Bearing F
% * C - location of Bearing G
%
% Returns:
%
% * Fk1 - spring (reaction) force at Bearing F
% * Fk2 - spring (reaction) force at Bearing F
%
% Equations are derived from sum of forces in the veritcal direction and from a sum of moments about the point J (coulpling/end of shaft)
%The equations are Fk1 - Fk2 = F and Fk1 * x1 - Fk2 * x2 = F * x3.
%The check_spring_condition function is used to determine if the workers are able to perform maintence on the shaft. 

%%% Code

function [Fk1, Fk2] = spring_forces(F,A,B,C)
	% Given
	L = 40; % cm, shaft length

	x1 = (L - C); % Distance from C to D
	x2 = (L - B); % Distance from B to D
	x3 = (L - A); % Distance from A to D

	% Row 1 - Sum of moments about the end of the shaft
	A = [x2 -x1 F*x3; 1 -1 F];
	X = rref(A);
	Fk1 = -X(1,3);
	Fk2 = X(2,3);

	% Force Required to lift the shaft for maintence
	force_required = check_spring_condition(B,C,Fk1,Fk2)
end