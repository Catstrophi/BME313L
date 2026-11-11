% Need a full header
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Lab 10, Problem 3: map the fits back to image coordinates and plot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Load the data
load('carotidCenterline.mat', 'X1', 'Y1', 'X2', 'Y2');

% Fit in the principal component frame
[c, V, q1, q2, ub] = centerlinePCA(X1, Y1, X2, Y2);

% (1) Sample each fitted quadratic in the (u1, u2) frame, one point per
%     row: the first branch over its full u1 data range and the second
%     from the bifurcation ub to the end of its data. Store the sampled
%     curves as C1 and C2 and the bifurcation point as B = [ub, q1(ub)].



% (2) Map C1, C2, and B back to image coordinates. For a single point
%     p = c + V u; with one point per row, P = U * V' + c'.



% (3) Plot the recovered centerline and the bifurcation over the data in
%     image coordinates, with the bifurcation point (in mm) in the title



