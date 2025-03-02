% Project 3 Initilization
r = 0.3;
m = 1000;
I = 1600;
I_w = 0;
F_drag = 0;


%% plotting epa cycle (urban)
f = figure;
plot(time, urban_epa, 'r');
hold on
plot(time, urban_epa + 3, '--b');
plot(time, urban_epa - 3, '--b');
f.WindowState = 'maximized';
plot(out.simv, 'g');