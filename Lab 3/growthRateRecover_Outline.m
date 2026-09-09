% A general outline for how growthRateRecover might look like.
% We only have to code the Newton Iteration for this problem. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function k = growthRateRecover_Outline(c,b,N)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Maximum number of allowed iterations
maxit = 100; 

% Initial guess for k
k = 1; 

% Define the stopping criteria to get 6 significant figures


% For-loop for Newton Iteration
for iter = 1:maxit
    
    % Update iterate 


    % Check for convergence
         
        
end

% The main function is 'growthRateRecover'. Any additional functions defined 
% after the main function are subfunctions. Subfunctions can only be seen/used 
% by the main function. They are typically used to help the main function 
% complete its task. For the lab submission, follow this outline and include 
% bacteriaPop as a subfunction for growthRateRecover.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [y, dy] = bacteriaPop(k,c,b)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
