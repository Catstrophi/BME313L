%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Xinhe Wang, BME 313L (16500) | Week 7 Problem 1
% File Name: XinheWang_deflationMethod.m
%
% Description: Computes the k largest magnitude eigenvalues of a symmetric
% matrix using the deflation method and power method.
%
% Explanation:
% The power method finds the dominant eigenpair. The eigenvector is
% normalized, and A = A - eigVal*(eigVec*eigVec.') removes its eigenvalue.
% This process repeats to find the next largest magnitude eigenvalue.
% The power method uses a tolerance of 5e-7 for 6 significant digits.
%
% Program Usage Instructions and Example:
% >> eigVal = XinheWang_deflationMethod(A, 85);
%
% Inputs:
% A: Symmetric square matrix; k: Number of eigenvalues to calculate.
%
% Outputs:
% eig: Vector containing the k largest magnitude eigenvalues.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function eig = XinheWang_deflationMethod(A, k)
    eig = zeros(k, 1);

    % repeats k times for k eigenvalues
    for i = 1:k
        [eigVal, eigVec] = powerMethod(A, 5*10^-7);

        % Normalize everything
        eig(i) = eigVal;
        eigVec = eigVec / norm(eigVec);

        A = A - eigVal * (eigVec * eigVec.');
    end

% Function for powermethod
function [eigVal, eigVec] = powerMethod(A, tol)
    n = length(A);
    eigVec = rand(n, 1);
    eigVal = 0;

    maxIter = 1000000;

    for i = 1:maxIter
        eigVec = A * eigVec;

        eigVec = eigVec / norm(eigVec);

        eigValNew = ((A * eigVec).' * eigVec) /(eigVec.' * eigVec);

        error = abs(eigValNew - eigVal) / abs(eigValNew);

        res = norm(A * eigVec - eigValNew * eigVec);

        eigVal = eigValNew;

        % Stopping criteria checking both to be more precise
        if error < tol && res < tol
            break
        end
    end

