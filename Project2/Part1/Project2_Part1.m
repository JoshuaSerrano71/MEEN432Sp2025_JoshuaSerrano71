clc; clear; close all;

% Track characteristics
path.radius = 200;
path.straight = 900;
path.width = 15;

R = path.radius;
L = path.straight;
W = path.width;
l_curve = pi*R;

path.total_l = (2*L) + (2*l_curve);

loop.s = linspace(0, path.total_l, 500);  

% Initialize
path.x = zeros(size(loop.s));
path.x_outer = zeros(size(loop.s));
path.x_inner = zeros(size(loop.s));
path.y = zeros(size(loop.s));
path.y_outer = zeros(size(loop.s));
path.y_inner = zeros(size(loop.s));

loop.s1 = L;              % End of first straight
loop.s2 = L + l_curve;       % End of first curve
loop.s3 = 2*L + l_curve;     % End of second straight
loop.s4 = path.total_l;   % End of second curve (back to start)

% Compute (x, y) based on s
for i = 1:length(loop.s)
    if loop.s(i) <= loop.s1
        % First straight
        path.x(i) = loop.s(i);
        path.x_outer(i) = loop.s(i);
        path.x_inner(i) = loop.s(i);
        path.y(i) = 0;
        path.y_outer(i) = -W/2;
        path.y_inner(i) = W/2;
    elseif loop.s(i) <= loop.s2
        % First curve
        theta = (loop.s(i) - loop.s1) / R;  % Convert arc length to angle
        path.x(i) = L + R * cos(theta - pi/2);
        path.x_outer(i) = L + (R + (W/2)) * cos(theta - pi/2);
        path.x_inner(i) = L + (R - (W/2)) * cos(theta - pi/2);
        path.y(i) = R * sin(theta - pi/2) + R;
        path.y_outer(i) = (R + (W/2))  * sin(theta - pi/2) + R;
        path.y_inner(i) = (R - (W/2)) * sin(theta - pi/2) + R;
    elseif loop.s(i) <= loop.s3
        % Second straight
        path.x(i) = L - (loop.s(i) - loop.s2);
        path.x_outer(i) = L - (loop.s(i) - loop.s2);
        path.x_inner(i) = L - (loop.s(i) - loop.s2);
        path.y(i) = 2*R;
        path.y_outer(i) = 2*R + W/2;
        path.y_inner(i) = 2*R - W/2;
    else
        % Second curve
        theta = (loop.s(i) - loop.s3) / R;  % Convert arc length to angle
        path.x(i) = R * cos(theta + pi/2);
        path.x_outer(i) = (R + (W/2)) * cos(theta + pi/2);
        path.x_inner(i) = (R - (W/2)) * cos(theta + pi/2);
        path.y(i) = R * sin(theta + pi/2) + R;
        path.y_outer(i) = (R + (W/2)) * sin(theta + pi/2) + R;
        path.y_inner(i) = (R - (W/2)) * sin(theta + pi/2) + R;
    end
end

ft = figure();
ft.WindowState = 'maximized';
hold on
plot(path.x, path.y, '--', Color=	"#D95319"); axis equal;
plot(path.x_outer, path.y_outer, 'k'); axis equal;
plot(path.x_inner, path.y_inner, 'k'); axis equal;

axis([-300, 1200, -100, 500]); %to see the track better
xlabel('X (meters)');
ylabel('Y (meters)');
title('Race Track Layout');
grid on;
hold off;

l = 25;
w = 15;
trail = animatedline('Color', 'blue', 'LineWidth', 1.5);

car_x = [-l/2, l/2, l/2, -l/2];
car_y = [-w/2, -w/2, w/2, w/2];

car = patch(car_x, car_y, 'red');

for i = 1:length(loop.s)
    % Define the center of the car
    xc = path.x(i);
    yc = path.y(i);
    
    % Calculate the tangent vector for rotation
    if i < length(loop.s)
        dx = path.x(i+1) - xc;
        dy = path.y(i+1) - yc;
    else
        dx = xc - path.x(i-1);
        dy = yc - path.y(i-1);
    end
    
    % Calculate the rotation angle
    angle = atan2(dy, dx);
    
    % Create rotation matrix
    R = [cos(angle) -sin(angle); sin(angle) cos(angle)];
    
    % Rotate car coordinates
    rotated_car = (R * [car_x; car_y])';
    
    % Translate to current position
    X = rotated_car(:,1) + xc;
    Y = rotated_car(:,2) + yc;

    % Update car position and orientation
    set(car, 'XData', X, 'YData', Y);
    
    addpoints(trail, xc, yc);
    
    drawnow;
    pause(0.001);
end

hold off;
