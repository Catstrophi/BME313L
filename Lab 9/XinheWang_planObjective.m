%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Xinhe Wang, BME 313L (16500) | Week 9 Problem 1
% File Name: XinheWang_planObjective.m
%
% Description: Computes the radiation plan cost and its gradient
% with respect to the beam strengths.
%
% Explanation:
% The total dose is the sum of strength times unit-strength beam dose.
% Each region contributes its weighted mean squared dose error.
% Since dD/ds(k) = Dk, the gradient contribution from a region is
% 2*weight*mean((D-target).*Dk), using only that region's pixels.
%
% Program Usage Instructions and Example:
% [f, g] = XinheWang_planObjective(s, Dbeam, plan);
%
% Inputs:
% s: Beam strength vector; 
% Dbeam: Unit-strength beam dose array.
% plan: Patient data loaded from coronalPlan.mat.
%
% Outputs:
% f: Total weighted cost; g: Column vector of strength derivatives.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [f, g] = XinheWang_planObjective(s, Dbeam, plan)

    % Identify the tumor and healthy tissue regions
    T = logical(plan.tumor);
    % Exclude tumor pixels from the healthy left lung
    L = logical(plan.lungL) & ~T;
    R = logical(plan.lungR);
    S = logical(plan.spine);
    % Select body pixels outside the named regions
    O = logical(plan.body) & ~(T | L | R | S);

    % Store each region with its penalty weight and target dose
    masks = {T, L, R, S, O};
    weights = [1, 0.3, 0.3, 1, 0.1];
    targets = [1, 0, 0, 0, 0];

    % Initialize the total dose image
    n = length(s);
    D = zeros(size(Dbeam,1), size(Dbeam,2));

    % Add the dose contribution from each beam
    for i = 1:n
        D = D + s(i) * Dbeam(:,:,i);
    end

    % Initialize the cost and one gradient entry per beam
    f = 0;

    g = zeros(n,1);

    % Add the cost and gradient contributions from all five regions
    for i = 1:5

        % Extract the region dose and subtract its target
        mask = masks{i};
        error = D(mask) - targets(i);
        
        % Add the weighted mean squared error
        f = f + weights(i) * mean(error.^2);

        % Differentiate the region cost with respect to each strength
        for j = 1:n
            Dk = Dbeam(:,:,j);
            % The chain rule gives 2*weight*mean(error.*Dk)
            g(j) = g(j) + 2 * weights(i) * mean(error.* Dk(mask));
        end

    end

