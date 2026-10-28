%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Xinhe Wang, BME 313L (16500) | Week 8 Problem 1
% File Name: plotUnitField.m
%
% Description: Compares unit-power temperature fields for beta = 50
% and beta = 0, and plots the beta = 50 field.
%
% Explanation:
% The unitField function computes the temperature increase at each
% grid node. The beta = 50 solution is reshaped into a square grid
% for a surface plot.
%
% Program Usage Instructions and Example:
% plotUnitField
%
% Inputs:
% Requires XinheWang_unitField.m and laplacianMat.m.
%
% Outputs:
% Unit-field values at target point for both beta values and a surface
% plot of the beta = 50 unit-power temperature increase.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calculate unit-power fields for both perfusion coefficients
[v50, D] = XinheWang_unitField(50, [0.55 0.60]);
[v0, D] = XinheWang_unitField(0, [0.55 0.60]);

% Display the temperature increases at node 202
disp(v50(202))
disp(v0(202))

% Reshape the beta = 50 field for plotting
n = length(D);
V = zeros(n, n);
V(:) = v50;

% Plot the unit-power temperature increase
surf(D, D, V)
xlabel("x")
ylabel("y")
zlabel("Temperature increase (C)")
title("Unit Power Field, beta = 50")
