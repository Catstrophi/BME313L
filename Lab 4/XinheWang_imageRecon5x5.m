%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Xinhe Wang, BME 313L (16500) | Week 4 Problem 2.1 & 2.2
% File Name: XinheWang_imageRecon5x5.m
%
% Description: this function creates a 5x5 image reconstruction. Using data
% from an unknown function, we create a coefficient matrix, A, in order
% to find x from A\b. Then it correctly indexes the 25 x values into the 5x5
% picture arrays and plots it.
%
% Program Usage Instructions and Example:
% >> XinheWang_imageRecon5x5()
%
% Inputs:
% - none
%
% Outputs:
% - none
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function XinheWang_imageRecon5x5


% Problem 2.1 

% Allocate Space for the matrix A (We know the image is 5x5, so there are
% 5*5 = 25 unknowns)
A = zeros(25,25);

% Simulate data from the scanner
[I,J,V,b] = CTdata5x5;

% Determine the number of non-zeros in A
n = length(I);

for k = 1:n
    i = I(k); j = J(k); v = V(k); A(i,j) = v;
end

x = A\b;

% Problem 2.2 

% Create the image P from the recovered solution vector x

% Allocate space for the image
P = zeros(5,5); 

% Look at lab 4 for a figure on how the values in x need to be placed into
% P. Use a double-nested for-loop to fill in the values.
y = 0;

for j = 1:5
    for i = 1:5
        y = y + 1;
        P(i,j) = x(y);
    end
end

% Visualize the recovered image
close all; imagesc(P)

% Add a title
title("Xinhe W. Image Reconstruction")