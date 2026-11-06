%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Xinhe Wang, BME 313L (16500) | Week 9 Problem 2
% File Name: XinheWang_planBeams.m
%
% Description: Optimizes beam angles and strengths for two arrangements
% using ten random starts and checks one additional starting point.
%
% Explanation:
% The optimizer varies z = [p; q]. Angles are sides + 40*tanh(p),
% and strengths are q.^2.
% Each arrangement retains its lowest cost from ten random starts.
% A separate eleventh start checks another valley for the first arrangement.
%
% Question:
% 1. Two from the tumor side, one opposite:
% 0.04461, 0.04464, 0.04431, 0.04673, 0.04699,
% 0.04426, 0.04469, 0.04425, 0.04666, 0.04466
%
% All three from the tumor side:
% 0.03838, 0.03775, 0.03753, 0.03753, 0.03753,
% 0.03761, 0.03753, 0.03753, 0.03773, 0.03784
%
% They differ because the optimizer can get stuck in local minima. In additioan the ones from the tumorside will have better
% cost since it has a better tumor coverage and less healthy tissue exposure. 
%
% This shows that having different starting points is important to find the best local minimum.
% We should not trust it completely because the optimizer can get stuck in local minima. Running
% just another start shows a new minimum with a lower cost than the previous ten starts. This shows that
% having different starting points is important to find the best local minimum.
%
% 2. The tumor is in the left lung, so same-side beams reach it through
% shorter paths and avoid much of the right lung and central spinal region.
% The trade-off is greater dose to the healthy left lung, while reducing
% exposure to the right lung and spinal region.
%
% 3. Certain angles can reduce overlap of healthy tissue beam paths while
% maintaining the dose needed for tumor coverage. Furthermore, the allowed range prevents any
% further angular movement, so many of the optimal angles approach 40 degrees
% from their entry side.
%
% Program Usage Instructions and Example:
% XinheWang_planBeams
%
% Inputs:
% Requires coronalPlan.mat, doseEngine.m, XinheWang_planObjective.m,
% planStats.m, and plotPlan.m
%
% Outputs:
% Ten costs per arrangement, best angles and strengths, dose statistics,
% two best-plan plots, and the separate eleventh-start results.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Load patient data and make the random starts reproducible
plan = load('coronalPlan.mat');
rng(0);
nStarts = 10;
% Compare the two specified beam entry arrangements
arrangements = {[0 0 180], 'two from the tumor side, one opposite'; ...
                [0 0 0],   'all three from the tumor side'};

% Optimize each arrangement separately
for a = 1:size(arrangements, 1)
    sides = arrangements{a, 1};
    fprintf('\nArrangement: %s\n', arrangements{a, 2});
    % Store the lowest cost found among the ten starts
    bestF = Inf;
    % Start a new optimization from each random set of p values
    for r = 1:nStarts
        z0 = [2*rand(3,1) - 1; ones(3,1)];      % p in [-1, 1], q = 1
        % Approximate gradients numerically for the six free variables
        opts = optimoptions('fminunc', 'SpecifyObjectiveGradient', false, 'OptimalityTolerance', 1e-8, 'StepTolerance', 1e-10, 'MaxFunctionEvaluations', 5000);
        [z, f] = fminunc(@(z) fullCost(z, sides, plan), z0, opts);
        fprintf('  start %d: f = %.5f\n', r, f);
        % Retain the variables producing the lowest cost so far
        if f < bestF, bestF = f;  zBest = z;  end
    end
    % Convert the best variables into physical beam settings
    [theta, s] = unpack(zBest, sides);
    fprintf('  best: angles = [%.1f %.1f %.1f]  strengths = [%.3f %.3f %.3f]  f = %.5f\n', theta, s, bestF);
    % Report and plot the best plan from the ten starts
    D = doseEngine(theta, s, plan);
    planStats(D, plan, arrangements{a, 2});
    plotPlan(D, plan, sprintf('Xinhe Wang: %s, f = %.4f', arrangements{a, 2}, bestF));
end

% Test a separate eleventh start near the suggested deeper valley
sidesExtra = [0; 0; 180];
theta0 = [-35; 34; 177];
% Invert the angle mapping and use q = 1 for unit starting strengths
z0Extra = [atanh((theta0-sidesExtra)/40); ones(3,1)];

[zExtra, fExtra] = fminunc(@(z) fullCost(z, sidesExtra, plan), z0Extra, opts);
[thetaExtra, sExtra] = unpack(zExtra, sidesExtra);

disp('Extra-start angles:'); disp(thetaExtra);
disp('Extra-start strengths:'); disp(sExtra);
disp('Extra-start cost:'); disp(fExtra);

% ---- (2) the parameterization and the cost ----
function [theta, s] = unpack(z, sides)
    % The first three variables control angles; the last three control strengths
    p = z(1:3);
    q = z(4:6);
    % Keep angles within 40 degrees of the entry side
    theta = sides(:) + 40*tanh(p);
    % Squaring keeps every strength nonnegative
    s = q.^2;
end

% Evaluate the total cost for a proposed set of six variables
function f = fullCost(z, sides, plan)
    [theta, s] = unpack(z, sides);
    % Recalculate beam patterns because the angles can change
    [~, Dbeam] = doseEngine(theta, s, plan);
    % Reuse the cost; its strength gradient is not the gradient with respect to z
    [f, ~] = XinheWang_planObjective(s, Dbeam, plan);
end
