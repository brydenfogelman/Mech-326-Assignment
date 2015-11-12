%% Setup

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
vector_conv = L/n_step;

%% Singularity Functions

% Function to find the singularity functions as vectors
Fr = 500; %N
[T,V,M,M_over_I] = find_sf(Fr,A,B,C,x);

% Optional: Plot singularity functions
% plot_sf(T,V,M,M_over_I,x)

%% Critcal Points and Fatigue

% Note:
% finish 2 - for machined / CD
% function fatigueLife(Sut, Smax, Smin, TauMid, finish, diam, Kf, Kfs)

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
fatigueLife(Sut, Srev, -Srev, TauMid, 2, d1, Kf, Kfs)

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
fatigueLife(Sut, Srev, -Srev, TauMid, 2, d1, Kf, Kfs)

% 3) Max Bending Moment

% Finding Moment and Critical Point
max_moment = max(M);
critical_location = x((find(M==max(M))));

% Finding Stresses
Srev = 32*max_moment/(pi*d1^3) / 10^6; % MPa, fully reversible

% Calculating Safety Factors
fatigueLife(Sut, Srev, -Srev, TauMid, 2, d1, 1, 1) 
% Assuming no stress concentrations on the shaft where there are no components

% 4) Retaining Ring at Bearing G
loc3 = C + bearing_width*100/2;
moment3 = M(floor(loc3/err));

% Finding Stress Concentration Factors
r = 0.1; % mm
Kt = 4; Kts = 2.5; % From Table A15-15
Kf = fatigue_stress_concentration(Kt,r,Sut,1);
Kfs = fatigue_stress_concentration(Kts,r,Sut,0);

% Finding Stresses
Srev = 32*moment3/(pi*d1^3) / 10^6; % MPa, fully reversible

% Calculating Safety Factors
fatigueLife(Sut, Srev, -Srev, TauMid, 2, d1, Kf, Kfs)

% 5) Shoulder at Bearing G
loc4 = C - bearing_width*100/2;
moment4 = M(floor(loc4/err));

% Finding Stress Concentration Factors
r = 0.75; % mm
Kt = 2.5; Kts = 1.8; % From Table A15-8 and A15-9
Kf = fatigue_stress_concentration(Kt,r,Sut,1);
Kfs = fatigue_stress_concentration(Kts,r,Sut,0);

% Finding Stresses
Srev = 32*moment4/(pi*d1^3) / 10^6; % MPa, fully reversible

% Calculating Safety Factors
fatigueLife(Sut, Srev, -Srev, TauMid, 2, d1, Kf, Kfs)

%%%%%%%%%%%%%%%%%%%
% CRITICAL SPEEDS %
%%%%%%%%%%%%%%%%%%%

% density = 7.85*100^3/1000; % kg/m^3
% volume1 = (pi * (d1)^2/4)*(B/100+bearing_width/2);
% volume2 = (pi * (d2)^2/4)*((C-B)/100 - bearing_width);
% volume3 = (pi * (d1)^2/4)*((L-C)/100+bearing_width/2); % m^3
% V = [volume1 volume2 volume3];
% wieght = V .* density .* g;
% total_weight = sum(wieght);





