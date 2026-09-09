function val = XinheWang_piApproxVectorized(n)

%{
BME313L Lab 2 Problem 1.1

Finds the value of pi without a for loop

%}

% Sets the seed to be the same for all
rng(0);

% Creates a vector with n rows for n sets of xy points
xy = (2 * rand(n, 2)) - 1;

% Of the vectors, how many of them are within the circle
circle_condition = (xy(:,1) .^ 2) + (xy(:,2) .^ 2) <= 1;

% Since it returns 1 for true, 0 for false, I can sum up the vector
num_of_hits = sum(circle_condition);

% Since pi/4 = area of circle / area of square, pi = 4 * (area of circle / area of square)
val = 4 * (num_of_hits / n);

