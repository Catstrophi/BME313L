%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Xinhe Wang, BME 313L (16500) | Week 4 Problem 1.1
% File Name: XinheWang_tpnPlanner.m
%
% Description: the function returns x, which represents the volumes of 3 bags
% (each containing three different nutrients) that is required to deliver
% the correct linear combination of the three nutrients. identical to
% XinheWang_tpnPlannerSub.m, except the coefficient matrix A is not independent%
%
% Explanation: the function reports that x = [NaN -Inf Inf]. This is because bag 3 is a linear
% combination of bag 1 and bag 2 (0.5b1 + 0.5b2) which makes the matrix singular/not linearly
% indepedent/determinant is 0. This means you don't have enough equations/info to solve for all 3 values of x.
%
%
% Program Usage Instructions and Example: The function is called as follows:
% >> x = XinheWang_tpnPlannerSub()
%
% Inputs:
% - none
%
% Outputs:
% - x, the vector representing the volumes needed to deliver the correct amount of nutrients
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function XinheWang_tpnPlannerSub
    
A = [100 50 75; 20 50 35; 0 10 5];
B = [125; 50; 55];

x = A\B
disp(A * x)