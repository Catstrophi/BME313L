function stats = planStats(D, plan, label)
% PLANSTATS  Print and return the dose statistics that score a plan.
%   stats = planStats(D, plan, label) prints the minimum, mean, and maximum
%   tumor dose, the maximum spinal column dose, and the mean dose to each lung
%   for the dose map D, labeled with the string label, and returns them in a
%   struct.
T = logical(plan.tumor);
S = logical(plan.spine) & ~T;
L = logical(plan.lungL) & ~T;
R = logical(plan.lungR) & ~T;
stats.tumorMin = min(D(T));  stats.tumorMean = mean(D(T));  stats.tumorMax = max(D(T));
stats.spineMax = max(D(S));
stats.lungLMean = mean(D(L)); stats.lungRMean = mean(D(R));
if nargin < 3, label = 'plan'; end
fprintf('%s\n', label);
fprintf('  tumor dose   min %.3f  mean %.3f  max %.3f\n', stats.tumorMin, stats.tumorMean, stats.tumorMax);
fprintf('  spine max    %.3f\n', stats.spineMax);
fprintf('  lung mean    left %.4f  right %.4f\n', stats.lungLMean, stats.lungRMean);
