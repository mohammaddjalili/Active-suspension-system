% Define system parameters
M1 = 700;  % kg
M2 = 90;   % kg
k1 = 62000;  % N/m
k2 = 570000;  % N/m
b1 = 500;    % N.s/m
b2 = 22500;  % N.s/m

% Define system matrices
A = [0, 1, 0, 0;
     0, 0, -88.6, -0.7;
     0, 0, 0, 1;
     6333.3, 250, -7110.8, -256.3];
 
B2 = [0;
      0;
      0;
      -k2/M2 - b2/M2];

C = eye(4); % To observe all state variables
D = zeros(4,1);

% Define state-space system
sys = ss(A, B2, C, D);

% Time vector for simulation
t = 0:0.01:10;

% Step response for disturbance input with zero initial conditions
figure;
[y_zero, t_zero, x_zero] = step(sys, t);
plot(t_zero, x_zero);
title('Step Response to Disturbance Input with Zero Initial Conditions');
xlabel('Time (s)');
ylabel('State Variables');
legend('x_s', 'x_s''', 'y', 'y''');
grid on;

% Step response for disturbance input with non-zero initial conditions
figure;
initial_conditions_nonzero = [0.15; 0; 0.1; 0];  % Example non-zero initial conditions
[y_nonzero, t_nonzero, x_nonzero] = initial(sys, initial_conditions_nonzero, t);
hold on;
[y_step, t_step, x_step] = step(sys, t);
x_combined = x_nonzero + x_step; % Superposition principle
plot(t_nonzero, x_combined);
title('Step Response to Disturbance Input with Non-Zero Initial Conditions');
xlabel('Time (s)');
ylabel('State Variables');
legend('x_s', 'x_s''', 'y', 'y''');
grid on;
hold off;