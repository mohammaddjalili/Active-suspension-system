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
eig(A)

% Step 1: Define Q as a positive definite matrix
Q = eye(size(A));

% Step 2: Solve the Lyapunov equation A'P + PA = -Q
P = lyap(A', Q);

% Step 3: Check if P is positive definite
is_positive_definite = all(eig(P) > 0);

% Display the results
disp('Matrix P:');
disp(P);
disp('Is P positive definite?');
disp(is_positive_definite);

if is_positive_definite
    disp('The system is Lyapunov stable.');
else
    disp('The system is not Lyapunov stable.');
end
