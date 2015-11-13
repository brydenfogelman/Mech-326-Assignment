%% Bottom Shaft Analysis
% This script will analyze the shaft EFGJ and calculates/displays the following,
%
% * Shear, Torque and Moment Diagrams
% * Critical Points and Stresses
% * Fatigue Safety Factors (Gerber, Goodman and First Cycle Yield)
% * Cost and mass for Performance Metric
%
% Several helper functions are called to help calculate these values. The functions used are listed below (see section in Appendix for more detail):
%
% * find_sf, calculates the singularity functions and represents them as vectors
% * plot_sf, plots the singularity functions
% * fatigue_stress_concentration, calculates Kf and Kfs based on Kt, Kts and uses the Neuber equation and constant in the evaulation
% * fatigueLife, calculates the Gerber, Goodman and first cycle yield safety factors

%% Setup
% Defining the location of the bearings and assigning variables to values given. 

% Define location of A,B,C in cm
% Found based on maintence condition
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
vector_conv = L/n_step;

%% Singularity Functions

% Finding the reactions due to the radial force of the pulley
Fr = 500; % N
[T,V,M,M_over_I] = find_sf(Fr,A,B,C,x); % Function to find the singularity functions as vectors

display('Force Required to perform maintence on the shaft (Requirement < 800 N).')
% Optional: Plot singularity functions
plot_sf(T,V,M,M_over_I,x)

%% Critcal Points and Fatigue
% The critical points were found to be at,
%
% # Retaining Ring at Bearing F
% # Shoulder at Bearing F
% # Max Moment
% # Retaining Ring at Bearing G
% # Shoulder at Bearing G
% # Gib key at pulley
%
% The moments at each critical location were take from the M vector. Bending stress is considered to be fully reversible.
%The torque along the shaft creates a mid range shear stress. All Kt and Kts values were found from tables in Shigleys.

% Setup
Sut = 690; % MPa

% Torque calcs, this applies to all critical points
n = 1000; % rpm
w = 1000 * pi/30; % rad/s
H = 1000; % W
Tmid = H/w; % Nm
TauMid = 16*Tmid/(pi*d1^3) / 10^6; % MPa, mid range only

% Critical Points

% 1) Retaining Ring at Bearing F

% Finding Moment at Critical Point
loc1 = B - bearing_width*100/2;
moment1 = M(floor(loc1/err));

% Finding Stress Concentration Factors
r = 0.1; % mm
Kt = 4; Kts = 2.5; % From Table A15-15
Kf = fatigue_stress_concentration(Kt,r,Sut,1);
Kfs = fatigue_stress_concentration(Kts,r,Sut,0);

% Finding Stresses
Srev = 32*moment1/(pi*d1^3) / 10^6; % MPa, fully reversible

% Calculating Safety Factors
display('Retaining Ring at Bearing F')
fatigueLife(Sut, Srev, -Srev, TauMid, 2, d1*1000, Kf, Kfs)

% 2) Shoulder at Bearing F

% Finding Moment at Critical Point
loc2 = B + bearing_width*100/2;
moment2 = M(floor(loc2/err));

% Finding Stress Concentration Factors
r = 0.75; % mm
Kt = 2.5; Kts = 1.8; % From Table A15-8 and A15-9
Kf = fatigue_stress_concentration(Kt,r,Sut,1);
Kfs = fatigue_stress_concentration(Kts,r,Sut,0);

% Finding Stresses
Srev = 32*moment2/(pi*d1^3) / 10^6; % MPa, fully reversible

% Calculating Safety Factors
display('Shoulder at Bearing F')
fatigueLife(Sut, Srev, -Srev, TauMid, 2, d1*1000, Kf, Kfs)

% 3) Max Bending Moment

% Finding Moment and Critical Point
max_moment = max(M);
critical_location = x((find(M==max(M))));

% Finding Stresses
Srev = 32*max_moment/(pi*d1^3) / 10^6; % MPa, fully reversible

% Calculating Safety Factors
display('Max Bending Moment')
fatigueLife(Sut, Srev, -Srev, TauMid, 2, d1*1000, 1, 1) 
% Assuming no stress concentrations on the shaft where there are no components

% 4) Retaining Ring at Bearing G
loc4 = C + bearing_width*100/2;
moment4 = M(floor(loc4/err));

% Finding Stress Concentration Factors
r = 0.1; % mm
Kt = 4; Kts = 2.5; % From Table A15-15
Kf = fatigue_stress_concentration(Kt,r,Sut,1);
Kfs = fatigue_stress_concentration(Kts,r,Sut,0);

% Finding Stresses
Srev = 32*moment4/(pi*d1^3) / 10^6; % MPa, fully reversible

% Calculating Safety Factors
display('Retaining Ring at Bearing G')
fatigueLife(Sut, Srev, -Srev, TauMid, 2, d1*1000, Kf, Kfs)

% 5) Shoulder at Bearing G
loc5 = C - bearing_width*100/2;
moment5 = M(floor(loc5/err));

% Finding Stress Concentration Factors
r = 0.75; % mm
Kt = 2.5; Kts = 1.8; % From Table A15-8 and A15-9
Kf = fatigue_stress_concentration(Kt,r,Sut,1);
Kfs = fatigue_stress_concentration(Kts,r,Sut,0);

% Finding Stresses
Srev = 32*moment5/(pi*d1^3) / 10^6; % MPa, fully reversible

% Calculating Safety Factors
display('Shoulder at Bearing F')
fatigueLife(Sut, Srev, -Srev, TauMid, 2, d1*1000, Kf, Kfs)

% 6) Gib Key at Pulley
% Srev = 0;
% % Assuming q=0 so Kf=Kt
% Kt = 2.14;
% Kts = 3;

% display('Gib Key at Pulley')
% fatigueLife(Sut, 0, 0, TauMid, 2, d1*1000, Kt, Kts)

%% Extra Calculations



density = 7.85*100^3/1000; % kg/m^3
volume1 = (pi * (d1)^2/4)*(B/100+bearing_width/2);
volume2 = (pi * (d2)^2/4)*((C-B)/100 - bearing_width);
volume3 = (pi * (d1)^2/4)*((L-C)/100+bearing_width/2); % m^3
V = [volume1 volume2 volume3];
mass = V .* density;

raw_material = (pi * d2^2/4*L/100)*density
machined_mass = ((pi * (d2)^2/4 - pi * (d1)^2/4)*(B/100+bearing_width/2) + (pi * (d2)^2/4 - pi * (d1)^2/4)*((L-C)/100+bearing_width/2))*density

total_mass = raw_material - machined_mass

cost_raw = 13 * raw_material
cost_machine = 50 * machined_mass
cost_raw+cost_machine

metric = ( (cost_raw+cost_machine+240)*total_mass )^-1






