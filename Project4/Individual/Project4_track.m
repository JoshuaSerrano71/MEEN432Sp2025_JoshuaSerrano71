%% Initialization
Project4_init

%% Simulation
track = struct();
[track.x_track, track.y_track, track.x_target, track.y_target, track.xi_track, track.yi_track, track.xo_track, track.yo_track, track.s, track.z_track] = plottrack(track_length, track_radius, track_width);

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

% Calculate corresponding z positions for the car's path
car_z = zeros(size(carsim.X.Data));
for i = 1:length(carsim.X.Data)
    % Determine which segment the car is on and calculate height
    if carsim.X.Data(i) >= 0 && carsim.X.Data(i) <= track_length && carsim.Y.Data(i) <= track_width/2
        % First straight - increasing height
        car_z(i) = exp((carsim.X.Data(i)-450)/50) / (1 + exp((carsim.X.Data(i)-450)/50)) * 10;
    elseif carsim.X.Data(i) >= 0 && carsim.X.Data(i) <= track_length && carsim.Y.Data(i) >= 2*track_radius - track_width/2
        % Second straight - decreasing height
        car_z(i) = exp((carsim.X.Data(i)-450)/50) / (1 + exp((carsim.X.Data(i)-450)/50)) * 10;
    else
        % Curves - constant height
        if carsim.Y.Data(i) > track_width/2 && carsim.Y.Data(i) < 2*track_radius - track_width/2
            % First curve - high elevation
            car_z(i) = 10;
        else
            % Second curve - low elevation
            car_z(i) = 0;
        end
    end
end

for i = 2:length(carsim.X.Data)
    % Calculate incremental distance traveled (ignore z for now since the model doesn't account for elevation)
    dx = carsim.X.Data(i) - carsim.X.Data(i-1);
    dy = carsim.Y.Data(i) - carsim.Y.Data(i-1);
    delta_d = sqrt(dx^2 + dy^2); % Using 2D distance since model is 2D
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
disp(['Total Run Time: ', num2str(carsim.tout(end)), ' seconds', newline]);

% Plot SOC
ft = figure();
ft.WindowState = 'maximized';
plot(carsim.SOC1)
xlabel('Time');
ylabel('SOC');
title('SOC vs Time');

% Plot track and car motion in 3D
ft = figure();
ft.WindowState = 'maximized';
hold on
plot3(track.x_track, track.y_track, track.z_track, '--', Color='#D95319'); 
plot3(track.xo_track, track.yo_track, track.z_track, 'k'); 
plot3(track.xi_track, track.yi_track, track.z_track, 'k'); 
plot3(carsim.X.Data, carsim.Y.Data, car_z, 'b', LineWidth=2)

axis([-300, 1200, -100, 500, 0, 12]); % Include z-axis limits
xlabel('X (meters)');
ylabel('Y (meters)');
zlabel('Z (meters)');
title('3D Race Track');
grid on;
view(3); % 3D view
hold off;

%% Plot Track - updated to include height changes
function [x_track, y_track, x_target, y_target, xi_track, yi_track, xo_track, yo_track, s, z_track] = plottrack(track_length, track_radius, track_width)
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
    z_track = zeros(size(s)); % Height array
    
    s1 = track_length;              % End of first straight
    s2 = track_length + l_curve;    % End of first curve
    s3 = 2*track_radius + l_curve;  % End of second straight
    s4 = total_l;                   % End of second curve (back to start)
    
    % Height function
    height_func = @(x) exp((x-450)/50) ./ (1 + exp((x-450)/50)) * 10;
    
    % Compute (x, y, z) based on s
    for i = 1:length(s)
        if s(i) <= s1
            % First straight - increasing height
            x_track(i) = s(i);
            x_target(i) = s(i);
            xo_track(i) = s(i);
            xi_track(i) = s(i);
            y_track(i) = 0;
            y_target(i) = 0;
            yo_track(i) = -track_width/2;
            yi_track(i) = track_width/2;
            z_track(i) = height_func(x_track(i));
        elseif s(i) <= s2
            % First curve - constant height (10m)
            theta = (s(i) - s1) / track_radius;  % Convert arc length to angle
            x_track(i) = track_length + track_radius * cos(theta - pi/2);
            x_target(i) = track_length + (track_radius + 2) * cos(theta - pi/2);
            xo_track(i) = track_length + (track_radius + (track_width/2)) * cos(theta - pi/2);
            xi_track(i) = track_length + (track_radius - (track_width/2)) * cos(theta - pi/2);
            y_track(i) = track_radius * sin(theta - pi/2) + track_radius;
            y_target(i) = (track_radius + 2)  * sin(theta - pi/2) + track_radius;
            yo_track(i) = (track_radius + (track_width/2))  * sin(theta - pi/2) + track_radius;
            yi_track(i) = (track_radius - (track_width/2)) * sin(theta - pi/2) + track_radius;
            z_track(i) = 10; % Constant height on curves
        elseif s(i) <= s3
            % Second straight - decreasing height
            x_track(i) = track_length - (s(i) - s2);
            x_target(i) = track_length - (s(i) - s2);
            xo_track(i) = track_length - (s(i) - s2);
            xi_track(i) = track_length - (s(i) - s2);
            y_track(i) = 2*track_radius;
            y_target(i) = 2*track_radius;
            yo_track(i) = 2*track_radius + track_width/2;
            yi_track(i) = 2*track_radius - track_width/2;
            z_track(i) = height_func(x_track(i));
        else
            % Second curve - constant height (0m)
            theta = (s(i) - s3) / track_radius;  % Convert arc length to angle
            x_track(i) = track_radius * cos(theta + pi/2);
            x_target(i) = (track_radius + 2) * cos(theta + pi/2);
            xo_track(i) = (track_radius + (track_width/2)) * cos(theta + pi/2);
            xi_track(i) = (track_radius - (track_width/2)) * cos(theta + pi/2);
            y_track(i) = track_radius * sin(theta + pi/2) + track_radius;
            y_target(i) = (track_radius + 2) * sin(theta + pi/2) + track_radius;
            yo_track(i) = (track_radius + (track_width/2)) * sin(theta + pi/2) + track_radius;
            yi_track(i) = (track_radius - (track_width/2)) * sin(theta + pi/2) + track_radius;
            z_track(i) = 0; % Constant height on curves
        end
    end
end
