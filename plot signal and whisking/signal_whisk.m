% This script plots cortical signal from a given roi as well as whisker
% signal

clear
close all
clc
mouse = 'R:\Margolis Lab Server\Dropbox (Rutgers SAS)\GCaMP6f spont and tone reward\150421am GC6-emx 1-3 spont\GC6f_emx_03\intrinsic\intrinsic\DFF\1\';
%mouse = 'C:\Users\margolis\Desktop\pupil test\early\';
cd([mouse]); 
load('Ca.mat')
mouse = 'R:\Margolis Lab Server\Dropbox (Rutgers SAS)\GCaMP6f spont and tone reward\150421am GC6-emx 1-3 spont\GC6f_emx_03\intrinsic\angle data\angle data\';
cd([mouse]);
load('anglekeeper.mat');

roi = 20; %enter the roi to plot here

for trial = 1:size(Ca.Ch0, 2);
    figure
    subplot(2,1,1);
    plot(Ca.Ch0{roi, trial}(1, 1:500));
    %axis([1 500 -10 5])
    subplot(2,1,2);
    plot(-1*(anglekeeper(trial, 1:7500)));
    axis tight
    %axis([1 7500 50 300]);
    end