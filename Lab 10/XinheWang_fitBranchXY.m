%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Xinhe Wang, BME 313L (16500) | Week 10 Problem 1
% File Name: XinheWang_fitBranchXY.m
%
% Description: Fits a quadratic to the first carotid branch in the
% original image coordinates.
%
% Explanation:
% Backslash solves the quadratic least-squares problem.
% The condition number measures sensitivity to changes in the data,
% and the RMS residual measures the vertical fitting error.
%
% Question:
% 1. The x-values have a small spread around a large offset near 77 mm.
% Therefore, x and x^2 are dominated by nearly constant terms, making
% the columns of A nearly parallel and the condition number large.
%
% 2. The relative-error bound is the condition number times the relative
% data error. For a relative perturbation of 0.010, the bound is about
% 141941.163, so it guarantees no accurate coefficient digits.
%
% Question 3 is answered in the separate PDF.
%
% Program Usage Instructions and Example:
% XinheWang_fitBranchXY
%
% Inputs:
% carotidCenterline.mat.
%
% Outputs:
% Condition number, RMS residual, and a plot of the fitted quadratic
% over the original point cloud.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Load the data (positions in mm, image coordinates)
load("carotidCenterline.mat", "X1", "Y1", "X2", "Y2");

% Visualize the point cloud
figure;
plot(X1, Y1, "b*", "markersize", 6); hold on;  % first branch
plot(X2, Y2, "r*", "markersize", 6);           % second branch
axis equal; xlabel("x (mm)"); ylabel("y (mm)");

% (1) Build the least squares matrix A for the quadratic y = a x^2 + b x + c
%     on the first branch (do not use polyfit) and report cond(A)

A = [X1.^2, X1, ones(length(X1), 1)];
conditionNumber = cond(A);

disp("Condition number:")
disp(conditionNumber)

% (2) Solve for the coefficients q with backslash and report the RMS
%     vertical residual sqrt(mean((Y1 - A*q).^2)) in mm

q = A \ Y1;
rmsResidual = sqrt(mean((Y1 - A*q).^2));

disp("RMS residual (mm):")
disp(rmsResidual)

% (3) Plot the fitted quadratic over the x-range of the first branch and
%     put cond(A) and the RMS residual in the title

xFit = linspace(min(X1), max(X1), 200);
yFit = q(1)*xFit.^2 + q(2)*xFit + q(3);

plot(xFit, yFit, "b-");

title("cond(A) = " + conditionNumber + "; RMS residual = " + rmsResidual + " mm");