% Function that Plots Singularity Functions
function plot_sf = plot_sf(V,M,M_over_I,x)
	% Setting up
	L = 40; % cm, shaft length
	% x = linspace(0,L,1000);

	% Shear Diagram
	figure(1)
	plot(x,V)
	axis([0 L min(V)-50 max(V)+50]) % for making the plots more appealing
	title('Shear Diagram')
	ylabel('Shear Force (N)')
	xlabel('Position on shaft (cm)')


	% Moment Diagram
	figure(2)
	plot(x,M,'r')
	axis([0 L -2 max(M)+2])
	title('Moment Diagram')
	ylabel('Moment (N*m)')
	xlabel('Position on shaft (cm)')

	% M over I diagram
	figure(3)
	plot(x,M_over_I,'c')
	title('Moment over I Diagram')
	ylabel('M/I (N/m^3)')
	xlabel('Position on shaft (cm)')
end