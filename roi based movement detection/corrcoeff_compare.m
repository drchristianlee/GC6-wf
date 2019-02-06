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

for trial = 1:size(res, 2);
    mov_extractor = double(res{1, trial});
    mov_resampler = resample(mov_extractor, p, q);
    mov = transpose(mov_resampler(1:1023, 1));
    for roi = 1:30;
        ca = Ca.Ch0{roi, trial};
        R = corrcoef(ca, mov); 
        trial_res(roi, 1) = R(2, 1);
    end
    result(:, trial) = trial_res;
end

imagesc(result)