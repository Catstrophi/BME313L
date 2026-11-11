% Need a full header
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Lab 10, Problem 1: fit y = q(x) to the first branch and report cond(A)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Load the data (positions in mm, image coordinates)
load('carotidCenterline.mat', 'X1', 'Y1', 'X2', 'Y2');

% Visualize the point cloud
close all; figure(1);
plot(X1, Y1, 'b*', 'markersize', 6); hold on;  % first branch
plot(X2, Y2, 'r*', 'markersize', 6);           % second branch
axis equal; xlabel('x (mm)'); ylabel('y (mm)');

% (1) Build the least squares matrix A for the quadratic y = a x^2 + b x + c
%     on the first branch (do not use polyfit) and report cond(A)



% (2) Solve for the coefficients q with backslash and report the RMS
%     vertical residual sqrt(mean((Y1 - A*q).^2)) in mm



% (3) Plot the fitted quadratic over the x-range of the first branch and
%     put cond(A) and the RMS residual in the title



