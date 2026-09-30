% Need a header
% This code is nearly complete. All that's missing are the subfunctions: 
% 'forwardSub' and 'backSub' 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function movieRecon
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all; 

% Generate the coefficient matrix. It is the same for all right hand
% sides.
A = CTmat5x5; 

% Allocate space to store all the images
Imgs = zeros(5,5,9);

% Calculate LU factorization. P is a permuation matrix, it contains the
% pivots used to maintain numerical stability. Note: We need to solve the 
% same linear system 9 times, but for different right hand side. Instead of 
% applying Gaussian elimination to the same coefficient matrix over and 
% over, it is more efficient to factorize once.
[L,U,P] = lu(A);   % P*A = L*U;

% Loop through 9 time points and reconstruct the corresponding images
for t = 1:9

    % Right-hand side for time t
    b = P*CTrhs_time(t); % The permutation matrix needs to be applied

    % Solve the linear system using forward and backward substitution  
    y = forwardSub(L,b); % This one needs to be written
    x = backSub(U,y); % This one too
   
    % Create an image from the recovered solution vector x
    Img = zeros(5,5); Img(:) = x; Imgs(:,:,t) = Img;

    % Visualize the recovered image
    imagesc(Img); caxis([0 0.5]); colormap('jet');    
    title('Image Reconstruction Movie');
    pause(0.5)
    
end

% Create a figure showing all images
figure(2); 

% Be sure to add a title for you plot with your name included. Use the 
% 'sgtitle'  function
sgtitle('Example of how to use sgtitle')

% Loop through all the images and plot on a single figure
count = 0;
for i = 1:3
    for j = 1:3
        % Try doing a help on subplot if you are interested in how it works
        count = count + 1; subplot(3,3,count);
        imagesc(Imgs(:,:,count)); caxis([0 0.5]); colormap('jet');
    end
end
   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function y = forwardSub(L,b)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% L is lower triangular and b is the right hand side.
% NEED TO WRITE THIS CODE!!!







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Backward substitution code for an upper triangular U and right hand side b.
function x = backSub(U,b)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check dimensions: assume square
n = size(U,1); m = length(b);
if(n~=m),disp('Dimensions do not match'); x = []; return; end

% U is upper triangular and b is the right hand side.
% NEED TO WRITE THIS CODE!!!

