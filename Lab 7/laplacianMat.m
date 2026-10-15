%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Edward Castillo, BME 313L
% File Name: laplacianMat.m
%
% Program Description: This program discretizes the Laplacian on the region
% [0 1] x [0 1], using the five-point stencil finite difference approach 
% and user-specfified boundary conditions
%
% Program Usage Instructions: The function is called as follows:
% >> [A,b,D] = laplacianMat(BCs);
%
% Inputs:
%   BCs: Is a 1 x 4 vector with entries [a,b,c,b] representing the boundary 
%        conditions for the system. The solution u satisfies 
%        u(0,y) = a, 0 < y < 1
%        u(1,y) = b, 0 < y < 1
%        u(x,0) = c, 0 < x < 1
%        u(x,1) = d, 0 < x < 1
%
% Outputs:
% 
%   A: Is the coefficient matrix resulting from the finite difference
%      discretization of the Laplacian
%   b: The corresponding right-hand side vector
%   D: The discretization points, they can be used to plot the solution
%      with the matlab function surf
%
% Example usage:
%
% >> [A,b,D] = laplacianMat([0 1 0 1]);
% >> x = A\b; n = length(D); U = zeros(n,n);
% >> U(:) = x; close all; figure(1); surf(D,D,U)
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [A,b,D] = laplacianMat(BCs)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Discretization Spacing
dx = 0.05;

% Discrective the interval [0 1];
X = 0:dx:1; n = length(X);

% Set Index Map for the (n-2)*(n-2) unknown values
IDX = zeros(n,n); count = 0;
for j = 2:n-1
    for i = 2:n-1
        count = count + 1;
        IDX(i,j) = count;
    end
end

% Finite Difference Spacing
dx = dx*dx;

% Initialize the linear system
N = (n-2)^2; A = zeros(N,N); 
b = zeros(N,1); count = 0;

% Build the linear system
for j = 2:n-1
    for i = 2:n-1
    
    % Current Equation Number
    count = count + 1; 

    %%%%% Five Point Stencil: Point 1 %%%%
    idx = IDX(i,j-1); 
    if(idx ~= 0)  % Respect the Boundary Condition
        A(count,idx) = -1/dx;
    else
        b(count) = b(count) + BCs(1)/dx;
    end

    %%%%% Five Point Stencil: Point 2 %%%%
    idx = IDX(i,j+1); 
    if(idx ~= 0)  % Respect the Boundary Condition      
        A(count,idx) = -1/dx;
    else
        b(count) = b(count) + BCs(2)/dx;
    end

    %%%%% Five Point Stencil: Point 3 %%%%
    idx = IDX(i-1,j); 
    if(idx ~= 0)  % Respect the Boundary Condition
        A(count,idx) = -1/dx;
    else
        b(count) = b(count) + BCs(3)/dx;
    end

    %%%%% Five Point Stencil: Point 4 %%%%
    idx = IDX(i+1,j); 
    if(idx ~= 0)   % Respect the Boundary Condition
        A(count,idx) = -1/dx;
    else
        b(count) = b(count) + BCs(4)/dx;
    end

    %%%%% Five Point Stencil: Point 5 %%%%
    idx = IDX(i,j);
    A(idx,idx) = 4/dx;
   
    end
end

% Discretization Vector (for plotting purposes)
D = X(2:end-1);


        


        