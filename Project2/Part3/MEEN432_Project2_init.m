%MEEN Project 2 Initialization

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
car.alpha_max = 8 * pi/180;
tire_radius = 0.3;
%% Simulation
[x_track, y_track, xi_track, yi_track, xo_track, yo_track] = plottrack(Length, R, 15);
figure()
plot(x_track, y_track, '--r');
hold on
plot(xi_track, yi_track, 'k');
plot(xo_track, yo_track, 'k');
%plot(out.X.data,out.Y.data)

%% Plot Track - > Making into a function for inner and outer bounds
function [x_track, y_track, xi_track, yi_track, xo_track, yo_track] = plottrack(L, R, width)
    offset = width/2;
    Ri = R-offset;
    Ro = R+offset;
    
    x1 = linspace(0, L, 1000);
    x2 = linspace(L, 0, 1000);

    y1 = linspace(0, 0, 1000);
    y2 = linspace(400, 400, 1000);

    yi1 = linspace(offset, offset, 1000);
    yi2 = linspace(2*R - offset, 2*R - offset, 1000);

    yo1 = linspace(-offset, -offset, 1000);
    yo2 = linspace(400 + offset, 400 + offset, 1000);

    t1 = linspace( -pi/2, pi/2, 1000);
    t2 = linspace( pi/2, 3*pi/2, 1000);

    x_track = [x1 , R*cos(t1) + L , x2, R*cos(t2)];
    y_track = [y1, R*sin(t1) + R , y2 , R*sin(t2) + R];

    xi_track = [x1, Ri*cos(t1) + L, x2, Ri*cos(t2)];
    yi_track = [yi1, Ri*sin(t1) + R, yi2, Ri*sin(t2) + R];

    xo_track = [x1, Ro*cos(t1) + L, x2, Ro*cos(t2)];
    yo_track = [yo1, Ro*sin(t1) + R, yo2, Ro*sin(t2) + R];

end

