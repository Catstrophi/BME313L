function XinheWang_piApproxError()

%{
BME313L Lab 2 Problem 1.2

Our accuracy increases with the increase of points. The  relative error decreases in proportion to 1/sqrt(n)
Calculates the relative error of our pi calculation without a for loop
%}

% Sets the seed to be the same for all
rng(0);

% Pre set the values of the vectors to allocate space
n_value = zeros(1, 6);
pi_error = zeros(1, 6);

% Runs six times
for i = 1:6

    % Creats the values for 10, 100, .... 10^6
    n_value(i) = 10^i;

    % Gets my pi approx from from function
    temp_pi = XinheWang_piApproxVectorized(n_value(i));

    % Calculates relative error
    pi_error(i) = abs(pi - temp_pi) / pi;

end

% Plots the n value and relative error in a log graph
loglog(n_value, pi_error, 'w-')

% Adds title and labels to axis
title("Relative Error of Monte Carlo Pi Approximation")
xlabel("Number of points, n")
ylabel("Relative error")