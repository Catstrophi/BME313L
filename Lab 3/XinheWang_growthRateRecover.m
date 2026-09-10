%{

XinheWang_growthRateRecover.m

This is a function file that calculates the k value for the closed form population model of bacteria growth.

The inputs are c, b, and N where:
- c: initial population size
- b: immigration rate (per hour)
- N: population size after 1 hour

The outputs are k_value and a graphwhere:
- k_value: recovered growth rate
- graph: plots approximate relative error vs. iteration number


It uses a helper function bacteriaPop to calculate the y(k) and y'(k) values for a given k, c, and b. This is the 
same function done in the previous question

This is problem 1.2 for BME313L Fall26 lab 3. 

%}    

function k_value = XinheWang_growthRateRecover(c, b, N)

    k = 1;
    max_iterations = 100;
    max_error = 1e-6;
    total_iterations = 0;
    errors = zeros(1, max_iterations);

    for i = 1:max_iterations
        
        total_iterations = total_iterations + 1;
        
        [f, df] = bacteriaPop(k, c, b);
        f = f - N;
        k_value = k - f/df;
        
        approx_relative_error = abs((k_value - k)/k_value);
        errors(i) = approx_relative_error;

        if approx_relative_error < max_error
            break;
        end

        k = k_value;

    end

    semilogy(1:total_iterations, errors(1:total_iterations), '-o');
    xlabel('Iteration');
    ylabel('Approximate relative error (fraction)');
    title("Recovered growth rate: " + k_value + " per hour");
end

function [yk, dyk] = bacteriaPop(k, c, b)

    yk = c * exp(k) + b/k * (exp(k) - 1);

    dyk = c * exp(k) + (b/k) * exp(k) - (b/k^2) * (exp(k) - 1);

end





   