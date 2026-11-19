%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Xinhe Wang, BME 313L (16500) | Lab 11 Problem 1
% File Name: XinheWang_lobeVolumes.m
%
% Description:
% Calculates lung lobe volumes at inhale and exhale and compares the
% trapezoid and Simpson rules at different slice spacings.
%
% Explanation:
% Count the voxels for each lobe on each slice and multiply by the pixel
% area. Integrate those slice areas along z using the two quadrature rules.
% Divide each lobe's volume change by the total change to find its share.
%
% Questions:
% 1. The first and last slices contain no lung, so they add zero to the volume. 
% Every other slice is weighted by dz. Each voxel contributes an area of dx^2, 
% so the total volume is the number of voxels times dx^2 dz.
%
% 2. At 25 mm spacing, only three slices pass through the right middle lobe. 
% Simpson’s rule gives extra weight to two of those slices, which makes its estimate too high. 
% Its error formula assumes the slice area changes smoothly. With only three slices, the rapid 
% changes near the edges are easy to miss.
%
% 3. The shares of the total volume change are 0.285 for RUL, 0.102 for RML, 0.140 for RLL, 0.364 for LUL, and 0.107 for LLL. 
% From Question 1, each lobe’s volume is its voxel count times the volume of one voxel. 
% When we divide a lobe’s volume change by the total volume change, the volume of one voxel cancels, 
% leaving a ratio of changes in voxel counts. The trapezoid rule adds up the labeled voxels, 
% so the accuracy depends on how well the voxels capture the lobe boundaries and whether each voxel is assigned to the correct lobe.
%
% Program Usage Instructions and Example:
% Put lungLobes.mat in the MATLAB Current Folder and run:
% XinheWang_lobeVolumes
%
% Inputs:
% lungLobes.mat contains the inhale and exhale lobe masks, pixel spacing dx,
% and slice spacing dz. Both spacings are in millimeters.
%
% Outputs:
% Lobe volumes, volume changes, ventilation shares, and right
% middle lobe volumes at wider slice spacings. The figure shows each
% lobe's cross-sectional area by slice position.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Load the lobe masks (labels 1 RUL, 2 RML, 3 RLL, 4 LUL, 5 LLL) and the
% pixel size dx and slice spacing dz, both in mm
load('lungLobes.mat', 'lobesIn', 'lobesEx', 'dx', 'dz');
names = {'RUL', 'RML', 'RLL', 'LUL', 'LLL'};

nz = size(lobesIn, 3);     % number of slices
n  = nz - 1;               % number of subintervals along z
z  = (0:n) * dz;           % slice positions (mm)

% (1) Cross-sectional areas: fill the 5 x nz matrices Ain and Aex, where
%     Ain(l,k) is the area (mm^2) of lobe l on slice k of the inhale scan
%     and Aex(l,k) is the same for the exhale scan. The area of a mask on
%     one slice is the number of ones multiplied by the pixel area dx^2.

Ain = zeros(5, nz);
Aex = zeros(5, nz);
pixelArea = dx^2;

for l = 1:5
    for k = 1:nz
        Ain(l,k) = nnz(lobesIn(:,:,k) == l) * pixelArea;
        Aex(l,k) = nnz(lobesEx(:,:,k) == l) * pixelArea;
    end
end

% (2) Build the composite trapezoid weight vector wT (1 x nz, spacing dz)
%     and compute the 5 x 1 volume vectors VinT and VexT in mL as weighted
%     sums of the slice areas (1 mL = 1000 mm^3). Check VinT against the
%     voxel count multiplied by the voxel volume, and against trapz.

wT = dz * ones(1, nz);
wT(1) = dz / 2;
wT(nz) = dz / 2;

VinT = zeros(5, 1);
VexT = zeros(5, 1);
voxelCountVolume = zeros(5, 1);
trapzVolume = zeros(5, 1);
voxelVolume = pixelArea * dz;

for l = 1:5
    VinT(l) = sum(Ain(l,:) .* wT) / 1000;
    VexT(l) = sum(Aex(l,:) .* wT) / 1000;

    voxelCountVolume(l) = nnz(lobesIn == l) * voxelVolume / 1000;
    trapzVolume(l) = trapz(z, Ain(l,:)) / 1000;
end

% (3) Build the composite Simpson weight vector wS (1 x nz) and compute
%     the volume vectors VinS and VexS in mL

wS = ones(1, nz);
wS(2:2:nz-1) = 4;
wS(3:2:nz-2) = 2;
wS = wS * dz / 3;

VinS = zeros(5, 1);
VexS = zeros(5, 1);

for l = 1:5
    VinS(l) = sum(Ain(l,:) .* wS) / 1000;
    VexS(l) = sum(Aex(l,:) .* wS) / 1000;
end

inhaleDifference = VinS - VinT;
exhaleDifference = VexS - VexT;

% (4) Compute the change in volume dV = VinT - VexT of each lobe and
%     display each lobe's inhale volume, exhale volume,
%     change, and the share of the total change dV / sum(dV)

dV = VinT - VexT;
totalChange = sum(dV);
share = dV / totalChange;

disp('Volume changes (mL) and ventilation shares');

for l = 1:5
    disp(names{l});
    disp('Inhale');
    disp(VinT(l));
    disp('Exhale');
    disp(VexT(l));
    disp('Change');
    disp(dV(l));
    disp('Share');
    disp(share(l));
end

disp('Total');
disp('Inhale');
disp(sum(VinT));
disp('Exhale');
disp(sum(VexT));
disp('Change');
disp(totalChange);
disp('Share');
disp(sum(share));

% (5) Thicker slices: keep every s-th slice of the inhale areas of the
%     right middle lobe, Ain(2, 1:s:end), for s = 1, 2, 5, 10, and
%     recompute its volume with both rules and the spacing h = s * dz.
%     Print the spacing and the two volumes for each s.

sliceSteps = [1; 2; 5; 10];
spacing = zeros(4, 1);
trapezoidVolume = zeros(4, 1);
simpsonVolume = zeros(4, 1);

for i = 1:4
    s = sliceSteps(i);
    h = s * dz;

    areas = Ain(2, 1:s:end);
    numberOfAreas = length(areas);

    wThickT = h * ones(1, numberOfAreas);
    wThickT(1) = h / 2;
    wThickT(numberOfAreas) = h / 2;

    wThickS = ones(1, numberOfAreas);
    wThickS(2:2:numberOfAreas-1) = 4;
    wThickS(3:2:numberOfAreas-2) = 2;
    wThickS = wThickS * h / 3;

    spacing(i) = h;
    trapezoidVolume(i) = sum(areas .* wThickT) / 1000;
    simpsonVolume(i) = sum(areas .* wThickS) / 1000;
end

disp('Right middle lobe inhale with thicker slices');
for i = 1:numel(sliceSteps)
    disp('Step');
    disp(sliceSteps(i));
    disp('Spacing (mm)');
    disp(spacing(i));
    disp('Trapezoid (mL)');
    disp(trapezoidVolume(i));
    disp('Simpson (mL)');
    disp(simpsonVolume(i));
end

% Plot the area profiles, inhale solid and exhale dashed
close all; figure(1); hold on;
col = lines(5);
for l = 1:5
    plot(z, Ain(l,:) / 100, '-',  'color', col(l,:), 'linewidth', 1.5);
end
for l = 1:5
    plot(z, Aex(l,:) / 100, '--', 'color', col(l,:), 'linewidth', 1.5);
end
legend(names); xlabel('z (mm)'); ylabel('cross-sectional area (cm^2)');
title(sprintf('Xinhe Wang: lobe areas, total change in volume = %.0f mL', sum(dV)));
