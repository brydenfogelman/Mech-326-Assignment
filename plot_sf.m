%% Function: plot_sf
%
% Plots the Shear, Moment, Torque and M/I diagrams.
% Parameters - singularity functions for T,V,M and M/I; x is the position vector

%%% Code

function plot_sf = plot_sf(T,V,M,M_over_I,x)
	% Setting up
	L = 40; % cm, shaft length

	% Shear Diagram
	figure(1)
	subplot(2,2,1)
	plot(x,V)
	axis([0 L min(V)-50 max(V)+50]) % for making the plots more appealing
	title('Shear Diagram')
	ylabel('Shear (N)')
	xlabel('Position on shaft (cm)')

	% Torque
	subplot(2,2,2)
	plot(x,T, 'g')
	axis([0 L -1 max(T)+1])
	title('Torque Diagram')
	ylabel('Torque (N*m)')
	xlabel('Position on shaft (cm)')

	% Moment Diagram
	subplot(2,2,[3,4])
	plot(x,M,'r')
	axis([0 L -2 max(M)+2])
	title('Moment Diagram')
	ylabel('Moment (N*m)')
	xlabel('Position on shaft (cm)')

	% M over I diagram
	figure(2)
	plot(x,M_over_I,'c')
	title('Moment over I Diagram')
	ylabel('M/I (N/m^3)')
	xlabel('Position on shaft (cm)')
end