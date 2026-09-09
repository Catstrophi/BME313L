%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Edward Castillo, BME 313L 
% File Name: oracle.m
%
% Program Description: This program takes as input and array of values and
% returns a vectors of 1's and zeros. A "1" indicates the point is inside
% the object and a '0' indicates the point is outside the 
% object
%
% Program Usage Instructions: The function is called as follows:
% >> vals = oracle(X);
%
% Inputs:
%   X: a 2D array of numbers. Each row corresponds to a 2D point
%
% Outputs:
%   vals: a vector of 0's and 1's. A '1' indicates the point is within the
%   object
% 
% Program usage example: 
%    >> val = oracle([5 5])
%
%    vals =
%
%    1
%
%
%    >> vals = oracle([5 5; 1.33 2.2])
% 
%    vals =
%
%    1
%    0