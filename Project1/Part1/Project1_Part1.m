
% Initialization
omega0_values = [10 0];  % rad/s
theta0 = 0;  % rad
J_values = [100 0.01];  % Inertia in kg m^2
b_values = [10 0.1]; % damping coefficient Nm/(rad/s)

const_torque_values = [0, 100]; % Torque input in Nm
w_values = [0.1 100]; %frequency

dt_values = [1 0.1 0.001];
int_method = ["ode1", "ode4", "ode45", "ode23tb"];

torque_str = ["Constant at 0 Nm", "Constant at 100 Nm", "Sinusodial with a frequency of 0.1 rad/s", "Sinusodial with a frequency of 100 rad/s"];
p = 0;

% Initialize arrays to store results
cpu_time = zeros((length(const_torque_values)+length(w_values))*length(J_values)*length(b_values)*length(omega0_values), 8);
max_error = zeros((length(const_torque_values)+length(w_values))*length(J_values)*length(b_values)*length(omega0_values), 8);

% Delete error log file if it exists
if exist('error_log.txt', 'file')
    delete('error_log.txt');
end

fileID = fopen('error_log.txt', 'a');

% Nested loops to iterate through all combinations
for i = 1:(length(const_torque_values)+length(w_values))
    for j = 1:length(J_values)
        for k = 1:length(b_values)
            for l = 1:length(omega0_values)
                o = 0;
                for n = 1:length(int_method)
                    p = p + 1;
                    if i <= 2
                        const_torque = const_torque_values(i);
                        w = 0;
                    else
                        w = w_values(i-2);
                        const_torque = 0;
                    end
                    J = J_values(j);
                    b = b_values(k);
                    omega0 = omega0_values(l);
                    
                    % Set simulation parameters
                    set_param(Project1_shaft, 'StopTime', '25');
                    if n <= 2
                        for m = 1:length(dt_values)
                            dt = dt_values(m);
                            set_param(Project1_shaft, 'SolverType', 'Fixed-step');
                            set_param(Project1_shaft, 'FixedStep', num2str(dt));
                            set_param(Project1_shaft, 'SolverName', int_method(n));

                            o = o+1;

                            % Run simulation and measure CPU time
                            try
                                tStart = cputime;
                                sim("Project1_shaft");
                                tEnd = cputime - tStart;
                                cpu_time(nearestDiv(p, 8)+1, o) = tEnd;
                                
                                % Calculate theoretical solution
                                t = 0:dt:25;
                                w_theoretical = omega0 * exp(-b*t/J) + (const_torque/b) * (1 - exp(-b*t/J));
                                
                                % Calculate maximum error
                                max_error(nearestDiv(p, 8)+1, o) = max(abs(omega(2,:) - transpose(w_theoretical)));
                                if o == 6
                                    w_theoretical_RK4 = omega(2,:);
                                end

                            catch ME
                                errorMsg = sprintf(['Error in iteration: Torque = %s, Inertia = %d kgm^2, Damping = %d' ...
                                    ' Nms/rad, Initial Frequency = %d rad/s, Solver = %s with %d stepsize'], ...
                                    torque_str(i), J_values(j), b_values(k), omega0_values(l), int_method(n), dt_values(m));
                                errorMsg = [errorMsg, newline, 'Error message: ', ME.message];
                                errorMsg = [errorMsg, newline, '----------------------------------------', newline, newline];
    
                                % Write to file
                                fprintf(fileID, '%s', errorMsg);
                            end
                        end
                    else
                        set_param(Project1_shaft, 'SolverType', 'Variable-step');
                        set_param(Project1_shaft, 'SolverName', int_method(n));

                        o = o+1;

                        % Run simulation and measure CPU time
                    try
                        tStart = cputime;
                        sim("Project1_shaft");
                        tEnd = cputime - tStart;
                        cpu_time(nearestDiv(p, 8)+1, o) = tEnd;
                        
                        % Calculate maximum error
                        max_error(nearestDiv(p, 8)+1, o) = max(abs(omega(2,:) - w_theoretical_RK4));

                    catch ME
                                errorMsg = sprintf(['Error in iteration: Torque = %s, Inertia = %d kgm^2, Damping = %d' ...
                                    ' Nms/rad, Initial Frequency = %d rad/s, Solver = %s'], ...
                                    torque_str(i), J_values(j), b_values(k), omega0_values(l), int_method(n));
                                errorMsg = [errorMsg, newline, 'Error message: ', ME.message];
                                errorMsg = [errorMsg, '----------------------------------------', newline];
                    end
                    end
                end
            end
        end
    end
end

% Close the model and file
close_system(Project1_shaft, 0);
fclose(fileID);

figure;
subplot(2,1,1);
plot(dt_values, max_error(:,1:3), 'r-o');
xlabel('Time Step (s)');
ylabel('Max Simulation Error');
title('Max Simulation Error vs Time Step for Euler');

subplot(2,1,2);
plot(dt_values, max_error(:,4:6), 'b-x');
xlabel('Time Step (s)');
ylabel('Max Simulation Error');
title('Max Simulation Error vs Time Step for RK4');

figure;
subplot(2,1,1);
plot(dt_values, cpu_time(:,1:3), 'r-o');
xlabel('Time Step (s)');
ylabel('CPU Time (s)');
title('CPU Time vs Time Step for Euler');

subplot(2,1,2);
plot(dt_values, cpu_time(:,4:6), 'b-x');
xlabel('Time Step (s)');
ylabel('CPU Time (s)');
title('CPU Time vs Time Step for RK4');

figure;
subplot(4,1,1);
plot(cpu_time(:,1:3), max_error(:,1:3), 'r-o');
xlabel('CPU Time (s)');
ylabel('Max Simulation Error');
title('Max Simulation Error vs CPU Time for Euler');

subplot(4,1,2);
plot(cpu_time(:,4:6), max_error(:,4:6), 'b-o');
xlabel('CPU Time (s)');
ylabel('Max Simulation Error');
title('Max Simulation Error vs CPU Time for RK4');

subplot(4,1,3);
plot(cpu_time(:,7), max_error(:,7), 'g-x');
xlabel('CPU Time (s)');
ylabel('Max Simulation Error');
title('Max Simulation Error vs CPU Time for ode45');

subplot(4,1,4);
plot(cpu_time(:,7), max_error(:,7), 'k-x');
xlabel('CPU Time (s)');
ylabel('Max Simulation Error');
title('Max Simulation Error vs CPU Time for ode23tb');
