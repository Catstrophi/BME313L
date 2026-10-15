%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Xinhe Wang, BME 313L (16500) | Week 7 Problem 2
% File Name: XinheWang_spectralRadiusStudy.m
%
% Description: Calculates the spectral radius and predicted iterations
% per digit for Jacobi, Gauss-Seidel, and SOR.
%
% Explanation:
% The iteration matrix is G = M^(-1)*N, where N = M - A.
% The error after k iterations is e_k = G^k*e_0.
% The slowest error component decreases approximately by rho(G)^k.
%
% For one additional digit, the error must decrease by a factor of 10:
% rho(G)^k = 0.1
% k*log10(rho(G)) = -1
% k = -1/log10(rho(G))
%
% For this heat equation system, rho(G_GS) = rho(G_J)^2.
% Therefore, k_GS = k_J/2, explaining why Gauss-Seidel requires approximately half as many iterations as Jacobi.
%
% Program Usage Instructions and Example:
% >> XinheWang_spectralRadiusStudy
%
% Inputs:
% Requires laplacianMat.m; uses lambda = 1.75 for SOR.
% Measured iterations per digit are taken from Lab 6.
%
% Outputs:
% Spectral radii, predicted and measured iterations per digit for
% all three methods, and the Gauss-Seidel vs Jacobi squared comparison.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Generate heat equation system
[A, b, grid] = laplacianMat([0 1 0 1]);

% Extract diagonal and lower triangular matrices
D = diag(diag(A));
L = tril(A, -1);

% Jacobi
M_J = D;
N_J = M_J - A;
G_J = M_J \ N_J;

% Gauss-Seidel
M_GS = D + L;
N_GS = M_GS - A;
G_GS = M_GS \ N_GS;

% SOR
lambda = 1.75;
M_SOR = (1/lambda)*D + L;
N_SOR = M_SOR - A;
G_SOR = M_SOR \ N_SOR;

% Calculate spectral radii
rho_J = max(abs(eig(G_J)));
rho_GS = max(abs(eig(G_GS)));
rho_SOR = max(abs(eig(G_SOR)));

% Predicted iterations per digit
pred_J = -1/log10(rho_J);
pred_GS = -1/log10(rho_GS);
pred_SOR = -1/log10(rho_SOR);

% Measured iterations per digit from Lab 6
measured_J = 186;
measured_GS = 93;
measured_SOR = 53/6;

% Display results based on the table
disp("Problem 2:")

fprintf('%-18s %-18s %-15s %-15s\n', 'Method', 'Spectral Radii', 'Predicted', 'Measured/digit');

fprintf('%-18s %-18.6f %-15.3f %-15.3f\n', 'Jacobi', rho_J, pred_J, measured_J);

fprintf('%-18s %-18.6f %-15.3f %-15.3f\n', 'Gauss-Seidel', rho_GS, pred_GS, measured_GS);

fprintf('%-18s %-18.6f %-15.3f %-15.3f\n', 'SOR (1.75)', rho_SOR, pred_SOR, measured_SOR);

disp(" ")

fprintf('rho(GS) = %.10f, rho(J)^2 = %.10f\n', rho_GS, rho_J^2);
fprintf('Absolute difference = %.3e\n', abs(rho_GS - rho_J^2));
