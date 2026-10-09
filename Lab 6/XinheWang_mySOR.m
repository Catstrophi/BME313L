%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Xinhe Wang, BME 313L (16500) | Week 6 Problem 1.3
% File Name: XinheWang_mySOR.m
%
% Description: Solves Ax = b using successive over-relaxation.
%
% Explanation: 
% gs_value = (b(i) - (temp - A(i,i)*x(i))) / A(i,i);
% x(i) = x(i) + lambda * (gs_value - x(i));
%
% Program Usage Instructions and Example:
% >> [x, iter, resHist] = XinheWang_mySOR(A,b,x0,tol,maxIter,lambda);
%
% Inputs:
% A: Square matrix; b: RHS column vector; x0: Initial column vector.
% tol: Residual tolerance; maxIter: Sweep limit; lambda: Relaxation factor.
%
% Outputs:
% x: Approximate solution; iter: Sweeps performed; resHist: Relative residual after each sweep.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function [x, iter, resHist] = XinheWang_mySOR(A, b, x0, tol, maxIter, lambda)
        
        [n, m] = size(A);

        % checks if matrix is square
        if n ~= m
            disp("A must be square")
            return
        end

        x = x0;
        iter = 0;
        resHist = zeros(maxIter, 1);

        % runs until max iter
        for k = 1:maxIter
            for i = 1:n
                temp = 0;

                % calculates entire row
                for j = 1:n
                    temp = temp + A(i,j) * x(j);
                end
                
                % calculates new x
                gs_value = (b(i) - (temp - A(i,i)*x(i))) / A(i,i);
                x(i) = x(i) + lambda * (gs_value - x(i));
            end

            % calculates residual
            iter = k;
            resHist(k) = norm(A * x - b) / norm(b);

            if resHist(k) < tol
                break
            end

        end

    resHist = resHist(1:iter);
