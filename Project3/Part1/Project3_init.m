clear

% Project 3 Initilization
r = 0.3;
m = 1000;
I = 1600;
I_w = 0;
F_drag = 0;

% Importing speed values
init_highway_epa
init_urban_epa_2cycle

% Running simulink
set_param("MEEN432_Project3_start", 'StopTime', string(length(urban_epa)))
simout = sim("MEEN432_Project3_start");

%% plotting epa cycle (urban)
f = figure;
plot(time, urban_epa, 'r');
hold on
plot(time, urban_epa + 3, '--b');
plot(time, urban_epa - 3, '--b');
f.WindowState = 'maximized';
plot(simout.simv, 'g');
title('Simulated Vehicle Velocity vs Time')
ylabel('Velocity (mph)')
xlabel('Time (s)')
legend('Drive Cycle Velocity', '3 mph Error Band', '', 'Sim Velocity');
