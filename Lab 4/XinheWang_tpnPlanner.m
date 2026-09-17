%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Xinhe Wang, BME 313L (16500) | Week 4 Problem 1.1
% File Name: XinheWang_tpnPlanner.m
%
% Description: the function returns x, which represents the volumes of 3 bags
% (each containing three different nutrients) that is required to deliver
% the correct linear combination of the three nutrients.
%
%
% Program Usage Instructions and Example: The function is called as follows:
% >> x = XinheWang_tpnPlanner()
%
% Inputs:
% - none
%
% Outputs:
% - x, the vector representing the volumes needed to deliver the correct amount of nutrients
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function XinheWang_tpnPlanner

A = [100 50 0; 20 50 10; 0 10 100];
B = [125; 50; 55];

x = A\B
disp(A * x)