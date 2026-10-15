%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Xinhe Wang, BME 313L (16500) | Week 6 Problem 3
% File Name: XinheWang_accuracyStudy.m
%
% Description: Compares heat-system iteration counts for tol = 10^(-p),
% p = 2:8, using Jacobi, Gauss-Seidel, and SOR with lambda = 1.750.
% 
% Explanation: 
% 
% Each extra digit costs approximately a fixed number of
% sweeps: 186.000 for Jacobi and 93.000 for Gauss-Seidel. 
%
% Program Usage Instructions and Example:
% >> XinheWang_accuracyStudy
%
% Inputs:
% Requires laplacianMat.m and all three solver functions; uses x0 = b.
%
% Outputs:
% Heat dominance count and iteration-count plot with labeled curves
% and Jacobi/Gauss-Seidel costs per digit in the title.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[A, b, D] = laplacianMat([0 1 0 1]);

x0 = b;
maxIter = 10000;
lambda = 1.75;

p = 2:8;

[n, m] = size(A);

% checks for diagonal dominance
count = 0;
for i = 1:n
    sum = 0;

    for j = 1:m
        if j ~= i
            sum = sum + abs(A(i, j));
        end
    end

    if abs(A(i, i)) > sum
        count = count + 1;
    end
end

disp(count)

jacobiIter = zeros(size(p));
gsIter = zeros(size(p));
sorIter = zeros(size(p));

% runs the function for each p value to calculate different tol
for i = 1:length(p)
    tol = 10^(-p(i));

    [~, jacobiIter(i), ~] = XinheWang_myJacobi(A, b, x0, tol, maxIter);
    [~, gsIter(i), ~] = XinheWang_myGaussSeidel(A, b, x0, tol, maxIter);
    [~, sorIter(i), ~] = XinheWang_mySOR(A, b, x0, tol, maxIter, lambda);

end

% calculates the cost per digit
jacobiCost = (jacobiIter(end) - jacobiIter(1)) / (p(end) - p(1));
gsCost = (gsIter(end) - gsIter(1)) / (p(end) - p(1));
sorCost = (sorIter(end) - sorIter(1)) / (p(end) - p(1));
disp("Cost: " + sorCost)
% plots all three functions
plot(p, jacobiIter, "b-o", p, gsIter, "r-o", p, sorIter, "g-o")

xlabel("Digits of accuracy, p where tol = 10^{-p}")
ylabel("Number of iterations")
legend("Jacobi", "Gauss-Seidel", "SOR (lambda = 1.75)", "Location", "northwest")

title("Xinhe Wang: Jacobi " + jacobiCost + ", Gauss-Seidel " + gsCost + " iterations per digit")
