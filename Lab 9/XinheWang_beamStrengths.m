%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Xinhe Wang, BME 313L (16500) | Week 9 Problem 1
% File Name: XinheWang_beamStrengths.m
%
% Description: Optimizes three radiation beam strengths at fixed angles
% and compares fminunc with a direct linear solve.
%
% Explanation:
% The analytic gradient is checked against centered finite differences.
% fminunc then minimizes the cost using the supplied gradient.
% The constant Hessian A and gradient at zero b give g(s) = A*s+b.
% Solving A*s = -b provides an independent calculation of the minimum.
%
% Question:
% 1. Since dD/ds(k) = Dk, the chain rule gives
% d((D-1)^2)/ds(k) = 2*(D-1)*Dk.
% For healthy tissue, d(D^2)/ds(k) = 2*D*Dk.
% Averaging each region and applying its weight gives the stated gradient. 
% Chain rule: s(k) -> D -> D-1 -> (D-1)^2.
%
% 2. The cost is quadratic and its Hessian is positive definite for
% these beam patterns, so both methods find the same unique minimum.
% With g(s) = A*s+b, one full Newton step gives
% sNew = s - A\(A*s+b) = A\(-b) in exact arithmetic.
%
% 3. The opposite-side beam travels through more healthy tissue before
% reaching the tumor. Attenuation reduces its tumor dose, while its path
% exposes the opposite lung and central tissues. The cost therefore favors
% a weaker opposite-side beam and stronger beams from the tumor side.
%
% Program Usage Instructions and Example:
% XinheWang_beamStrengths
%
% Inputs:
% Requires coronalPlan.mat, doseEngine.m, XinheWang_planObjective.m,
% planStats.m, plotPlan.m, and Optimization Toolbox.
%
% Outputs:
% Analytic and finite difference gradients, optimal strengths and costs,
% dose statistics, and the optimal dose plot.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Load the patient data and generate the fixed-angle beam patterns
plan = load('coronalPlan.mat');
theta = [30, -30, 180];                 % fixed beam angles (degrees)
[~, Dbeam] = doseEngine(theta, [1 1 1], plan);

% ---- (1) check your gradient against a finite difference at s0 ----
s0 = [0.7; 0.8; 0.4];
[f0, g0] = XinheWang_planObjective(s0, Dbeam, plan);

h = 1e-6;
gfd = zeros(3,1);

for i = 1:3

    % Change one strength at a time while holding the others fixed
    e = zeros(3,1);
    e(i) = h;

    % Evaluate the cost on either side of the test strength
    [f02, ~] = XinheWang_planObjective(s0+e, Dbeam, plan);
    [f01, ~] = XinheWang_planObjective(s0-e, Dbeam, plan);

    % Approximate the partial derivative using the centered difference
    gfd(i) = (f02 - f01) / (2 * h);

end

disp('analytic gradient and finite difference at s0:');  disp([g0, gfd]);

% ---- (2) minimize the cost with fminunc, supplying your gradient ----
opts =  optimoptions('fminunc', 'SpecifyObjectiveGradient', true);
[s, f] = fminunc(@(s) XinheWang_planObjective(s, Dbeam, plan), [1; 1; 1], opts);
fprintf('fminunc:          s = [%.4f %.4f %.4f]   f = %.5f\n', s, f);

% ---- (3) solve the same quadratic directly ----
% The gradient of a quadratic is linear in s, g(s) = A*s + b, which means that
% g(s) = 0 is a 3 x 3 linear system. Build A and b, then solve A*s = -b with
% backslash. (Compare Exercise 8.6: this is one Newton step on a quadratic.)
% The gradient at zero strengths is the constant vector b
[~, b] = XinheWang_planObjective(zeros(3,1), Dbeam, plan);
% Allocate the constant Hessian
A = zeros(3);
for k = 1:3

    % A unit coordinate vector selects one column of A
    e = zeros(3, 1);
    e(k) = 1;

    [~, gk] = XinheWang_planObjective(e, Dbeam, plan);

    % Remove b from g(e) = A*e + b to recover that column
    A(:,k) = gk - b;
    
end
% Set the gradient to zero and solve for the optimal strengths
sNE = A \ (-b);
fprintf('direct solve:     s = [%.4f %.4f %.4f]   f = %.5f\n', sNE, XinheWang_planObjective(sNE, Dbeam, plan));

% ---- report ----
D = doseEngine(theta, s, plan);
planStats(D, plan, 'Problem 1: fixed angles (30, -30, 180)');
plotPlan(D, plan, sprintf('Xinhe Wang: fixed angles, s = (%.2f, %.2f, %.2f)', s));
