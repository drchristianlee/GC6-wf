% This script plots cortical signal from a given roi as well as whisker
% signal

clear
close all
clc
mouse = uigetdir;
%mouse = 'C:\Users\margolis\Desktop\pupil test\early\';
cd([mouse]); 

files = dir('*.mat');
for loader = 1:size(files, 1);
    load(files(loader, 1).name)
end


correction_val = 3.3333;
[p,q] = rat(correction_val);

for trial = 1:100;
    figure
    mov_extractor = double(res{1, trial});
    mov_resampler = resample(mov_extractor, p, q);
    mov = transpose(mov_resampler(1:1023, 1));
    for roi = 1:30;
    subplot(11, 3, roi);
    plot(Ca.Ch0{roi, trial});
    end
    for mov_place = 31:33;
    subplot(11, 3, mov_place);
    plot(mov);
    end
end