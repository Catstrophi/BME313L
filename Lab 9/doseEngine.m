function [D, Dbeam] = doseEngine(theta, s, plan)
% DOSEENGINE  Dose from lateral photon beams aimed at the tumor on a 2-D CT slice.
%
%   [D, Dbeam] = doseEngine(theta, s, plan)
%
%   theta : vector of beam entry angles in DEGREES. theta = 0 enters from the
%           patient's left (the right side of the image) and theta = 180 enters
%           from the patient's right. Positive angles tilt the entry point toward
%           the head. Every beam is aimed at the isocenter, the tumor centroid.
%   s     : vector of beam strengths, one per beam. A strength of 1 delivers one
%           unit of dose at the body surface on the beam's central axis.
%   plan  : the struct loaded from coronalPlan.mat with fields CT, body, lungL,
%           lungR, tumor, spine (logical masks on the grid) and h (grid spacing, mm).
%
%   D     : the total dose on the grid, in units of the prescription dose.
%   Dbeam : an H x W x n array holding the dose from each beam at UNIT strength,
%           so that D = sum_i s(i) * Dbeam(:,:,i). The dose is linear in s.
%
%   Model: each beam has a flat profile of width w = (tumor diameter + 8 mm) with
%   a 3 mm penumbra, and attenuates as exp(-mu d) with mu = 0.005 per mm (6 MV
%   photons in water), where d is the depth below the body surface measured
%   along the beam's central axis. Dose is deposited only inside the body.

mu  = 0.005;        % attenuation, per mm
pen = 3.0;          % penumbra width, mm
h   = plan.h;
body = logical(plan.body);
tumor = logical(plan.tumor);
[H, W] = size(body);
[J, I] = meshgrid(1:W, 1:H);
X = (J - 1) * h;  Y = (I - 1) * h;              % mm, y increases down the image
[ti, tj] = find(tumor);
c = [mean(tj) - 1, mean(ti) - 1] * h;            % isocenter (x, y) in mm
wid = 2 * sqrt(sum(tumor(:)) * h^2 / pi) + 8;    % beam width, mm
n = numel(theta);
Dbeam = zeros(H, W, n);
ts = (-300:1:300)';                              % march along the central axis, mm
for k = 1:n
    th = theta(k) * pi / 180;
    u = [cos(th), -sin(th)];                     % entry side, as a unit vector from the isocenter
    dx = X - c(1);  dy = Y - c(2);
    t = -(dx * u(1) + dy * u(2));                % distance downstream of the isocenter
    p = dx * (-u(2)) + dy * u(1);                % perpendicular offset from the axis
    prof = 0.5 * (1 + tanh((wid/2 - abs(p)) / pen));
    % depth: find where the central axis first enters the body
    px = c(1) - ts * u(1);  py = c(2) - ts * u(2);
    ii = min(max(round(py / h) + 1, 1), H);
    jj = min(max(round(px / h) + 1, 1), W);
    inb = body(sub2ind([H, W], ii, jj));
    kk = find(inb, 1, 'first');
    if isempty(kk), tentry = -300; else, tentry = ts(kk); end
    depth = max(t - tentry, 0);
    Dbeam(:, :, k) = prof .* exp(-mu * depth) .* body;
end
D = zeros(H, W);
for k = 1:n
    D = D + s(k) * Dbeam(:, :, k);
end
