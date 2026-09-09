%{
This is the scrpit for Problem 1 of Lab 1 for BME313L Fall 2026

The purpose of this problem is to plot a unit circle through for loops.
%}


function XinheWang_unitCircle(n)

% Setting the constant variables based on the question
theta = (2 * pi) / n;
A = [cos(theta) -sin(theta); sin(theta) cos(theta)];

% Plotting the first point
x = [1; 0];
hold on

% Based on the first point we are now rotating/plotting the rest of the points
for i = 1:n
    x = A * x;
    plot(x(1), x(2), 'b*')
end

% Creating the plot and naming it
title('The circle of 128 points');
xlabel("x")
ylabel("y")
hold off;
axis equal