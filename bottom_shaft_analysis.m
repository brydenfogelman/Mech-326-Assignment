%%%%%%%%%%%%%%
% PARAMETERS %
%%%%%%%%%%%%%%

% Define location of A,B,C in cm
A = 7; B = 11; C = 38;

% Given
k = 37.8 * 1000; % N/m
L = 40; % shaft length
d1 = 20/1000; % m
d2 = 30/1000; % m
bearing_width = 14/1000; % m
g = 9.81; 

% Creating position vector
n_step = 1000;
x = linspace(0,L,n_step);

%%%%%%%%%%%%%%%%%%%%%%%%%
% SINGULARITY FUNCTIONS %
%%%%%%%%%%%%%%%%%%%%%%%%%

% Function to find the singularity functions as vectors
Fr = 500; %N
[V,M,M_over_I] = find_sf(Fr,A,B,C,x);

% Optional: Plot singularity functions
plot_sf(V,M,M_over_I,x)

%%%%%%%%%%%%%%%%%%%
% CRITICAL POINTS %
%%%%%%%%%%%%%%%%%%%

% Max bending moment and Critical Location
max_bending_moment = max(M)
critical_location = x((find(M==max_bending_moment))); % 40/1000 is derived from the definition of x

%%%%%%%%%%%
% FATIGUE %
%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%
% CRITICAL SPEEDS %
%%%%%%%%%%%%%%%%%%%

density = 7.85*100^3/1000; % kg/m^3
volume = (pi * (d1)^2/4)*(B/100+bearing_width/2) + (pi * (d2)^2/4)*((C-B)/100 - bearing_width) + (pi * (d1)^2/4)*((L-C)/100+bearing_width/2); % m^3
weight = density*volume*g





