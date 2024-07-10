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
C = [0 0 1 0];

% Define direct transmission matrix D
D = 0;

% Check controllability of the system
phic = ctrb(A, B);  % Controllability matrix
rank_phic = rank(phic);  % Rank of controllability matrix
disp(['Controllability Matrix Rank: ', num2str(rank_phic)]);

% Check observability of the system
phio = obsv(A, C);  % Observability matrix
rank_phio = rank(phio);  % Rank of observability matrix
disp(['Observability Matrix Rank: ', num2str(rank_phio)]);

% Desired performance metrics based on PID results
settling_time = 0.77725;  % seconds
overshoot = 7.269 / 100;  % as a fraction

% Calculate natural frequency and damping ratio
zeta = -log(overshoot) / sqrt(pi^2 + log(overshoot)^2);
omega_n = 4 / (zeta * settling_time);

% Calculate desired poles
p1 = -zeta * omega_n + omega_n * sqrt(1 - zeta^2) * 1i;
p2 = -zeta * omega_n - omega_n * sqrt(1 - zeta^2) * 1i;
p3 = 5 * real(p1);  % Place remaining poles further left in the s-plane
p4 = 5 * real(p2);

desired_poles = [p1, p2, p3, p4];
disp('Desired Poles:');
disp(desired_poles);

% Design state feedback controller using acker
K = acker(A, B, desired_poles);

% Closed-loop system
Acl = A - B * K;
sys_cl = ss(Acl, B, C, D);

% Simulate step response
t = 0:0.01:10;  % Time vector for simulation
[y, t, x] = step(sys_cl, t);

% Plot 4 graphs for each state variable
figure;
subplot(2, 2, 1);
plot(t, y(:,1));
title('Step Response - xs');
xlabel('Time (s)');
ylabel('Position (m)');
grid on;

subplot(2, 2, 2);
plot(t, y(:,2));
title('Step Response - xs dot');
xlabel('Time (s)');
ylabel('Velocity (m/s)');
grid on;

subplot(2, 2, 3);
plot(t, y(:,3));
title('Step Response - y');
xlabel('Time (s)');
ylabel('Position (m)');
grid on;

subplot(2, 2, 4);
plot(t, y(:,4));
title('Step Response - y sot');
xlabel('Time (s)');
ylabel('Velocity (m/s)');
grid on;

% Analyze performance metrics of the closed-loop system
info = stepinfo(y(:,1), t);
disp('Performance Metrics of the Closed-Loop System:');
disp(['Settling Time: ', num2str(info.SettlingTime), ' seconds']);
disp(['Overshoot: ', num2str(info.Overshoot), ' %']);
disp(['Rise Time: ', num2str(info.RiseTime), ' seconds']);
