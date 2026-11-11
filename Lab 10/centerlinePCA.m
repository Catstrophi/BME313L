% Need a full header
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Lab 10, Problem 2: fit both branches in the principal component frame
%
% [c, V, q1, q2, ub] = centerlinePCA(X1, Y1, X2, Y2)
%   c  : centroid of the full cloud (2 x 1)
%   V  : [v1 v2], the principal directions as columns (2 x 2, orthonormal)
%   q1, q2 : quadratic coefficients for each branch in the (u1, u2) frame
%   ub : u1-coordinate of the bifurcation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [c, V, q1, q2, ub] = centerlinePCA(X1, Y1, X2, Y2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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



% (2) Rotate both branches into the (u1, u2) coordinate system. With one
%     point per row, U = (P - c') * V computes u = V' (p - c) for every
%     point at once.



% (3) Quadratic fit u2 = q(u1) for each branch by least squares (no
%     polyfit). Print cond(A) and the RMS residual for each branch.



% (4) Bifurcation: the two quadratics meet where q2(u1) - q1(u1) = 0, a
%     quadratic equation whose roots "roots" returns. Keep the root
%     nearest the second branch's data and store it in ub.



% Plot in the rotated frame (no need to change this once U1, U2, q1, q2,
% and ub exist)
figure(2); clf;
plot(U1(:,1), U1(:,2), 'b*', U2(:,1), U2(:,2), 'r*', 'markersize', 6); hold on;
u = linspace(min(U1(:,1)), max(U1(:,1)), 200); plot(u, polyval(q1, u), 'b-');
u = linspace(ub, max(U2(:,1)), 200);           plot(u, polyval(q2, u), 'r-');
plot(ub, polyval(q1, ub), 'k.', 'markersize', 20);
axis equal; xlabel('u_1 (mm)'); ylabel('u_2 (mm)');
title('fits in the principal component frame');
