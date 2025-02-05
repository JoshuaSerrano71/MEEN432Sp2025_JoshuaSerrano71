clc; clear; close all;

% Track Parameters
R = 200;       % Radius of curved sections (meters)
L = 900;       % Length of straight sections (meters)
W = 15;        % Width of the track (meters)

total_length = 2*L + 2*pi*R;

s = linspace(0, total_length, 500);  

% Initialize
x = zeros(size(s));
y = zeros(size(s));

s1 = L;              % End of first straight
s2 = L + pi*R;       % End of first curve
s3 = 2*L + pi*R;     % End of second straight
s4 = total_length;   % End of second curve (back to start)

% Compute (x, y) based on s
for i = 1:length(s)
    if s(i) <= s1
        % First straight
        x(i) = s(i);
        y(i) = 0;
    elseif s(i) <= s2
        % First curve
        theta = (s(i) - s1) / R;  % Convert arc length to angle
        x(i) = L + R * cos(theta - pi/2);
        y(i) = R * sin(theta - pi/2) + R;
    elseif s(i) <= s3
        % Second straight
        x(i) = L - (s(i) - s2);
        y(i) = 2*R;
    else
        % Second curve
        theta = (s(i) - s3) / R;  % Convert arc length to angle
        x(i) = R * cos(theta + pi/2);
        y(i) = R * sin(theta + pi/2) + R;
    end
end

figure;
plot(x, y, 'k-', 'LineWidth', W); %matches the width of the track given
hold on;

axis([-300, 1200, -300, 700]); %to see the track better
xlabel('X (meters)');
ylabel('Y (meters)');
title('Race Track Layout');
grid on;
hold off;

l = 25;
w = 15;
trail = animatedline('Color', 'blue', 'LineWidth', 2);


for i = 1:length(s)
    % Define the center of the car; already defined earlier
    xc = x(i);
    yc = y(i);

    car_x = [-l/2, l/2, l/2, -l/2];
    car_y = [-w/2, -w/2, w/2, w/2];
    
    X = [xc + l/2, xc + l/2, xc - l/2, xc - l/2];
    Y = [yc - w/2, yc + w/2, yc + w/2, yc - w/2];

    addpoints(trail, xc, yc);

    % Draw the patch
    car = patch(X, Y, 'red');
    pause(0.001);

    if i < 500
        delete(car);
    end

end

