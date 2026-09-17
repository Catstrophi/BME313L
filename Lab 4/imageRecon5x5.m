% Header?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function imageRecon5x5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Problem 2.1 %%%

% Allocate Space for the matrix A (We know the image is 5x5, so there are
% 5*5 = 25 unknowns)
A = zeros(25,25);

% Simulate data from the scanner
[I,J,V,b] = CTdata5x5;

% Determine the number of non-zeros in A
n = length(I);


% Use the I,J,V values to fill in the nonzeros of A. Here's an example of 
% how to place the first value:
% i = I(1); j = J(1); v = V(1); A(i,j) = v;
% Use a for-loop to generalize this command and place all the nonzeros in
% the correct locations.


% Solve the linear system Ax = b, using Matlab's backslash



%%% Problem 2.2 %%%

% Create the image P from the recovered solution vector x

% Allocate space for the image
P = zeros(5,5); 

% Look at lab 4 for a figure on how the values in x need to be placed into
% P. Use a double-nested for-loop to fill in the values.


% Visualize the recovered image
close all; imagesc(P)


% Add a title