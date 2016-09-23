
cat_sbd = importdata('/srv/glusterfs/kmaninis/Databases/Boundary_Detection/PASCALContext/categories.txt');
cat_pc = importdata('/srv/glusterfs/kmaninis/Databases/Boundary_Detection/PASCALContext/labels.txt');


db1 = 'SBD'; set1 = 'train';
db2 = 'PASCALContext'; set2 = 'trainval_new';
[matches, numMatches] = searchMatches(db1,set1,db2,set2);

files =[];
cat=11;
label=397;
count=0;
for i=1:length(matches),
    if mod(i,100)==1,
        display([num2str(i) ' ' num2str(length(matches))]);
    end
    image_id = matches{i}; 
    %if ~ismember(gt_cls.CategoriesPresent,cat),continue;end
    %gt_label = loadvar(fullfile(db_root_dir('PASCALContext'), 'trainval', [image_id '.mat']),'LabelMap');
    %if sum(gt_label==label)==0, continue;end
    gt_cls  = loadvar(fullfile(db_root_dir('SBD'), 'cls', [image_id '.mat']),'GTcls');
    if ~ismember(gt_cls.CategoriesPresent,cat),continue;
    else
        count = count + 1;
        files{end+1} = matches{i};
    end
%     image = db_im( 'SBD', image_id );
%     figure;imshow(image);
%     figure;
%     subplot(1,2,1), imshow(full(gt_cls.Boundaries{cat})); title('SBD')
%     subplot(1,2,2), imshow(seg2bmap(gt_label==label)); title('PASCALContext')
%     pause;
end


