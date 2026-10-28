%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Xinhe Wang, BME 313L (16500) | Week 8 Problem 3
% File Name: XinheWang_planTwoFiber.m
%
% Description: Finds the best pair of laser tips inside the tumor
% and compares two-fiber heating against a single fiber.
%
% Explanation:
% Each tumor grid point is tested as a possible laser tip.
% Every pair of distinct tips is evaluated with equal power per fiber.
% The pair requiring the least total power is selected, and healthy
% tissue nodes reaching 43 C are counted for both treatment plans.
%
% Question:
%                              Two fibers      One fiber
% Total laser power:              88.699          107.939
% Peak tissue temperature (C):    59.173           83.982
% Healthy nodes at >= 43 C:        3               12
%
% Two fibers distribute heat better across the elongated tumor. Their combined
% fields reach the more distant tumor points without the large hot spot
% created by one centered tip. Therefore, the best two-fiber plan needs
% less total power, has a lower peak temperature, and heats fewer healthy
% tissue nodes to 43 C. 
%
% Program Usage Instructions and Example:
% XinheWang_planTwoFiber
%
% Inputs:
% Requires XinheWang_unitField.m and laplacianMat.m; beta = 50.
%
% Outputs:
% Minimum total two-fiber power, peak temperature, number of healthy nodes
% heated to at least 43 C, and the corresponding single-fiber results.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Set the perfusion coefficient and single-fiber tip
beta = 50;
tip = [0.55 0.60];

% Generate the single-fiber field and grid
[vSingle, D] = XinheWang_unitField(beta, tip);
n = length(D);

% Identify the rotated elliptical tumor nodes
[X, Y] = meshgrid(D, D);

xbar = cosd(35)*(X - 0.55) + sind(35)*(Y - 0.60);
ybar = -sind(35)*(X - 0.55) + cosd(35)*(Y - 0.60);

tumor = (xbar/0.18).^2 + (ybar/0.11).^2 <= 1;

% Store tumor nodes as a vector
tumorPoints = tumor(:);
% Find the indices of all tumor nodes
tumor_index = find(tumorPoints);

% Store a unit-power field for each possible laser tip
tipV = zeros(n*n, length(tumor_index));
tips = zeros(length(tumor_index), 2);

% Compute the unit-power field at each tumor grid point
for i = 1:length(tumor_index)
    [v, D] = XinheWang_unitField(beta, [X(tumor_index(i)) Y(tumor_index(i))]);
    tipV(:,i) = v;
    tips(i, :) = [X(tumor_index(i)), Y(tumor_index(i))];
end
    
% Generate all pairs of distinct laser tip positions
cTip = nchoosek(1:length(tumor_index), 2);
pComp = zeros(size(cTip, 1), 1);

% Calculate the total power required for each pair
for i = 1:size(cTip, 1)

    a = cTip(i, 1);
    b = cTip(i, 2);

    % Combine both unit-power fields
    combined = tipV(:, a) + tipV(:, b);

    vTumor = combined(tumorPoints);

    % Determine per-fiber power from the coldest tumor node
    P = 6/min(vTumor);

    pComp(i) = 2*P;

end

% Select the pair with the lowest total power
[lowestPower, lowestIndex] = min(pComp);

a = cTip(lowestIndex, 1);
b = cTip(lowestIndex, 2);

% Store the two best tip coordinates
bestTip1 = tips(a, :);
bestTip2 = tips(b, :);

% Calculate peak temperature and heated healthy nodes for two fibers
tissueTemps = 37 + (lowestPower/2) * (tipV(:, a) + tipV(:, b));
peakTemp = max(tissueTemps);
healthyTissue = sum(tissueTemps(~tumorPoints) >= 43);

% Calculate the same measurements for one fiber
powerSingle = 6/min(vSingle(tumorPoints));
tissueTempSingle = 37 + powerSingle*vSingle;
peakTempSingle = max(tissueTempSingle);
healthyTissueSingle = sum(tissueTempSingle(~tumorPoints) >= 43);

% Display the two-fiber and single-fiber results
disp("Two-fiber total power = " + lowestPower)
disp("Two-fiber peak temperature = " + peakTemp)
disp("Two-fiber healthy nodes = " + healthyTissue)

disp("Single-fiber total power = " + powerSingle)
disp("Single-fiber peak temperature = " + peakTempSingle)
disp("Single-fiber healthy nodes = " + healthyTissueSingle)
