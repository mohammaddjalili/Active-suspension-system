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

% Define ramp input (0.1*t)
ramp_input = 0.1 * t;

% Response to ramp input with zero initial conditions
figure;
initial_conditions_zero = [0; 0; 0; 0];
[y_zero, t_zero, x_zero] = lsim(sys, ramp_input, t, initial_conditions_zero);
plot(t_zero, x_zero);
title('Response to Ramp Input 0.1*t with Zero Initial Conditions');
xlabel('Time (s)');
ylabel('State Variables');
legend('x_s', 'x_s''', 'y', 'y''');
grid on;

% Response to ramp input with non-zero initial conditions
figure;
initial_conditions_nonzero = [0.1; 0; 0; 0];  % Example non-zero initial conditions
[y_nonzero, t_nonzero, x_nonzero] = lsim(sys, ramp_input, t, initial_conditions_nonzero);
plot(t_nonzero, x_nonzero);
title('Response to Ramp Input 0.1*t with Non-Zero Initial Conditions');
xlabel('Time (s)');
ylabel('State Variables');
legend('x_s', 'x_s''', 'y', 'y''');
grid on;