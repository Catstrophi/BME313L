%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Xinhe Wang, BME 313L (16500) | Week 7 Problem 1
% File Name: XinheWang_deflationTest.m
%
% Description: Tests the deflation method by calculating the 85 largest
% magnitude eigenvalues and comparing them with MATLAB's eig function.
%
% Explanation:
% Both sets of eigenvalues are compared in descending magnitude order.
% Relative error = abs(estimated - true) / abs(true).
% A semilogy plot displays the relative error for all 85 eigenvalues.
%
% Program Usage Instructions and Example:
% >> XinheWang_deflationTest(k)
%
% Inputs:
% Requires testMat.mat and XinheWang_deflationMethod.m.
%
% Outputs:
% Semilogy plot of relative error for the 85 eigenvalues.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function XinheWang_deflationTest(k)
    % Loads in the test matrix
    load("testMat.mat")

    % Calculates the first k eigenvalues
    eigVal = XinheWang_deflationMethod(A, k);

    trueEigVal = eig(A);

    % Sorts the eigenvalues by magnitude but still preserves the sign
    [~, idx] = sort(abs(trueEigVal), 'descend');
    trueEigVal = trueEigVal(idx);
    trueEigVal = trueEigVal(1:k);

    n = length(eigVal);

    xVal = zeros(n,1);
    yVal = zeros(n,1);

    % Compares the difference
    for i = 1:n
        xVal(i) = i;
        yVal(i) = abs(eigVal(i) - trueEigVal(i)) / abs(trueEigVal(i));
    end

    % Plots the difference
    semilogy(xVal, yVal)
    xlabel('Eigenvalue Index (descending magnitude)')
    ylabel('Relative Error')
    title("Deflation versus eig: " + k + " eigenvalues")

