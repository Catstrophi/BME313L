function x = myGE(A, b)


[n, m] = size(A);

if (n ~= m)
    disp("Matrix is not square");
    x = [];
    return;
end

% Check length of b
L = length(b);

% Fix this to actually be the augmented matrix

A = [A b]; % Augmented matrix

% Forward elimination
for i  = 1:n    % Loop through each diagonal element
    for j = i+1:n % Eliminate eveyrthing benath row i
        
        % Compute the factor: f = a(j,i)/a(i,i)
        f = A(j,i) / A(i,i);
        A(j,:) = A(j,:) - f * A(i,:); % Update row j
    end
end


disp(A)
x = [];
