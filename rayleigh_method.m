% Input w and y as vectors (in proper order)

function critical_speed = rayleigh_method(w,y)
	g = 9.81; % m/s^2

	% Since the dot product is [a1 a2] * [b1 b2] = a1b1 + a2b2 
	% it is the same as summing each component
	sum_wy = dot(w,y)
	sum_wysquared = dot(w,y.^2) % .^2 will square each element

	critical_speed = sqrt(g * sum_wy / sum_wysquared)
end
