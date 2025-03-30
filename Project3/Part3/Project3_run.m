clear

% Project 3 Initilization
p3_init

% Importing speed values
init_highway_epa
init_urban_epa_2cycle % CHANGE THIS FOR DIFFERENT EPA CYCLE

%% Model Init - CHANGE THIS FOR DIFFERENT SETTING
epa = urban_epa; % highway_epa
time = urban_time; % highway_time

%% Running simulink
set_param("MEEN432_Project3_Wk3_Model", 'StopTime', string(length(urban_epa)))
simout = sim("MEEN432_Project3_Wk3_Model");

total_power = sum(simout.MotorPower.Data);

%% plotting epa cycle (urban)
f = figure;
plot(time, epa, 'r');
hold on
plot(time, epa + 3, '--b');
plot(time, epa - 3, '--b');
f.WindowState = 'maximized';
plot(simout.ActualSpeed, 'g');
title('Simulated Vehicle Velocity vs Time')
ylabel('Velocity (mph)')
xlabel('Time (s)')
legend('Drive Cycle Velocity', '3 mph Error Band', '', 'Sim Velocity');
hold off
