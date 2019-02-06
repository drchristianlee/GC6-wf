% Use this script to analyze calcium signals and movement data that is
% acquired from facemap. Click on a directory containing a Ca.mat file and
% a res_roi(number of roi) file.

clear

[folder] = uigetdir
cd(folder)
files = dir('*.mat')
for loader = 1:size(files, 1);
    load(files(loader, 1).name)
end

correction_val = 3.3333;
[p,q] = rat(correction_val);
trial_res = zeros(30, 1);
result = zeros(30, 100);

for mov_roi = 1:3;
    for trial = 1:size(Mo.Ch0, 2);
        mov_extractor = Mo.Ch0{mov_roi, trial};
        mov_resampler = resample(mov_extractor, p, q);
        mov = mov_resampler(1, 1:1023);
        mov = abs(mov);
        %mov = smooth(mov); %comment this line to not use smoothing
        for roi = 1:30;
            ca = Ca.Ch0{roi, trial};
            [r lags] = xcov(ca, mov, 'coeff');
            peak = max(r(922:1122));
            trial_res(roi, 1) = peak;
        end
        result(:, trial) = trial_res;
    end
    figure
    imagesc(result)
    colorbar
end