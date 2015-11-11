function plot_sf = plot_sf(V,M,M_over_I)
	% Setting up
	shaft_length = 40;
	x = linspace(0,shaft_length,1000);

	% Shear Diagram
	figure(1)
	plot(x,V)
	axis([0 shaft_length min(V)-50 max(V)+50]) % for making the plots more appealing
	title('Shear Diagram')
	ylabel('Shear Force (N)')
	xlabel('Position on shaft (cm)')


	% Moment Diagram
	figure(2)
	plot(x,M,'r')
	axis([0 shaft_length -2 max(M)+2])
	title('Moment Diagram')
	ylabel('Moment (N*m)')
	xlabel('Position on shaft (cm)')

	% M over I diagram
	figure(4)
	plot(x,M_over_I,'c')
	title('Moment over I Diagram')
	ylabel('M/I (N/m^3)')
	xlabel('Position on shaft (cm)')
end