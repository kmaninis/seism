%% Semantic Segmentation Evaluation

%% Experiments parameters
clear all;close all;clc;

% Select the database to work on
database = 'Pascal';
% database = 'PASCALContext';
% database = 'SBD';

% Write results in format to use latex code?
writePR = 0;

methods  = [];
switch database,
    case 'PASCALContext',
        gt_set   = 'test_new';
        methods(end+1).name = 'COB';
    case 'Pascal',
        gt_set   = 'Segmentation_val_2012';
        methods(end+1).name = 'CEDN-Sem'; methods(end).legend = methods(end).name;
    case 'SBD',
        gt_set   = 'val';
        methods(end+1).name = 'COB';
    otherwise,
        error('Unknown name of the database');
end

% initialize VOC options
VOCinit;


%% Evaluate (and save) results
for ii=1:length(methods)
    [res(ii).class_IoU,res(ii).mean_IoU,res(ii).conf,ress(ii).rawcounts] = VOCevalseg(VOCopts,methods(ii));
    
    %Write the results for LaTeX processing
    if writePR,
        save_semseg_res(VOCopts, methods(ii).name, res(ii));
    end
end



%% Generate LaTeX tables
for ii=1:length(methods),
    row_names{ii} = methods(ii).legend;
    IoUs(ii,:) = [res(ii).class_IoU' res(ii).mean_IoU];
end
col_names = {'background' VOCopts.classes{:}}; col_names{end+1} =  'Mean';
table_with_max_per_col(IoUs, row_names, col_names);

%% Visualize results
figure;
bar(1:length(res(ii).class_IoU), res(ii).class_IoU');

xlim([0 length(res(ii).class_IoU)+1]);
xticklabel_rotate(1:length(res(ii).class_IoU),55,col_names(1:end-1),'interpreter','none');


