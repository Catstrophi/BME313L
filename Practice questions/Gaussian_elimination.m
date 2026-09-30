function A = Gaussian_elimination(A)
    
    for m = 1:length(A)-1
        A = Pivot(m, A);
        for n = m+1:length(A)
            c = A(n,m) / A(m,m);
            A(n,:) = A(n,:) - (c * A(m,:));
        end
    end

end

function A = Pivot(x, A)

    largest_value = 0;
    pivot = 0;

    for i = x : length(A)
        if abs(A(i, x)) > largest_value
            largest_value = A(i, x);
            pivot = i;
        end
    end

    temp = A(x, :);
    A(x, :) = A(pivot, :);
    A(pivot, :) = temp;

end