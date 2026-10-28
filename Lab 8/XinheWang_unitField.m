%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Xinhe Wang, BME 313L (16500) | Week 8 Problem 1
% File Name: XinheWang_unitField.m
%
% Description: Computes the temperature increase from a unit-power laser source
% using the heat equation matrix with a perfusion factor.
%
% Explanation:
% The zero-boundary Laplacian is modified by adding beta to its diagonal.
% The laser tip is placed at the closest grid point, with source 1/h^2.
% Solving A*v = s gives the unit-power temperature increase.
%
% Question:
% The term beta*w models blood perfusion cooling. Blood carries heat away
% from tissue at a rate proportional to its elevation above 37 C.
% When beta = 0, this cooling disappears. Heat then leaves only
% through conduction to the boundaries held at body temperature, so the
% unit-power temperature field becomes hotter and spreads farther.
%
% Program Usage Instructions and Example:
% [v, D] = XinheWang_unitField(50, [0.55 0.60]);
%
% Inputs:
% beta: Perfusion coefficient; tip: [x y] coordinates of the laser tip.
%
% Outputs:
% v: Unit-power temperature increase vector; D: Interior grid points.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [v, D] = XinheWang_unitField(beta, tip)

    % Generate the heat equation system with zero boundary conditions
    [A, b, D] = laplacianMat([0 0 0 0]);

    % Add the perfusion term
    A = A + beta * eye(size(A));

    % Find the closest grid point to the laser tip
    [~, x] = min(abs(D - tip(1)));
    [~, y] = min(abs(D - tip(2)));

    % Convert grid coordinates to a vector index
    n = length(D);
    k = y + (x - 1)*n;

    % Set the unit-power heat source
    s = b;
    h = 0.05;
    s(k) = 1/h^2;

    % Solve for the unit-power temperature increase
    v = A\s;

