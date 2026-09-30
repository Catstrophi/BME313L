load('CTdata40x40.mat')

[L, U, P] = XinheWang_myLUfactorization(A);

x = U \ ( L \ (P*b) );
img = zeros (40,40); img(:) = x;
close all ; imagesc (img); colormap ("gray");
title ("Xinhe Wang: Reconstructed CT Image ");
