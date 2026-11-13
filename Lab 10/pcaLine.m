function [p, u, lambda] = pcaLine(X, Y)

p = [mean(X); mean(Y)];
A = [X(:) - p(1), Y(:) - p(2)];
C = A' * A;

[lambda, u] = powerMethod(C, 1e-10);

end
