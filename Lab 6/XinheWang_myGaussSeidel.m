%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Xinhe Wang, BME 313L (16500) | Week 6 Problem 1.2
% File Name: XinheWang_myGaussSeidel.m
%
% Description: Solves Ax = b using Gauss-Seidel iteration.
% Explanation: Updates x in place, using new values as they become
% available. Stops when the relative residual < tol or maxIter is reached.
%
% Program Usage Instructions and Example:
% >> [x, iter, resHist] = XinheWang_myGaussSeidel(A,b,x0,tol,maxIter);
%
% Inputs:
% A: Square matrix; b: RHS column vector; x0: Initial column vector.
% tol: Relative residual tolerance; maxIter: Maximum number of sweeps.
%
% Outputs:
% x: Approximate solution; iter: Sweeps performed; resHist: Relative residual after each sweep.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function [x, iter, resHist] = XinheWang_myGaussSeidel(A, b, x0, tol, maxIter)
        
        [n, m] = size(A);

        % checks if matrix is square
        if n ~= m
            disp("A must be square")
            return
        end

        x = x0;

        iter = 0;
        resHist = zeros(maxIter, 1);
        
        for k = 1:maxIter
            for i = 1:n
                temp = 0;

                % calculates the entire row
                for j = 1:n
                    temp = temp + A(i,j) * x(j);
                end

                % calculates the next x
                x(i) = (b(i) - (temp - A(i,i)*x(i))) / A(i,i);
            end
            
            % calculate residual
            resHist(k) = norm(A * x - b) / norm(b);
            iter = k;

            if resHist(k) < tol
                break
            end


        end
    
    resHist = resHist(1:iter);