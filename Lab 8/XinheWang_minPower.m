%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Xinhe Wang, BME 313L (16500) | Week 8 Problem 2
% File Name: XinheWang_minPower.m
%
% Description: Finds the minimum laser power needed to heat every tumor
% node to at least 43 C for beta = 50 and beta = 0.
%
% Explanation:
% The tumor is represented by a rotated ellipse on the grid.
% For each beta, the coldest tumor point determines the minimum power.
% The resulting field is plotted.
%
% Question:
% Beta = 50: The conduction to the edges and blood perfusion remove heat. 
% Beta = 0: Only the conduction to the fixed boundaries remove heat.
% Perfusion removes heat in addition to conduction, reducing the temperature which
% requires more than three times as much power.
%
% Program Usage Instructions and Example:
% XinheWang_minPower
%
% Inputs:
% Requires XinheWang_unitField.m and laplacianMat.m.
%
% Outputs:
% Minimum power and tip temperature for each beta; contour plots of
% the 43 C temperature boundary and tumor outline.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Set laser tip coordinates
tip = [0.55 0.60];

% Compare the two perfusion coefficients
for beta = [50 0]

    % Generate the unit-power field and grid
    [v, D] = XinheWang_unitField(beta, tip);
    [X, Y] = meshgrid(D, D);

    % Rotate the grid to define the elliptical tumor
    x_grid = cosd(35)*(X - 0.55) + sind(35)*(Y - 0.60);
    y_grid = -sind(35)*(X - 0.55) + cosd(35)*(Y - 0.60);

    tumor = (x_grid/0.18).^2 + (y_grid/0.11).^2 <= 1;

    % Find minimum power from the coldest tumor node
    vTumor = v(tumor(:));
    Pmin = 6/min(vTumor);

    % Calculate the temperature field from the minimum power
    n = length(D);
    U = zeros(n, n);
    U(:) = 37 + Pmin*v;

    % Find the tip temperature on the grid
    [~, x] = min(abs(D - tip(1)));
    [~, y] = min(abs(D - tip(2)));

    tipTemp = U(y, x);

    % Display results for each beta
    disp("beta = " + beta)
    disp("Minimum power = " + Pmin)
    disp("Tip temperature = " + tipTemp)

    % Plot the 43 C contour and tumor boundary
    figure
    hold on

    contour(D, D, U, [43 43], "r")
    tumor_outline = (x_grid/0.18).^2 + (y_grid/0.11).^2;
    contour(D, D, tumor_outline, [1 1], "w--")

    hold off

    xlabel("x")
    ylabel("y")


end
