%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Xinhe Wang, BME 313L (16500) | Week 6 Problem 2
% File Name: XinheWang_jacobiCT.m
%
% Description: Applies Jacobi to the CT system and plots its residual.
%
% Explanation: 
% 
% CT maxtrix has 1 strictly diagonally dominant rows and heat has 72. 
% Theorem 5.1 requires strict dominance in every row, so it guarantees convergence for the heat matrix only.
%
% Lab 5 uses elimination because CT diverges when we use iteration.
%
% Program Usage Instructions and Example:
% >> XinheWang_jacobiCT
%
% Inputs:
% CTdata40x40.mat; requires XinheWang_myJacobi.m.
%
% Outputs:
% CT dominance count and a semilog plot of the relative residual.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[A, b, D] = laplacianMat([0 1 0 1]);
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

load("CTdata40x40.mat");

x0 = b;
tol = 1e-5;
maxIter = 20;

[n, m] = size(A);

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


[x, iter, resHist] = XinheWang_myJacobi(A, b, x0, tol, maxIter);


semilogy(1:iter, resHist(1:iter), "-o")
xlabel("iteration")
ylabel("relative residual")
title("Xinhe Wang: Jacobi on the CT System")