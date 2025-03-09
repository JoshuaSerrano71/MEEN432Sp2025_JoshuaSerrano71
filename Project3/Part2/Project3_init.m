clear

% Project 3 Initilization
r = 0.3; % m
m = 1000;
I = 1600;
input_gear_inertia = 0.1;
output_gear_inertia = 0.001;
tau_l = 1;
G = 100;
I_w = 0;
F_drag = 0;
Tm_max = 350;
eff = 0.9;

% Importing speed values
init_highway_epa
init_urban_epa_2cycle % CHANGE THIS FOR DIFFERENT EPA CYCLE

%% Model Init - CHANGE THIS FOR DIFFERENT SETTING
epa = urban_epa; % highway_epa
time = urban_time; % highway_time

%% Running simulink
set_param("MEEN432_Project3_start", 'StopTime', string(length(urban_epa)))
simout = sim("MEEN432_Project3_start");

total_power = sum(simout.p_m.Data);

%% plotting epa cycle (urban)
f = figure;
plot(time, epa, 'r');
hold on
plot(time, epa + 3, '--b');
plot(time, epa - 3, '--b');
f.WindowState = 'maximized';
plot(simout.simv, 'g');
title('Simulated Vehicle Velocity vs Time')
ylabel('Velocity (mph)')
xlabel('Time (s)')
legend('Drive Cycle Velocity', '3 mph Error Band', '', 'Sim Velocity');
hold off
