%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Xinhe Wang, BME 313L (16500) | Week 6 Problem 1.1
% File Name: XinheWang_myJacobi.m
%
% Description: Solves Ax = b using Jacobi iteration.
% Explanation: Each sweep uses only the previous sweep's values. Stops
% when norm(A*x-b)/norm(b) < tol or maxIter is reached.
%
% Program Usage Instructions and Example:
% >> [x, iter, resHist] = XinheWang_myJacobi(A,b,x0,tol,maxIter);
%
% Inputs:
% A: Square matrix; b: RHS column vector; x0: Initial column vector.
% tol: Relative residual tolerance; maxIter: Maximum number of sweeps.
%
% Outputs:
% x: Approximate solution; iter: Sweeps performed; resHist: Relative residual after each sweep.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

    function [x_next, iter, resHist] = XinheWang_myJacobi(A, b, x0, tol, maxIter)
        
        [n, m] = size(A);

        % checks if matrix is square
        if n ~= m
            disp("A must be square")
            return
        end

        x = x0;
        x_next = zeros(n, 1);
        resHist = zeros(maxIter, 1);
        iter = 0;

        % runs until max iterations
        for k = 1:maxIter

            for i = 1:n
                temp = 0;
                
                % calculates the entire row
                for j = 1:n
                    temp = temp + A(i,j) * x(j);
                end

                % calculates the x value
                x_next(i) = (b(i) - (temp - A(i,i)*x(i))) / A(i,i);
            end
            
            % checks residual
            resHist(k) = norm(A * x_next - b) / norm(b);
            iter = k;   

            if resHist(k) < tol
                break
            end
 
            x = x_next;

        end

        resHist = resHist(1:iter);