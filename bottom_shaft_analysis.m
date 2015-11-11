% Define location of A,B,C in cm
A = 3; B = 9.5; C = 39;
L = 40; % shaft length

n_step = 1000;
x = linspace(0,L,n_step);

% Given
k = 37.8 * 1000; % N/m

% Function to find spring forces
% [Fk1, Fk2] =  spring_forces(A,B,C);

% Function to find the singularity functions as vectors
[V,M,M_over_I] = find_sf(A,B,C);

% Max bending moment and Critical Location
max_bending_moment = max(M)
critical_location = x((find(M==max_bending_moment))) % 40/1000 is derived from the definition of x

% Optional: Plot singularity functions
plot_sf(V,M,M_over_I)