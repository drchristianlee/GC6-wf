% use this script to separate principal component vectors from motion svd
% for each trial. 
clear

[file, path] = uigetfile
cd(path)
load(file)



for roi_num = 1:3;
for trials = 1:100;
    if trials == 1;
        frame_start = 1;
        frame_end = proc.nframes(trials, 1);
    else
    end
    for frames = frame_start:frame_end;
        res{1, trials} = proc.motSVD{1,roi_num}(frame_start:frame_end, 1);
    end
    if trials ~= 100;
    frame_start = frame_end + 1;
    frame_end = frame_start + proc.nframes(trials + 1, 1) - 1;
    else
    end
end
save(['res_roi' num2str(roi_num) '.mat'] , 'res');
end

