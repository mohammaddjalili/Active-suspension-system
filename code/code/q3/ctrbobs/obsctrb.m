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
 
B = [0;
     1/M1;
     0;
     1/M1 + 1/M2];

C = [0, 0, 1, 0];
D = 0;

% Controllability matrix
n = size(A, 1);
controllability_matrix = ctrb(A, B);

% Observability matrix
observability_matrix = obsv(A, C);

% Check ranks
rank_C = rank(controllability_matrix);
rank_O = rank(observability_matrix);

disp('Rank of Controllability Matrix:');
disp(rank_C);
disp('Rank of Observability Matrix:');
disp(rank_O);

if rank_C == n
    disp('The system is controllable.');
else
    disp('The system is not controllable.');
end

if rank_O == n
    disp('The system is observable.');
else
    disp('The system is not observable.');
end
