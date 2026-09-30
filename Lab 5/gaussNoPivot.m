%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Edward Castillo, BME 313L (Unique ID), HW #5
% File Name: gaussNoPivot.m
%
% Program Description: This programs solve the square, non-singular linear
% system of equations Ax=b using Gaussian Elimination with no pivotings
%
% Program Usage Instructions: The function is called as follows:
% >> x = gaussNoPivot(A,b);
%
% Inputs: 
% A = the NxN coefficient matrix
% b = the Nx1 right-hand side vector
%
% Outputs:
%   x: the solution to the linear system
% 
% Program usage example: 
% >> load CTdata40x40.mat
% >> x = gaussNoPivot(A,b);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function x = gaussNoPivot(A,b)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Size of the system, assume its square and non-singular
N = size(A,1);

% Create an augmented system 
A = [A b];

% Loop through each column, and zero-out the values beneath the diagonal
for i = 1:N-1
   
    % zero out all the values below the diagonal
    for j = i+1:N

        % Zero-out value
        z = A(j,i)/A(i,i);

        % Apply to the jth row
        A(j,:) = A(j,:) - A(i,:)*z;

    end
    
end

% Split back apart
b = A(:,N+1); U = A(:,1:N); 
x = backSub(U,b);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function x = backSub(U,b)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Cut/Paste the code you wrote for movieRecon