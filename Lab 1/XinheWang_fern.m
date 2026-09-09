%{
This is the scrpit for Problem 2 of Lab 1 for BME313L Fall 2026

The purpose of this problem is to plot a fern through further applications
of for loops such as fractals
%}


% Initializing the first point and makes all points on the same plot 
x = [0; 0];
hold on;

% Creates a for loop that runs 3000 times and plots each point
for i = 1:3000

    r = rand;
    
    % If r > 0.15, there is 85% change
    if r > 0.15
        x = [0.85 0.04; -0.04 0.85] * x + [0; 1.6];
    
    % If r > 0.08 but r < 0.15, there is 7% change
    elseif r > 0.08
        x = [0.2 -0.26; 0.23 0.22] * x + [0; 1.6];
    
    % If r > 0.01 but r < 0.8, there is 7% change    
    elseif r > 0.01
        x = [-0.15 0.28; 0.26 0.24] * x + [0; 0.44];
    
    % If r < 0.01, there is 1% change
    else
         x = [0 0;0 0.16] * x;
    
    end
    
    % Once I manipulated the point, I plot it
    plot(x(1), x(2), 'b*')

end

% Custimizing the plot
title('The fern of 3000 points');
xlabel("x")
ylabel("y")
hold off;
