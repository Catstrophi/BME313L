A = [4 -1 1;
     -2 6 1;
      -1 1 7];

b = [1;
     9;
     -6];

x0 = [0;
      0;
      0];

[n, m] = size(A);

count = 0;

for i = 1:n
    sum = 0;

    for j = 1:m
        if j ~= i
            sum = sum + abs(A(i, j));
        end
    end

    if abs(A(i, i)) > sum
        count = count + 1;
    end
end

disp(count)

tol = 1e-5;
maxIter = 20;
lambda = 1.5;

[x, iter, ~] = XinheWang_myJacobi(A, b, x0, tol, maxIter)
[x, iter, ~]  = XinheWang_myGaussSeidel(A, b, x0, tol, maxIter)
[x, iter, ~]  = XinheWang_mySOR(A, b, x0, tol, maxIter, lambda)
[x, iter, ~]  = XinheWang_mySOR(A, b, x0, tol, maxIter, 1)
