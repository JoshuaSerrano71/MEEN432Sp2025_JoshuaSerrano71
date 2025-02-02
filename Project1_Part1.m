% Initialization
omega0_values = [10 0];  % rad/s
theta0 = 0;  % rad
J_values = [100 0.01];  % Inertia in kg m^2
b_values = [10 0.1]; % damping coefficient Nm/(rad/s)

const_torque_values = [0, 100]; % Torque input in Nm
w_values = [0.1 100]; %frequency

dt_values = [1 0.1 0.001];
int_method = ["ode1", "ode4", "ode45", "ode23tb"];

% Initialize arrays to store results
cpu_time = zeros((length(const_torque_values)+length(w_values)), length(J_values), length(b_values), length(omega0_values), 8);
max_error = zeros((length(const_torque_values)+length(w_values)), length(J_values), length(b_values), length(omega0_values), 8);
error_messages = cell(length(const_torque_values)+length(w_values), length(J_values), length(b_values), length(omega0_values), 8);

% Nested loops to iterate through all combinations
for i = 1:(length(const_torque_values)+length(w_values))
    for j = 1:length(J_values)
        for k = 1:length(b_values)
            for l = 1:length(omega0_values)
                o = 0;
                for n = 1:length(int_method)
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
                    dt = dt_values(m);
                    
                    % Set simulation parameters
                    set_param(Project1_shaft, 'StopTime', '25');
                    if n <= 2
                        for m = 1:length(dt_values)
                            set_param(Project1_shaft, 'SolverType', 'Fixed-step');
                            set_param(Project1_shaft, 'FixedStep', num2str(dt));
                            set_param(Project1_shaft, 'SolverName', int_method(n));

                            o = o+1;

                            % Run simulation and measure CPU time
                            try
                                tStart = cputime;
                                sim("Project1_shaft");
                                tEnd = cputime - tStart;
                                cpu_time(i,j,k,l,o) = tEnd;
                                
                                % Calculate theoretical solution
                                t = 0:dt:25;
                                w_theoretical = omega0 * exp(-b*t/J) + (const_torque/b) * (1 - exp(-b*t/J));
                                
                                % Calculate maximum error
                                max_error(i,j,k,l,o) = max(abs(omega(2,:) - transpose(w_theoretical)));
                                if o == 6
                                    w_theoretical_RK4 = omega(2,:);
                                end
                            catch ME
                                error_messages{i,j,k,l,o} = ME.message;
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
                        cpu_time(i,j,k,l,o) = tEnd;
                        
                        % Calculate maximum error
                        max_error(i,j,k,l,o) = max(abs(omega(2,:) - w_theoretical_RK4));
                    catch ME
                        error_messages{i,j,k,l,o} = ME.message;
                    end
                    end
                end
            end
        end
    end
end

% Close the model
close_system(Project1_shaft, 0);

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
