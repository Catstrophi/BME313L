%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Xinhe Wang, BME 313L (16500) | Week 10 Problem 2
% File Name: XinheWang_centerlinePCA.m
%
% Description: Fits both carotid branches in a shared principal
% component frame and finds their intersection.
%
% Explanation:
% Both branches determine one centroid and principal component frame.
% After centering and rotating the data, backslash fits each quadratic.
% The intersection nearest the second branch gives the bifurcation.
%
% Question:
% 2. The power-method direction agrees with eig to within 0.001 degrees
% after accounting for a possible sign difference. Opposite signs
% represent the same principal axis.
% This is verification because two algorithms are compared for the
% same mathematical problem, rather than checking against reality.
%
% 3. Both branches need the same origin and axes so their fitted
% quadratics can be compared and intersected directly.
% Separate principal component frames would give different coordinates.
%
% Questions 1 and 4 are answered in the separate PDF.
%
% Program Usage Instructions and Example:
% load("carotidCenterline.mat");
% [c, V, q1, q2, ub] = XinheWang_centerlinePCA(X1, Y1, X2, Y2);
%
% Inputs:
% X1, Y1: First branch coordinates.
% X2, Y2: Second branch coordinates.
% Requires pcaLine.m and powerMethod.m.
%
% Outputs:
% c: Shared centroid; V: Orthonormal principal directions.
% q1, q2: Quadratic coefficient vectors.
% ub: Bifurcation coordinate along the first principal direction.
% Direction angles, condition numbers, RMS residuals, and a rotated plot.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [c, V, q1, q2, ub] = XinheWang_centerlinePCA(X1, Y1, X2, Y2)

% Stack both branches into one cloud, one point per row
P1 = [X1(:), Y1(:)];
P2 = [X2(:), Y2(:)];
P  = [P1; P2];

% (1) Principal directions of the full cloud: the centroid c and the
%     dominant eigenvector v1 of the covariance matrix (pcaLine, Listing
%     9.3, with your power method from Lab 7), oriented so that v1(2) > 0,
%     and the perpendicular direction v2 = [-v1(2); v1(1)] as the second
%     axis. Set V = [v1, v2] and print the angle of v1 from the x-axis in
%     degrees. Then check v1 against eig: compute the eigenvectors of the
%     same covariance matrix with eig, take the one with the largest
%     eigenvalue, and print the angle between it and v1 (expect 0 or 180).

[c, v1] = pcaLine(P(:,1), P(:,2));

if v1(2) < 0
    v1 = -v1;
end

v2 = [-v1(2); v1(1)];
V = [v1, v2];

angle = atan2d(v1(2), v1(1));

disp("Angle from the x-axis (degrees):")
disp(angle)

Z = P - c';
C = Z' * Z;

[E, D] = eig(C);
[~, index] = max(diag(D));
vEig = E(:, index);

angleDifference = acosd(max(-1, min(1, v1' * vEig)));

disp("Angle between power method and eig (degrees):")
disp(angleDifference)


% (2) Rotate both branches into the (u1, u2) coordinate system. With one
%     point per row, U = (P - c') * V computes u = V' (p - c) for every
%     point at once.

U1 = (P1 - c') * V;
U2 = (P2 - c') * V;

% (3) Quadratic fit u2 = q(u1) for each branch by least squares (no
%     polyfit). Print cond(A) and the RMS residual for each branch.

A1 = [U1(:,1).^2, U1(:,1), ones(length(X1), 1)];
A2 = [U2(:,1).^2, U2(:,1), ones(length(X2), 1)];

q1 = A1 \ U1(:,2);
q2 = A2 \ U2(:,2);

conditionNumber1 = cond(A1);
conditionNumber2 = cond(A2);

rmsResidual1 = sqrt(mean((U1(:,2) - A1*q1).^2));
rmsResidual2 = sqrt(mean((U2(:,2) - A2*q2).^2));

disp("Branch 1 condition number:")
disp(conditionNumber1)

disp("Branch 1 RMS residual (mm):")
disp(rmsResidual1)

disp("Branch 2 condition number:")
disp(conditionNumber2)

disp("Branch 2 RMS residual (mm):")
disp(rmsResidual2)

% (4) Bifurcation: the two quadratics meet where q2(u1) - q1(u1) = 0, a
%     quadratic equation whose roots "roots" returns. Keep the root
%     nearest the second branch"s data and store it in ub.

r = roots(q2 - q1);
distance = zeros(length(r), 1);

for k = 1:length(r)
    distance(k) = min(abs(U2(:,1) - r(k)));
end

[~, index] = min(distance);
ub = r(index);

% Plot in the rotated frame (no need to change this once U1, U2, q1, q2,
% and ub exist)
figure;
plot(U1(:,1), U1(:,2), "b*", U2(:,1), U2(:,2), "r*", "markersize", 6); hold on;
u = linspace(min(U1(:,1)), max(U1(:,1)), 200);
plot(u, q1(1)*u.^2 + q1(2)*u + q1(3), "b-");
u = linspace(ub, max(U2(:,1)), 200);
plot(u, q2(1)*u.^2 + q2(2)*u + q2(3), "r-");
plot(ub, q1(1)*ub.^2 + q1(2)*ub + q1(3), "k.", "markersize", 20);
axis equal; xlabel("u_1 (mm)"); ylabel("u_2 (mm)");
title("fits in the principal component frame");

end