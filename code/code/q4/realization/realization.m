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
sys = ss(A, B, C, D);

% Calculate the transfer function
H = tf(sys);

% Display the transfer function
disp('Transfer Function:');
H

% Numerator and denominator of the transfer function
[num, den] = tfdata(H, 'v');

% Define the order of the system
n = length(den) - 1;

% Controllable Canonical Form
A_c = [zeros(n-1,1), eye(n-1); -flip(den(2:end))];
B_c = [zeros(n-1,1); 1];
C_c = flip(num(2:end)) - num(1)*flip(den(2:end));
D_c = num(1);

% Display the matrices of the Controllable Canonical Form
disp('Controllable Canonical Form:');
disp('A_c = ');
disp(A_c);
disp('B_c = ');
disp(B_c);
disp('C_c = ');
disp(C_c);
disp('D_c = ');
disp(D_c);

% Define the Controllable Canonical Form state-space system
sys_c = ss(A_c, B_c, C_c, D_c);

% Display the Controllable Canonical Form state-space system
disp('Controllable Canonical Form State-Space System:');
sys_c
