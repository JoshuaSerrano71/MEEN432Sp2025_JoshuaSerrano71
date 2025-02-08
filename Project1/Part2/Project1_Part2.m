% FOR TESTING ITERATION OF METHODS
solvers = {'ode1', 'ode4'};
time_step = [0.1 1];

% Modifiable Variables
omega0 = 0;
theta0 = 0;
const_torque=1;
J1 = 100;
J2 = 1;
b1 = 1;
b2 = 1;

% Running Option 1
k_int = [10 100 1000];
model_handle1 = "Project1_Part2_Op1"; % This Simulink file should be in your folder directory 
set_param(model_handle1, 'SolverName', 'ode1');
for j = 1:length(time_step)
    figure;
    subplot(3,1,1);
    for i=1:length(k_int)
        %tic;
        k = k_int(i);
        out1 = sim(model_handle1);
        subplot(3,1,i);
        hold on
        plot(out1.omega1);
        plot(out1.omega2);
        legend('Omega 1', 'Omega 2', 'Location','southeast');
        hold off
        title(['Omega- Option 1 - Stiffness = ' num2str(k) ' ode1 - DT = ' num2str(time_step(j))]);
        %time_end(1,i) = toc;
    end
end

set_param(model_handle1, 'SolverName', 'ode4');
for j = 1:length(time_step)
    figure;
    subplot(3,1,1);
    for i=1:length(k_int)
        %tic;
        k = k_int(i);
        out1 = sim(model_handle1);
        subplot(3,1,i);
        hold on
        plot(out1.omega1);
        plot(out1.omega2);
        legend('Omega 1', 'Omega 2', 'Location','southeast');
        hold off
        title(['Omega- Option 1 - Stiffness = ' num2str(k) ' ode4 - DT = ' num2str(time_step(j))]);
        %time_end(1,i) = toc;
    end
end

set_param(model_handle1, 'SolverName', 'ode45');
figure;
subplot(3,1,1);
    for i=1:length(k_int)
        %tic;
        k = k_int(i);
        out1 = sim("Project1_Part2_Op1.slx");
        subplot(3,1,i);
        hold on
        plot(out1.omega1);
        plot(out1.omega2);
        legend('Omega 1', 'Omega 2', 'Location','southeast');
        hold off
        title(['Omega- Option 1 - Stiffness = ' num2str(k) ' ode45']);
        %time_end(1,i) = toc;
    end


% Running Option 2
figure;
model_handle = "Project1_Part2_Op2";
for i = 1:length(solvers)
    for j = 1:length(time_step)
        set_param(model_handle, 'SolverName', solvers{i});
        set_param(model_handle, 'FixedStep', num2str(time_step(j)));
        out2 = sim(model_handle);
        plot(out2.omega);
        ylabel('Omega (rad/s)');
        xlabel('Time (s)');
        hold on
        title('Omega - Option 2');
        
        
    end
end
set_param(model_handle, 'SolverName', 'ode45');
out = sim(model_handle);
plot(out.omega);
legend('ode1 - 0.1', 'ode1 - 1', 'ode4 - 0.1', 'ode4 - 1', 'ode45');


% Running Option 3
figure;
model_handle3 = "Project1_Part2_Op3";
for i = 1:length(solvers)
    for j = 1:length(time_step)
        set_param(model_handle3, 'SolverName', solvers{i});
        set_param(model_handle3, 'FixedStep', num2str(time_step(j)));
        out = sim(model_handle3);
        plot(out.omega);
        ylabel('Omega (rad/s)');
        xlabel('Time (s)');
        hold on
        title('Omega - Option 3');
    end
end
set_param(model_handle3, 'SolverName', 'ode45');
out = sim(model_handle3);
plot(out.omega);
legend('ode1 - 0.1', 'ode1 - 1', 'ode4 - 0.1', 'ode4 - 1', 'ode45');


% cpu error
cpu_time_e1 = [0.6879 0.7412];
cpu_time_r1 = [0.8106 0.7401];
cpu_time_auto = 0.7935;

cpu_time_e2 = [1.073454 0.742930];
cpu_time_r2 = [0.806034 0.794336];
cpu_time_auto2 = 0.927880;

cpu_time_e3 = [1.201166 1.360497];
cpu_time_r3 = [1.299591 1.478935];
cpu_time_auto3 = 1.348127;

% plotting time
figure;
subplot(3,1,1);
time_step = [0.1 1];
plot(time_step, cpu_time_e1,'-o');
hold on
plot(time_step, cpu_time_r1, '-o');
legend('Euler', 'RK4');
title('CPU Time vs. Time Step - Option 1')
ylabel('Time (s)');
xlabel('Time Step (s)');
hold off

subplot(3,1,2);
plot(time_step, cpu_time_e2,'-o');
hold on
plot(time_step, cpu_time_r2, '-o');
legend('Euler', 'RK4');
title('CPU Time vs. Time Step - Option 2')
ylabel('Time (s)');
xlabel('Time Step (s)');
hold off

subplot(3,1,3);
plot(time_step, cpu_time_e3,'-o');
hold on
plot(time_step, cpu_time_r3, '-o');
legend('Euler', 'RK4');
title('CPU Time vs. Time Step - Option 3')
ylabel('Time (s)');
xlabel('Time Step (s)');
hold off
