%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Xinhe Wang, BME 313L (16500) | Week 5 Problem 1
% File Name: XinheWang_myLUfactorization.m
%
% Description: Inputs a matrix A. The function will split that matrix into L (Lower triangle), U (Upper triangle), and P (Permutation Matrix).
%
% Explanation: It first iterates through the matrix A and performs gauss with pivot to create the matrix U. L is created by taking the factors 
% used in U indexed by the two rows. P is an identity matrix and is used to track all the pivoting happening. All three will be passed though
% the pivoting function so their rows will be swapped accordingly
%
% Program Usage Instructions and Example: The function is called as follows:
% >> load('CTdata40x40.mat')
%    [L, U, P] = XinheWang_myLUfactorization(A);
%    x = U \ ( L \ (P*b) );
%    img = zeros (40,40); img(:) = x;
%    close all ; imagesc (img); colormap ("gray");
%    title ("Xinhe Wang: Reconstructed CT Image ");
%
% Inputs:
% - A (matrix)
%
% Outputs:
% - L (Lower triangle), U (Upper triangle), and P (Permutation Matrix)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [L, U, P] = XinheWang_myLUfactorization(A)

    % Creates the identity matrix for L and P with the size of A
    L = eye(length(A));
    P = eye(length(A));

    % Preserve A, and assign to U since we want U to be the upper triangle
    U = A;

    % Code for a gaussian with pivot
    for m = 1:length(U)-1

        % Pivot the U, L, and P and not just U
        [U, L, P] = Pivot(m, U, L, P);

        % L holds the factos we used to created U so add accordingly
        for n = m+1:length(U)
            c = U(n,m) / U(m,m);
            U(n,:) = U(n,:) - (c * U(m,:));
            L(n,m) = c;
        end

    end
end

% Function for pivoting
function [A, L, P] = Pivot(x, A, L, P)

    % Default values
    largest_value = 0;
    pivot = x;

    % Iterates though to find the max pivot and value
    for i = x : length(A)
        if abs(A(i, x)) > largest_value
            largest_value = abs(A(i, x));
            pivot = i;
        end
    end

    % Swaps the rows
    temp = A(x, :);
    A(x, :) = A(pivot, :);
    A(pivot, :) = temp;

    % I dont swap the rows but the values of L stored
    temp = L(x, 1:x-1);
    L(x, 1:x-1) = L(pivot, 1:x-1);
    L(pivot, 1:x-1) = temp;

    % Swap the rows
    temp = P(x, :);
    P(x, :) = P(pivot, :);
    P(pivot, :) = temp;

end