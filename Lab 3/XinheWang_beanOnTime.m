%{

XinheWang_beanOnTime.m

This is a function file that calculates the t value for the beam on time.

We use Secant method to find the root of the function positionEval(t) = 0, 
where positionEval(t) is a function that calculates the position of the bean at time t.

The outputs are t and a graphwhere:
- t: time value where position
- graph: plots approximate relative error vs. iteration number

This is problem 2 for BME313L Fall26 lab 3. 

%}    


function t1 = XinheWang_beanOnTime()

    t = 0.5;
    h = 0.00001;
    max_error = 1e-6;
    max_iterations = 1000;
    errors = zeros(1, max_iterations);
    total_iterations = 0;

    for i = 1:max_iterations
        total_iterations = total_iterations + 1;
        f = positionEval(t);
        df = (positionEval(t + h) - f) / h;

        t1 = t - f/df;
        approx_relative_error = abs((t1 - t)/t1);
        errors(i) = approx_relative_error;

        if approx_relative_error < max_error
            break;
        end

        t = t1;
    end

    semilogy(1:total_iterations, errors(1:total_iterations), '-o');
    xlabel('Iteration');
    ylabel('Approximate relative error');
    title("Recovered beam-on time: " + t1);

end