% Initialization
const_torque = 1; % Torque input in Nm
J = 1;  % Inertia in kg m^2
b = 1; % damping coefficient Nm/(rad/s)

% Initial conditions
omega0 = 0;  % rad/s
theta0 = 0;  % rad

%set_param('Project1_shaft/Simple Shaft/IntegrateAcceleration', 'Integrator', '3')

tout = 25;
dt = [1 0.1 0.001];

% Define the function f
f = @(t, y) (const_torque - b*y)/J;

% Euler method
cpu_time1 = [];
max_error1 = [];
h = 1;
t = 0:h:tout;
y = zeros(size(t));
y(1) = omega0;

tStart = cputime;
for k = 1:length(t)-1
    y(k+1) = y(k) + h * f(t(k), y(k));
end
tEnd = cputime - tStart;

% Calculate theoretical solution for comparison (for step input)
w_theoretical = omega0 * exp(-b*t/J) + (const_torque/b) * (1 - exp(-b*t/J));

% Calculate maximum error
max_error = max(abs(y - w_theoretical));

cpu_time1(end+1) = tEnd;
max_error1(end+1) = max_error;
% Damping Force
F_b = b*y;                  % <----- IS THIS BEING USED

h = 0.1;
t = 0:h:tout;
y = zeros(size(t));
y(1) = omega0;

tStart = cputime;
for k = 1:length(t)-1;
    y(k+1) = y(k) + h * f(t(k), y(k));
end
tEnd = cputime - tStart;
disp(['Time: ', num2str(tEnd)]);

% Calculate theoretical solution for comparison (for step input)
w_theoretical = omega0 * exp(-b*t/J) + (const_torque/b) * (1 - exp(-b*t/J));

% Calculate maximum error
max_error = max(abs(y - w_theoretical));

cpu_time1(end+1) = tEnd;
max_error1(end+1) = max_error;

h = 0.001;
t = 0:h:tout;
y = zeros(size(t));
y(1) = omega0;

tStart = cputime;
for k = 1:length(t)-1
    y(k+1) = y(k) + h * f(t(k), y(k));
end
tEnd = cputime - tStart;

% Calculate theoretical solution for comparison (for step input)
w_theoretical = omega0 * exp(-b*t/J) + (const_torque/b) * (1 - exp(-b*t/J));

% Calculate maximum error
max_error = max(abs(y - w_theoretical));

cpu_time1(end+1) = tEnd;
max_error1(end+1) = max_error;
F_b = b*y;

% Runge-Kutta method
cpu_time2 = [];
max_error2 = [];
h = 1;
t = 0:h:tout;
y = zeros(size(t));
y(1) = omega0;

tStart = cputime;
for k = 1:length(t)-1
    k1 = f(t(k), y(k));
    k2 = f(t(k) + 0.5*h, y(k) + 0.5*h*k1);
    k3 = f(t(k) + 0.5*h, y(k) + 0.5*h*k2);
    k4 = f(t(k) + h, y(k) + h*k3);

    y(k+1) = y(k) + (1/6) * (k1 + 2*k2 + 2*k3 + k4) * h;
    tEnd = cputime - tStart;
end
%tEnd = cputime - tStart;

% Calculate theoretical solution for comparison (for step input)
w_theoretical = omega0 * exp(-b*t/J) + (const_torque/b) * (1 - exp(-b*t/J));

% Calculate maximum error
max_error = max(abs(y - w_theoretical));

cpu_time2(end+1) = tEnd;
max_error2(end+1) = max_error;
F_b = b*y;

h = 0.1;
t = 0:h:tout;
y = zeros(size(t));
y(1) = omega0;

tStart = cputime;
for k = 1:length(t)-1
    k1 = f(t(k), y(k));
    k2 = f(t(k) + 0.5*h, y(k) + 0.5*h*k1);
    k3 = f(t(k) + 0.5*h, y(k) + 0.5*h*k2);
    k4 = f(t(k) + h, y(k) + h*k3);

    y(k+1) = y(k) + (1/6) * (k1 + 2*k2 + 2*k3 + k4) * h;
end
tEnd = cputime - tStart;

% Calculate theoretical solution for comparison (for step input)
w_theoretical = omega0 * exp(-b*t/J) + (const_torque/b) * (1 - exp(-b*t/J));

% Calculate maximum error
max_error = max(abs(y - w_theoretical));

cpu_time2(end+1) = tEnd;
max_error2(end+1) = max_error;
F_b = b*y;

h = 0.001;
t = 0:h:tout;
y = zeros(size(t));
y(1) = omega0;

tStart = cputime;
for k = 1:length(t)-1
    k1 = f(t(k), y(k));
    k2 = f(t(k) + 0.5*h, y(k) + 0.5*h*k1);
    k3 = f(t(k) + 0.5*h, y(k) + 0.5*h*k2);
    k4 = f(t(k) + h, y(k) + h*k3);

    y(k+1) = y(k) + (1/6) * (k1 + 2*k2 + 2*k3 + k4) * h;
end
tEnd = cputime - tStart;

% Calculate theoretical solution for comparison (for step input)
w_theoretical = omega0 * exp(-b*t/J) + (const_torque/b) * (1 - exp(-b*t/J));

% Calculate maximum error
max_error = max(abs(y - w_theoretical));

cpu_time2(end+1) = tEnd;
max_error2(end+1) = max_error;
F_b = b*y;

figure;
subplot(3,1,1);
plot(dt, max_error1, '-o');
xlabel('Time Step (s)');
ylabel('Max Simulation Error');
title('Max Simulation Error vs Time Step');
hold on
plot(dt, max_error2, '-o');
legend('Euler', 'RK4');
hold off

subplot(3,1,2);
plot(dt, cpu_time1, '-o');
xlabel('Time Step (s)');
ylabel('CPU Time (s)');
title('CPU Time vs Time Step');
hold on
plot(dt, cpu_time2, '-o');
legend('Euler', 'RK4');

subplot(3,1,3);
plot(cpu_time1, max_error1, '-o');
xlabel('CPU Time (s)');
ylabel('Max Simulation Error');
title('Max Simulation Error vs CPU Time');
hold on
plot(cpu_time2, max_error2, '-o');
legend('Euler', 'RK4');
hold off


%Contour Plots (Don't work right now because of the singular inputs)
% figure;
% [X, Y] = meshgrid(cpu_time1, max_error1);
% [C, h] = contour(X, Y, -b_values./J_values);
% clabel(C, h);
% xlabel('CPU Time (s)');
% ylabel('Max Simulation Error');
% title('Contour Plot of System Eigenvalues for Euler Method');
% colorbar;
% clim([min(-b_values./J_values, [], 'all') max(-b_values./J_values, [], 'all')]);
% colormap('jet');
% 
% figure;
% [X, Y] = meshgrid(cpu_time1, max_error1);
% [C, h] = contour(X, Y, omega0);
% clabel(C, h);
% xlabel('CPU Time (s)');
% ylabel('Max Simulation Error');
% title('Contour Plot of Input Frequencies for Euler Method');
% colorbar;
% clim([min(omega0, [], 'all') max(omega0, [], 'all')]);
% colormap('jet');
% 
% figure;
% [X, Y] = meshgrid(cpu_time2, max_error2);
% [C, h] = contour(X, Y, -b_values./J_values);
% clabel(C, h);
% xlabel('CPU Time (s)');
% ylabel('Max Simulation Error');
% title('Contour Plot of System Eigenvalues for RK4 Method');
% colorbar;
% clim([min(-b./J, [], 'all') max(-b./J, [], 'all')]);
% colormap('jet');
% 
% figure;
% [X, Y] = meshgrid(cpu_time2, max_error2);
% [C, h] = contour(X, Y, omega0);
% clabel(C, h);
% xlabel('CPU Time (s)');
% ylabel('Max Simulation Error');
% title('Contour Plot of Input Frequencies for RK4 Method');
% colorbar;
% clim([min(omega0, [], 'all') max(omega0, [], 'all')]);
% colormap('jet');
