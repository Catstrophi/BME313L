
%{

XinheWang_bacteriaPop.m

This is a function file that calculates the y(k) and y'(k) values for a given k, c, and b 
based on the closed form population model of bacteria growth.

The inputs are k, c, and b, where:
- k: growth constant
- c: initial population size
- b: immigration rate (per hour)

The outputs are yk and dyk, where:
- yk: population size after 1 hour
- dyk: derivative of yk evaluated at input k

This is problem 1.1 for BME313L Fall26 lab 3. Later, this will be using in problem 1.2.

%}    

function [yk, dyk] = XinheWang_bacteriaPop(k, c, b)

    yk = c * exp(k) + b/k * (exp(k) - 1);

    dyk = exp(k) * (c + b/k);

end
