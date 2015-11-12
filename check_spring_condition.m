% Find the force required to perform maintence on the shaft.
% Params: The location of the two bearings
%	B - Location of the bearing close to the pulley relative to point E
%	C - Location of the bearing close to the coupling relative to E
%	Fk1 - force at the first bearing due to the spring
%	Fk2 - force at the second bearing due to the spring
% Returns: Force Required to Lift the pulley ten centimeters for 
function force_required = check_spring_condition(B,C,Fk1,Fk2)
	% Given
	shaft_length = 40; % cm
	angle_factor = 0.025; % sin(theta)=10mm/40cm, unitless
	k = 37.8; % N/mm, spring factor

	% Guide
	% 1 - Bearing close to the pulley
	% 2 - Bearing close to the coupling

	% Find initial deflections (both in compression)
	yi1 = abs(Fk1 / k); % mm
	yi2 = abs(Fk2 / k); % mm

	% Locations of Bearings relative to the coupling ()
	x1 = (shaft_length - B); % cm, Distance from B to D
	x2 = (shaft_length - C); % cm, Distance from C to D

	% Deflection on spring due to moving the shaft upwards 10mm
	y1 = x1 * angle_factor * 10; % mm, in compression
	y2 = x2 * angle_factor * 10; % mm, in tension

	% Finding the actual deflections
	y1 = y1 + yi1;
	y2 = y2 - yi2;

	force_required = k*(y2 + y1);
end
	