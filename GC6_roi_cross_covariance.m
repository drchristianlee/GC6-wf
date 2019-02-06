% This script creates a cross correlation matrix between rois. 
% The maximal cross correlation is saved in the matrix.

clear
mouse = uigetdir;
%mouse = 'C:\Users\margolis\Desktop\pupil test\early\';
cd([mouse]); 
load('Ca.mat')


for trial = 1:size(Ca.Ch0, 2);
    for roi = 1:size(Ca.Ch0, 1);
    data_keeper(roi, :, trial) = Ca.Ch0{roi, trial};
    end
end


for analysis_trial = 1:size(data_keeper, 3);
for base_roi = 1:30;
    for test_roi = 1:30;
        [xCorrel_holder(1, :)] = xcov(data_keeper(base_roi, :, analysis_trial), data_keeper(test_roi, :, analysis_trial), 'coeff');
        adjmat(test_roi, base_roi, analysis_trial) = max(xCorrel_holder(1, :));
    end
end
end

figure
result = mean(adjmat, 3);
imagesc(result, [0 1])

%save('result' , 'result')