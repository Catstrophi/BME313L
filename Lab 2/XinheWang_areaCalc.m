function XinheWang_areaCalc(n)

%{
BME313L Lab 2 Problem 2

Enters a random number of points and plots the invisible shape oracle
generates based on its return value

I get the vector of 1 and 0 from oracle. Use a condition statement to turn
it from a logical vector to a double. Then I use that to plot the points
from the total points that were in the shape.

For area, I took the total area and mulitplied by the ratio of my points in
the shape and the total number of points.
%}

% Generates n number of points for a [3,14] and [3,14] box then gets the values from oracle
area_points = ((11 * rand(n, 2)) + 3);
point_in_shape = oracle(area_points);

% Transforms logical vector to double vector
condition = point_in_shape == 1;

% Plots the points of all points in the "shape"
plot(area_points(condition,1), area_points(condition,2), "w*")

% Calculate the area using ratio
area = 121 * (sum(condition) / n);

% Add plot data
title("Estimated Area = " + area)
xlim([3, 14]);
ylim([3, 14]);
axis equal;
grid on;



