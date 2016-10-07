clear all;close all;clc;

database = 'SBD';
gt_set = 'val';
methodname = 'DilatedConv';

load('/home/kmaninis/scratch_second/Results/SemSeg/colormap_PASCAL.mat');
im_ids = db_ids(database, gt_set);
save_dir = ['/home/kmaninis/scratch_second/Results/SemSeg/' database '/' methodname];

for ii=1:length(im_ids),
    display(num2str(ii));
    I= imread(fullfile(save_dir, [im_ids{ii} '.png']));
    imwrite(I, colormap, fullfile(save_dir, [im_ids{ii} '.png']));
end

