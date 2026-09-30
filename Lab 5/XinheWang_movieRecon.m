%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Xinhe Wang, BME 313L (16500) | Week 5 Problem 3
% File Name: XinheWang_movieRecon.m
%
% Description: Created upon starter code given. Coded forward and back substituiton to solve lower and upper matrix.
%
% Explanation: You first solve Ly = b, then you have y so you solve Ux = y. It is essentially a two step problem.
%
%
% Program Usage Instructions and Example: The function is called as follows:
% >> you can just run the function
%
% Inputs:
% - none
%
% Outputs:
% - all the movie frames
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function XinheWang_movieRecon

    A = CTmat5x5; 
    Imgs = zeros(5,5,9);

    % Uses my own function coded in problem 1
    [L,U,P] = XinheWang_myLUfactorization(A);  

    for t = 1:9
        b = P*CTrhs_time(t); 

        y = forwardSub(L,b);
        x = backSub(U,y); 
   
        Img = zeros(5,5); Img(:) = x; Imgs(:,:,t) = Img;

        imagesc(Img); caxis([0 0.5]); colormap('jet');    
        title('Image Reconstruction Movie');
        pause(0.5)
    
end

figure(2); 

% Created my own title for all figures
sgtitle('Xinhe Wang Movie Recon')

count = 0;
for i = 1:3
    for j = 1:3
        count = count + 1; subplot(3,3,count);
        imagesc(Imgs(:,:,count)); caxis([0 0.5]); colormap('jet');
    end
end
   


function y = forwardSub(L,b)

    % Pre allocate all the data
    n = length(b);
    y = zeros(n, 1);

    % Starts from the top and moves to the bottom
    for i = 1:n
        val = 0;
        
        % Plugs in all the previous values to calculate the total sum
        for j = 1:i
            val = val + L(i, j) * y(j);
        end

        % Subtracts it from b and finds the y
        y(i) = (b(i) - val) / L(i,i);
    end



function x = backSub(U,b)

    % Same as forwardsub but reversed
    n = length(b);
    x = zeros(n, 1);

    % Instead of starting at the top, we start at the bottom
    for i = n-1:-1:1

        val = 0;
        for j = i+1:n
            val = val + U(i, j) * x(j);
        end

        x(i) = (b(i) - val) / U(i,i);
    end



