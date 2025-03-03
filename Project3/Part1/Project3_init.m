% Project 3 Initilization
r = 0.3;
m = 1000;
I = 1600;
I_w = 0;
F_drag = 0;
%% Model Init - CHANGE THIS FOR DIFFERENT EPA CYCLE
epa = urban_epa;
time = urban_time;
%% Simulation
out = sim('MEEN432_Project3_start.slx');
%% plotting epa cycle (urban)
f = figure;
plot(time, urban_epa, 'r');
hold on
plot(time, urban_epa + 3, '--b');
plot(time, urban_epa - 3, '--b');
f.WindowState = 'maximized';
plot(out.simv, 'g');
title('Simulated Vehicle Velocity vs Time')
ylabel('Velocity (mph)')
xlabel('Time (s)')
legend('Drive Cycle Velocity', '3 mph Error Band', '', 'Sim Velocity');
hold off


% %% plotting epa cycle (highway)
% f2 = figure;
% plot(time_highway, highway_epa, 'r');
% hold on
% plot(time_highway, highway_epa + 3, '--b');
% plot(time_highway, highway_epa - 3, '--b');
% f2.WindowState = 'maximized';
% hold off






