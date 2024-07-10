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

% Step 1: Find eigenvalues and eigenvectors
[eigenvectors, eigenvalues] = eig(A);

% Step 2: Transform A to Jordan form
[J, P] = jordan(A);

disp('Jordan form of A:');
disp(J);
disp('Transformation matrix P:');
disp(P);