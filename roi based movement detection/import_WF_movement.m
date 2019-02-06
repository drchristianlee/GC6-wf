% function import_WF2(trial_type)
% basic version of extractor for ChR2 data - no behavior trial sorting

clear;

% mouse = 'D:\Share\DATA\GCaMP6f WF\150317 GC6f-EMX_01 plus pupil\GC6f_EMX_01\whisker\';
mouse = 'Z:\DATA\GCaMP6s\180928\streampix\thy1gc6s_8\';

% mouse is the name of a folder
%ch = '1'; % camera number to analyze (separate folder)
%ch = 'avg';

img_type = 'tiff\';
% img_type = 'PREP\';

dim = [120 160]; % dimension of the movie in pixels x,y
Mo.sample_rate = 30;    %in frames / sec

cd(mouse); % start in session directory, e.g. thin01-17

% get list of all .tif files (32-bit DF/F) in folder
% files = 'DFF\*.tif';
files = [img_type '\*.tif'];
files = dir(files);
files = struct2cell(files);
files = files(1,:);
files = reshape(files, [], 1);


% get list of rois
directory = 'roi/*.zip';
rois = dir(directory);
rois = struct2cell(rois);
rois = rois(1,:);
rois = reshape(rois, [], 1);
b = size(rois);
b = b(1);

RoiName = ['roi/' rois{1}];
roiSet = ij_roiDecoder(RoiName, dim);
Mo.roiLabel = roiSet(:,1);
refRoi = roiSet(:,2); % just the masks, no labels
roi = refRoi{1};

% cd('DFF\');
cd([img_type]);

%for choice = 1:length(trial_type);
%     trial_type_current = trial_type{1,choice};
%     files_list = eval(trial_type_current);
% open tiff stack movies
% behav trial type specified by files_list- Go, NoGo, Miss, or FA
for movie = 1:size(files,1) % files_list,2 was files,1
    img = imreadalltiff(files{movie}); %files{files_list(movie)} was files{movie}
    % uncomment below to save movies as .mat files
    %saveName = files{i,1}(1:length(files{i,1})-4); % name without .tif
    %save([saveName '.mat'], 'img');
    for r = 1:length(refRoi)
        roi = refRoi{r};
        extracted_ch0 = nanmean(GetRoiTimeseries(img,roi),1);
        Mo.Ch0{r,movie} = extracted_ch0; % each sweep for each roi
    end
    
end
%Ca.Ch0 = []; % reset for next trial type - this was not done before
% --- careful working with older Ca.Ch0 structures --- they had entries
% caried over from previous trial types (i.e. Go in NoGo structures...)
%end
%saveName = files{movie,1}(1:length(files{movie,1})-4); % name without .tif
%save([saveName '_Ca_' trial_type '.mat'], 'Ca')

cd([mouse '\' img_type]);
save('Mo.mat', 'Mo');
%end



