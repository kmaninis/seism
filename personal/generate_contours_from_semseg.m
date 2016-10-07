database = 'SBD';
gt_set = 'val';
method = 'DilatedConv';
sem_seg_dir = ['/home/kmaninis/scratch_second/Results/SemSeg/SBD/' method];
sem_cont_dir = ['/home/kmaninis/scratch/BoundaryDetectionResults/SBD/' method];
if ~exist(sem_cont_dir,'dir'),
    for j=1:20,
        mkdir(fullfile(sem_cont_dir,num2str(j)));
    end
end
im_ids = db_ids(database, gt_set);


for ii=1:length(im_ids),
    display(num2str(ii));
    if exist(fullfile(sem_cont_dir,'20',[im_ids{ii} '.png'])), 
        continue;
    end

    im = imread(fullfile(sem_seg_dir,[im_ids{ii} '.png']));
    im_save = zeros(size(im));
    for j=1:20,
        im_save = im2double(im==j);
        im_save = bwmorph(imgradient(im_save>0),'thin','Inf');
        imwrite(im_save,fullfile(sem_cont_dir,num2str(j),[im_ids{ii} '.png']));
    end
    
end
