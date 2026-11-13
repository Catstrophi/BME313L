function [lambda, y] = powerMethod(A, tol)

n = size(A, 1);
y = ones(n, 1);
lambda = 0;

maxIter = 100;

for k = 1:maxIter
    y = A*y;
    y = y / norm(y);

    lambdaNew = ((A*y)' * y) / (y' * y);
    err = abs(lambdaNew - lambda) / abs(lambdaNew);

    lambda = lambdaNew;

    if err < tol
        break;
    end
end

end