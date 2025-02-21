%MEEN Project 2 Initialization
clear
clc

%Track Info
R = 200;
Length = 900;

%Car Info
X0 = 0;
Y0 = 0;
vx0 = 0.1;
vy0 = 0;
omega0 = 0;
psi0 = 0;
psi = 0;
vd = 10;
vx_max = 0.1;
mass = 1000;
inertia = 1600;
lookahead_dist = 10; 

%Tire Info
lf = 1.5;
lr = 1.0;
Fyf_max = 40000*1/180*pi;
Fyr_max = 40000*1/180*pi;
C_alphaf = 40000;
C_alphar = 40000;
alpha_max = 8 * pi/180;
tire_radius = 0.3;


