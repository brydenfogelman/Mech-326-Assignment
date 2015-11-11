% Define location of A,B,C in cm
A = 3; B = 9.5; C = 39;
L = 40; % shaft length

% Given
k = 37.8 * 1000; % N/m

% Review this later
% Location of B
% F_applied = 800; % N, force that can be applied to change the belt
% lift_height = 10; % mm
% % Finding the compression in both springs due to maintence
% comp_spring2 = (L-C)*lift_height/L % mm
% % Fk2 = k * comp_spring2 / 1000 % N
% % B = C * Fk2 / (-Fk2 + F_applied) + (A + 1) % cm

% Fk2 = F_applied - k * comp_spring2 / 1000 % N
% comp_spring1 = ( Fk2 / k ) * 1000 % mm
% B = L*(1 - comp_spring1/lift_height) % cm



% Function to find spring forces
% [Fk1, Fk2] =  spring_forces(A,B,C);

% Function to find the singularity functions as vectors
[V,M] = find_sf(A,B,C);

% Max bending moment and Critical Location
max_bending_moment = max(M)
critical_location = (find(M==max_bending_moment) * 40/1000) % 40/1000 is derived from the definition of x

% Optional: Plot singularity functions
plot_sf(V,M)