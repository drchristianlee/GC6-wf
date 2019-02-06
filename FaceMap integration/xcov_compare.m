% Use this script to analyze calcium signals and movement data that is
% acquired from facemap. Click on a directory containing a Ca.mat file and
% a res_roi(number of roi) file. Generally the whisker roi will be 2. 

clear

prompt = {'Enter 0 if whisk signal is negative going or 1 if it is positive going'};
signal = inputdlg(prompt); %enter 0 if whisk signal is negative going or 1 if it is positive going

[folder] = uigetdir;
cd(folder)
files = dir('*.mat');
for loader = 1:size(files, 1)
    load(files(loader, 1).name)
end

correction_val = 3.3333;
[p,q] = rat(correction_val);
trial_res = zeros(30, 1);
result = zeros(30, 100);

for trial = 1:size(res, 2)
    mov_extractor = double(res{1, trial});
    mov_resampler = resample(mov_extractor, p, q);
    mov = transpose(mov_resampler(1:1023, 1));
    %mov = mov_resampld - (mean(mov_resampld));
    for roi = 1:30
        ca = Ca.Ch0{roi, trial};
        [r , lags] = xcov(ca, mov, 'coeff'); 
        peak_h = max(r(922:1122));
        peak_l = min(r(922:1122));
        if signal == 0
        trial_res(roi, 1) = abs(peak_l);
        else
            trial_res(roi, 1) = peak_h;
        end
    end
    result(:, trial) = trial_res;
end

imagesc(result);
colorbar

%sort and rank
% avg = mean(result, 2);
% [sorted , rank] = sort(avg);
% 
% for step = 1:30
%     sorter(step, :) = result(rank(step, 1), :);
% end
% figure
% imagesc(sorter)

saveas(gcf, 'heatmap.eps');
save('signal.mat' , 'signal');