function [V,M,M_over_I] = find_sf(A,B,C)

	% Find Spring Forces, with A.b and C in cm
	[Fk1, Fk2] = spring_forces(A,B,C);

	% Given
	Fr = 500; % N
	shaft_length = 40/100; % m
	A = A/100; B = B/100; C = C/100; % Converting from cm to m

	bearing_width = 14/1000; % m

	d1 = 20; % mm
	d2 = 30; % mm

	% Creating position vector
	x = linspace(0,shaft_length,1000);

	% Creating signularity functions for shear
	y1 = sf_step(x,A); y2 = sf_step(x,B); y3 = sf_step(x,C);

	% Creating singularity functions for moment
	y4 = sf_slope(x,A); y5 = sf_slope(x,B); y6 = sf_slope(x,C);

	% Creating a singularity function for mass moment of interia
	% y7 = sf_step(x,0); y8 = sf_step(x,B+bearing_width/2); y9 = sf_step(x,C-bearing_width/2);
	y7 = sf_step(x,B+bearing_width/2); % step for first shoulder
	

	I1 = pi * (d1/1000)^4/64
	I2 = pi * (d2/1000)^4/64

	% Complete Singularity 
	V = Fr*y1 + Fk1*y2 + Fk2*y3;
	M = Fr*y4 + Fk1*y5 + Fk2*y6;
	I = 0;
	% I = I1*y7 + (I2)*y8 + (I1)*y9;
	% step = max(M)/I2;
	slope1 = max(M)/(I1 * (B-A));
	slope2 = slope1 + max(M)/(I2 * (C-B));
	slope3 = slope2 - slope1;
	step = max(M)/I1 - max(M)/I2;
	M_over_I = ( slope1*y4 - slope2 *y5 - step*y7 + slope3*y6 );

end

% Helper Functions
function y = sf_step(x,a)
	y = (x>a);
end

function y = sf_slope(x,a)
	y =(x-a).*(x > a);
end
