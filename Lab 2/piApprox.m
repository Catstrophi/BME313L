%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Edward Castillo, BME 313L (Unique ID), HW #N
% File Name: piApprox.m
%
% Program Description: This program approximates the value of pi using
% geometry and random numbers
%
% Program Usage Instructions: The function is called as follows:
% >> val = piApprox(n);
%
% Inputs:
%   n: is the number of drawn random points used to approximate pi. n is
%   expected to be a positive integer.
%
% Outputs:
%   val: is the computed approximation for pi 
% 
% Program usage example: 
%    >> val = piApprox(1000);
%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function val = piApprox(n)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize the counter keeping track of the number of points that land in
% the circle
hits = 0;

% Set the for-loop to iterate n times
for i = 1:n
    
    % Draw a random point (1-by-2 vector) from within the sqaure
    % centered on the origin with sides of length 2

    xy = 2*rand(1,2) - 1; % Multiplying by 2 scales the interval to [0 2], 
                          % subtracting by 1 shifts the interval to [-1 1];

    % Check to see if the point landed in the unit circle
    if( xy(1)^2 + xy(2)^2 <= 1 )

        % Its a hit, update the counter
        hits = hits + 1;

    end

end

% Compute the approximation for pi. The probability of a point landing in
% the circle is given by the ratio of the circle area and the
% circumscribing square area: pi/4
% Our 'hit-or-miss' method approximates this probability as hits/n.
% Therefore, our approximation for pi is given as:
val = (hits/n)*4;



