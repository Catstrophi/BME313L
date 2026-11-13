%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Xinhe Wang, BME 313L (16500) | Week 10 Problem 3
% File Name: XinheWang_centerlineRecover.m
%
% Description: Maps the fitted carotid centerline and bifurcation
% back into the original image coordinates.
%
% Explanation:
% Each fitted quadratic is sampled in the principal component frame.
% The sampled points are rotated back and the centroid is added
% to recover their original image positions.
%
% Question:
% 1. 
% Verification for Question 1
% disp("V transpose times V:")
% disp(V' * V)
% disp("Difference from the identity matrix:")
% disp(V' * V - eye(2))
%
% V'*V equals the identity matrix. The entries of V'*V - eye(2) are close to zero.
% Therefore, V is orthonormal and its inverse is its transpose.
% The coordinate change can be reversed by matrix multiplication
% without using backslash.
%
% Question 2 is answered in the separate PDF.
%
% Program Usage Instructions and Example:
% XinheWang_centerlineRecover
%
% Inputs:
% Requires carotidCenterline.mat, XinheWang_centerlinePCA.m, pcaLine.m,
% and powerMethod.m.
%
% Outputs:
% Bifurcation coordinates, an orthonormality check, and a plot of the
% recovered centerline over the original data.
% Calling XinheWang_centerlinePCA also produces the principal component plot.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load the data
load("carotidCenterline.mat", "X1", "Y1", "X2", "Y2");

% Fit in the principal component frame
[c, V, q1, q2, ub] = XinheWang_centerlinePCA(X1, Y1, X2, Y2);

% (1) Sample each fitted quadratic in the (u1, u2) frame, one point per
%     row: the first branch over its full u1 data range and the second
%     from the bifurcation ub to the end of its data. Store the sampled
%     curves as C1 and C2 and the bifurcation point as B = [ub, q1(ub)].

U1 = ([X1, Y1] - c') * V;
U2 = ([X2, Y2] - c') * V;

uFit1 = linspace(min(U1(:,1)), max(U1(:,1)), 200)';
vFit1 = q1(1)*uFit1.^2 + q1(2)*uFit1 + q1(3);
C1 = [uFit1, vFit1];

uFit2 = linspace(ub, max(U2(:,1)), 200)';
vFit2 = q2(1)*uFit2.^2 + q2(2)*uFit2 + q2(3);
C2 = [uFit2, vFit2];

vb = q1(1)*ub.^2 + q1(2)*ub + q1(3);
B = [ub, vb];

% (2) Map C1, C2, and B back to image coordinates. For a single point
%     p = c + V u; with one point per row, P = U * V' + c'.

Pfit1 = C1 * V' + c';
Pfit2 = C2 * V' + c';
Bimage = B * V' + c';

% (3) Plot the recovered centerline and the bifurcation over the data in
%     image coordinates, with the bifurcation point (in mm) in the title

figure;
plot(X1, Y1, "b*", X2, Y2, "r*");
hold on;

plot(Pfit1(:,1), Pfit1(:,2), "b-");
plot(Pfit2(:,1), Pfit2(:,2), "r-");
plot(Bimage(1), Bimage(2), "ko");

axis equal;
xlabel("x (mm)");
ylabel("y (mm)");

title("Bifurcation: (" + Bimage(1) + ", " + Bimage(2) + ") mm");