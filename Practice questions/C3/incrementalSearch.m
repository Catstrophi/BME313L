function brackets = incrementalSearch(a, b, n)

    x = linspace(a, b, n + 1);

    y = f(x);

    brackets = [];

    for i = 1:n
        if y(i) * y(i+1) < 0
            brackets = [brackets; x(i), x(i+1)];
        end
    end

end

function y = f(x)
    y = 0.15 .* (x - 1) .* (x - 3.2) .* (x - 5.5);
end