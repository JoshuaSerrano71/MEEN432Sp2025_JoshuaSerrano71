%% Initialization
Project4_init

%% Simulation
track = struct();
[track.x_track, track.y_track, track.x_target, track.y_target,track.xi_track, track.yi_track, track.xo_track, track.yo_track, track.s] = plottrack(track_length, track_radius, track_width);

set_param("MEEN432_Project4_Model_V2", "StopTime", "3600");
carsim = sim("MEEN432_Project4_Model_V2.slx");

% Initialize variables
laps_completed = 0;
lap_times = [];
start_time = 0;

%% Simulation loop
track_total_length = track.s(end); % Get total track length
cumulative_distance = 0;
laps_completed = 0;
lap_times = [];
start_time = 0;
previous_lap_count = 0;

for i = 2:length(carsim.X.Data)
    % Calculate incremental distance traveled
    dx = carsim.X.Data(i) - carsim.X.Data(i-1);
    dy = carsim.Y.Data(i) - carsim.Y.Data(i-1);
    delta_d = sqrt(dx^2 + dy^2);
    cumulative_distance = cumulative_distance + delta_d;
    
    % Calculate fractional lap progress
    current_fraction = cumulative_distance / track_total_length;
    
    % Update lap count when integer portion increases
    if floor(current_fraction) > previous_lap_count
        laps_completed = laps_completed + 1;
        lap_time = carsim.tout(i) - start_time;
        lap_times(end+1) = lap_time;
        start_time = carsim.tout(i);
        previous_lap_count = floor(current_fraction);
    end
end

% Display lap information
if carsim.End_Status.Data(end) == 0
    disp(['The car has completed all laps successfully.', newline, 'Run Information:']);
else
    disp(['The car has run out of charge. Ending simulation...', newline, 'Run Information:']);
end

disp(['Fractional Progress: ', num2str(current_fraction, '%.3f'), ' laps']);
disp(['Total Full laps Completed: ', num2str(laps_completed)]);
disp(['Average Lap Time: ', num2str(mean(lap_times)), ' seconds']);
disp(['Final Time: ', num2str(carsim.tout(end)), ' seconds']);

% Plot SOC
ft = figure();
ft.WindowState = 'maximized';
plot(carsim.SOC1)
xlabel('Time');
ylabel('SOC');
title('SOC vs Time');

% Plot track and car motion
ft = figure();
ft.WindowState = 'maximized';
hold on
plot(track.x_track, track.y_track, '--', Color=	"#D95319"); axis equal;
plot(track.xo_track, track.yo_track, 'k'); axis equal;
plot(track.xi_track, track.yi_track, 'k'); axis equal;

axis([-300, 1200, -100, 500]); %to see the track better
xlabel('X (meters)');
ylabel('Y (meters)');
title('Race Track');
grid on;
hold off;

Car_motion(carsim.X.Data, carsim.Y.Data)

%% Plot Track - > Making into a function for inner and outer bounds
function [x_track, y_track, x_target, y_target, xi_track, yi_track, xo_track, yo_track, s] = plottrack(track_length, track_radius, track_width)
    l_curve = pi*track_radius;
    total_l = (2*track_length) + (2*l_curve);
    
    s = linspace(0, total_l, 500);  
    
    % Initialize
    x_track = zeros(size(s));
    x_target = zeros(size(s));
    xo_track = zeros(size(s));
    xi_track = zeros(size(s));
    y_track = zeros(size(s));
    y_target = zeros(size(s));
    yo_track = zeros(size(s));
    yi_track = zeros(size(s));
    
    s1 = track_length;              % End of first straight
    s2 = track_length + l_curve;       % End of first curve
    s3 = 2*track_length + l_curve;     % End of second straight
    s4 = total_l;   % End of second curve (back to start)
    
    % Compute (x, y) based on s
    for i = 1:length(s)
        if s(i) <= s1
            % First straight
            x_track(i) = s(i);
            x_target(i) = s(i);
            xo_track(i) = s(i);
            xi_track(i) = s(i);
            y_track(i) = 0;
            y_target(i) = 0;
            yo_track(i) = -track_width/2;
            yi_track(i) = track_width/2;
        elseif s(i) <= s2
            % First curve
            theta = (s(i) - s1) / track_radius;  % Convert arc length to angle
            x_track(i) = track_length + track_radius * cos(theta - pi/2);
            x_target(i) = track_length + (track_radius + 2) * cos(theta - pi/2);
            xo_track(i) = track_length + (track_radius + (track_width/2)) * cos(theta - pi/2);
            xi_track(i) = track_length + (track_radius - (track_width/2)) * cos(theta - pi/2);
            y_track(i) = track_radius * sin(theta - pi/2) + track_radius;
            y_target(i) = (track_radius + 2)  * sin(theta - pi/2) + track_radius;
            yo_track(i) = (track_radius + (track_width/2))  * sin(theta - pi/2) + track_radius;
            yi_track(i) = (track_radius - (track_width/2)) * sin(theta - pi/2) + track_radius;
        elseif s(i) <= s3
            % Second straight
            x_track(i) = track_length - (s(i) - s2);
            x_target(i) = track_length - (s(i) - s2);
            xo_track(i) = track_length - (s(i) - s2);
            xi_track(i) = track_length - (s(i) - s2);
            y_track(i) = 2*track_radius;
            y_target(i) = 2*track_radius;
            yo_track(i) = 2*track_radius + track_width/2;
            yi_track(i) = 2*track_radius - track_width/2;
        else
            % Second curve
            theta = (s(i) - s3) / track_radius;  % Convert arc length to angle
            x_track(i) = track_radius * cos(theta + pi/2);
            x_target(i) = (track_radius + 2) * cos(theta + pi/2);
            xo_track(i) = (track_radius + (track_width/2)) * cos(theta + pi/2);
            xi_track(i) = (track_radius - (track_width/2)) * cos(theta + pi/2);
            y_track(i) = track_radius * sin(theta + pi/2) + track_radius;
            y_target(i) = (track_radius + 2) * sin(theta + pi/2) + track_radius;
            yo_track(i) = (track_radius + (track_width/2)) * sin(theta + pi/2) + track_radius;
            yi_track(i) = (track_radius - (track_width/2)) * sin(theta + pi/2) + track_radius;
        end
    end
end

%% Plot Car w/ motion
function Car_motion(X, Y)
    trail = animatedline('Color', 'blue', 'LineWidth', 1.5);
    
    car_x = [-3, 3, 3, -3];
    car_y = [-2, -2, 2, 2];
    
    car = patch(car_x, car_y, 'red');
    uistack(car, 'top')
    
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
        track_radius = [cos(angle) -sin(angle); sin(angle) cos(angle)];
        
        % Rotate car coordinates
        rotated_car = (track_radius * [car_x; car_y])';
        
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
