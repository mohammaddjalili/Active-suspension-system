% Define system parameters
M1 = 700;  % kg
M2 = 90;   % kg
k1 = 62000;  % N/m
k2 = 570000;  % N/m
b1 = 500;    % N.s/m
b2 = 22500;  % N.s/m

% Define system matrix A
A = [0, 1, 0, 0;
     0, 0, -88.6, -0.7;
     0, 0, 0, 1;
     6333.3, 250, -7110.8, -256.3];

% Define input matrix B
B = [0;
     1/M1;
     0;
     1/M2];

% Define output matrix C
C = [0, 0, 1, 0];

% Define direct transmission matrix D
D = 0;

% Define state-space system
sys_open = ss(A, B, C, D);

% Calculate the transfer function of the open-loop system
H_open = tf(sys_open);

% Display the transfer function
disp('Open-Loop Transfer Function:');
H_open

% Step 1: Use the pidtune function to get optimal PID parameters
[PID_controller, info] = pidtune(H_open, 'PID');

% Display the optimized PID parameters
Kp = PID_controller.Kp;
Ki = PID_controller.Ki;
Kd = PID_controller.Kd;
disp('Optimized PID Parameters:');
disp(['Kp: ', num2str(Kp)]);
disp(['Ki: ', num2str(Ki)]);
disp(['Kd: ', num2str(Kd)]);

% Step 2: Form the closed-loop system with the optimized PID controller
sys_closed = feedback(PID_controller * H_open, 1);

% Step 3: Simulate the step response of the closed-loop system
t = 0:0.01:10;  % Time vector for simulation
[y_closed, t_closed] = step(sys_closed, t);

% Plot the step response of the closed-loop system
figure;
plot(t_closed, y_closed);
title('Step Response of the Closed-Loop System with Optimized PID');
xlabel('Time (s)');
ylabel('Output');
grid on;

% Analyze the performance metrics of the closed-loop system
info = stepinfo(sys_closed);

% Display the performance metrics
disp('Performance Metrics of the Closed-Loop System:');
disp(['Settling Time: ', num2str(info.SettlingTime), ' seconds']);
disp(['Overshoot: ', num2str(info.Overshoot), ' %']);
disp(['Rise Time: ', num2str(info.RiseTime), ' seconds']);
