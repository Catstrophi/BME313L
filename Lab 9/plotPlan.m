function plotPlan(D, plan, titleStr)
% PLOTPLAN  Draw a dose map as a color wash over the CT with the contours.
%   plotPlan(D, plan, titleStr) opens a new figure showing the CT in gray, the
%   dose D as a transparent color wash (dose below 0.02 is not drawn), and the
%   tumor (white) and spinal column (orange) contours, with the given title.
ct = double(plan.CT);  ct = (ct - min(ct(:))) / (max(ct(:)) - min(ct(:)));
figure;
image(repmat(ct, [1 1 3]));  axis image off;  hold on;
hD = imagesc(D, [0 1]);
set(hD, 'AlphaData', 0.6 * (D > 0.02));
colormap(jet);
cb = colorbar;  ylabel(cb, 'dose (fraction of prescription)');
contour(double(plan.tumor), [0.5 0.5], 'w', 'LineWidth', 1.2);
contour(double(plan.spine), [0.5 0.5], 'Color', [1 0.6 0], 'LineWidth', 0.8);
if nargin > 2, title(titleStr); end
