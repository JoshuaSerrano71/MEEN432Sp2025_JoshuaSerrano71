
%MEEN Project 2 Initialization

%Track Info
R = 200;
L = 900;
W = 15;

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
track = struct();
[track.x_track, track.y_track, track.xi_track, track.yi_track, track.xo_track, track.yo_track, track.s] = plottrack(L, R, W);

ft = figure();
ft.WindowState = 'maximized';
hold on
plot(track.x_track, track.y_track, '--', Color=	"#D95319"); axis equal;
plot(track.xo_track, track.yo_track, 'k'); axis equal;
plot(track.xi_track, track.yi_track, 'k'); axis equal;

axis([-300, 1200, -100, 500]); %to see the track better
xlabel('X (meters)');
ylabel('Y (meters)');
title('Race Track Layout');
grid on;
hold off;

set_param("MEEN432_Project2_Wk3", "StopTime", "300");
carsim = sim("MEEN432_Project2_Wk3.slx");
Car_motion(carsim.X.Data, carsim.Y.Data)

%% Plot Track - > Making into a function for inner and outer bounds
function [x_track, y_track, xi_track, yi_track, xo_track, yo_track, s] = plottrack(L, R, W)
    l_curve = pi*R;
    total_l = (2*L) + (2*l_curve);
    
    s = linspace(0, total_l, 500);  
    
    % Initialize
    x_track = zeros(size(s));
    xo_track = zeros(size(s));
    xi_track = zeros(size(s));
    y_track = zeros(size(s));
    yo_track = zeros(size(s));
    yi_track = zeros(size(s));
    
    s1 = L;              % End of first straight
    s2 = L + l_curve;       % End of first curve
    s3 = 2*L + l_curve;     % End of second straight
    s4 = total_l;   % End of second curve (back to start)
    
    % Compute (x, y) based on s
    for i = 1:length(s)
        if s(i) <= s1
            % First straight
            x_track(i) = s(i);
            xo_track(i) = s(i);
            xi_track(i) = s(i);
            y_track(i) = 0;
            yo_track(i) = -W/2;
            yi_track(i) = W/2;
        elseif s(i) <= s2
            % First curve
            theta = (s(i) - s1) / R;  % Convert arc length to angle
            x_track(i) = L + R * cos(theta - pi/2);
            xo_track(i) = L + (R + (W/2)) * cos(theta - pi/2);
            xi_track(i) = L + (R - (W/2)) * cos(theta - pi/2);
            y_track(i) = R * sin(theta - pi/2) + R;
            yo_track(i) = (R + (W/2))  * sin(theta - pi/2) + R;
            yi_track(i) = (R - (W/2)) * sin(theta - pi/2) + R;
        elseif s(i) <= s3
            % Second straight
            x_track(i) = L - (s(i) - s2);
            xo_track(i) = L - (s(i) - s2);
            xi_track(i) = L - (s(i) - s2);
            y_track(i) = 2*R;
            yo_track(i) = 2*R + W/2;
            yi_track(i) = 2*R - W/2;
        else
            % Second curve
            theta = (s(i) - s3) / R;  % Convert arc length to angle
            x_track(i) = R * cos(theta + pi/2);
            xo_track(i) = (R + (W/2)) * cos(theta + pi/2);
            xi_track(i) = (R - (W/2)) * cos(theta + pi/2);
            y_track(i) = R * sin(theta + pi/2) + R;
            yo_track(i) = (R + (W/2)) * sin(theta + pi/2) + R;
            yi_track(i) = (R - (W/2)) * sin(theta + pi/2) + R;
        end
    end
end

%% Plot Car w/ motion
function Car_motion(X, Y)
    trail = animatedline('Color', 'blue', 'LineWidth', 1.5);
    
    car_x = [-6, 6, 6, -6];
    car_y = [-4, -4, 4, 4];
    
    car = patch(car_x, car_y, 'red');
    
    for i = 1:length(X)
        % Define the center of the car
        xc = X(i);
        yc = Y(i);
        
        % Calculate the tangent vector for rotation
        if i < length(X)
            dx = X(i+1) - xc;
            dy = Y(i+1) - yc;
        else
            dx = xc - X(i-1);
            dy = yc - Y(i-1);
        end
        
        % Calculate the rotation angle
        angle = atan2(dy, dx);
        
        % Create rotation matrix
        R = [cos(angle) -sin(angle); sin(angle) cos(angle)];
        
        % Rotate car coordinates
        rotated_car = (R * [car_x; car_y])';
        
        % Translate to current position
        Xt = rotated_car(:,1) + xc;
        Yt = rotated_car(:,2) + yc;
    
        % Update car position and orientation
        set(car, 'XData', Xt, 'YData', Yt);
        
        addpoints(trail, xc, yc);
        
        drawnow;
        pause(0.000001);
    end
    
    hold off;
end
