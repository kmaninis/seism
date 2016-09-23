function save_semseg_res(VOCopts, methodname,res)

save_dir = fullfile(VOCopts.resrootdir);
if ~exist(save_dir,'dir'),
    mkdir(save_dir);
end

fid = fopen(fullfile(save_dir,[VOCopts.dataset '_' VOCopts.gt_set '_' methodname '_classIoU.txt']),'w');
fprintf(fid,['background' repmat(' ',[1,15-length('background')]) num2str(res.class_IoU(1)) '\n']);
for ii=1:length(VOCopts.classes),
    fprintf(fid,[VOCopts.classes{ii} repmat(' ',[1,15-length(VOCopts.classes{ii})]) num2str(res.class_IoU(ii+1)) '\n']);
end
fclose(fid);

fid = fopen(fullfile(save_dir,[VOCopts.dataset '_' VOCopts.gt_set '_' methodname '_meanIoU.txt']),'w');
fprintf(fid,num2str(res.mean_IoU));

end