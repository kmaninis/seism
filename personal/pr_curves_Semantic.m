%% Experiments parameters
 clear;close all;%clc;


%database = 'BSDS500';
%database = 'PASCALContext';
%database = 'Pascal';
database = 'SBD';

writePR = 0; % Write results in format to use latex code?
USEprecomputed = 1; % Use precomputed results or evaluate on your computer?

% Precision-recall measures
measures = {'fb'};

% Define all methods to be compared
methods  = [];
switch database
    case 'SBD'
        gt_set   = 'val';
        cat_id = 1:20;
        kill_internal = 1;
        classes = importdata(fullfile(seism_root,'src','gt_wrappers','misc','SBD_classes.txt'));
        

        methods(end+1).name = 'COB-gt';             methods(end).io_func = @read_one_cont_png;  methods(end).legend = methods(end).name;  methods(end).type = 'contour';
        methods(end+1).name = 'COB-dil';             methods(end).io_func = @read_one_cont_png;  methods(end).legend = methods(end).name;  methods(end).type = 'contour';
        methods(end+1).name = 'DilatedConv';             methods(end).io_func = @read_one_cont_png;  methods(end).legend = methods(end).name;  methods(end).type = 'contour';
        %         methods(end+1).name = 'CEDN';             methods(end).io_func = @read_one_cont_png;  methods(end).legend = methods(end).name;  methods(end).type = 'contour';
        %         methods(end+1).name = 'CEDN_separate';             methods(end).io_func = @read_one_cont_png;  methods(end).legend = methods(end).name;  methods(end).type = 'contour';
        methods(end+1).name = 'BNF';             methods(end).io_func = @read_one_cont_png;  methods(end).legend = methods(end).name;  methods(end).type = 'contour';
        methods(end+1).name = 'HFL';             methods(end).io_func = @read_one_cont_png;  methods(end).legend = methods(end).name;  methods(end).type = 'contour';
        methods(end+1).name = 'ResNet50-mod-pc_40000';             methods(end).io_func = @read_one_cont_png;  methods(end).legend = 'ResNet50';  methods(end).type = 'contour';
        %methods(end+1).name = 'ResNet50-neg_500_40000';             methods(end).io_func = @read_one_cont_png;  methods(end).legend = 'ResNet50 neg';  methods(end).type = 'contour';
        %methods(end+1).name = 'ResNet50-neg_500_40000_clean';             methods(end).io_func = @read_one_cont_png;  methods(end).legend = 'ResNet50 neg clean';  methods(end).type = 'contour';
        methods(end+1).name = 'ResNet50-neg_500_40000_clean_soft';             methods(end).io_func = @read_one_cont_png;  methods(end).legend = 'ResNet50 clean';  methods(end).type = 'contour';
        %methods(end+1).name = 'ResNet50-mod-pc_40000_clean';             methods(end).io_func = @read_one_cont_png;  methods(end).legend = 'ResNet50 clean';  methods(end).type = 'contour';
        %         methods(end+1).name = 'HED-mod-pc_40000';             methods(end).io_func = @read_one_cont_png;  methods(end).legend = methods(end).name;  methods(end).type = 'contour';
        %         methods(end+1).name = 'ResNet50-neg_50_40000';             methods(end).io_func = @read_one_cont_png;  methods(end).legend = methods(end).name;  methods(end).type = 'contour';
        %         methods(end+1).name = 'ResNet50-neg_100_40000';             methods(end).io_func = @read_one_cont_png;  methods(end).legend = methods(end).name;  methods(end).type = 'contour';
        %         methods(end+1).name = 'ResNet50-neg_200_40000';             methods(end).io_func = @read_one_cont_png;  methods(end).legend = methods(end).name;  methods(end).type = 'contour';
        %         methods(end+1).name = 'ResNet50-neg_500_40000';             methods(end).io_func = @read_one_cont_png;  methods(end).legend = methods(end).name;  methods(end).type = 'contour';
        %         methods(end+1).name = 'ResNet50-neg_1000_40000';             methods(end).io_func = @read_one_cont_png;  methods(end).legend = methods(end).name;  methods(end).type = 'contour';
        %         methods(end+1).name = 'ResNet50-neg_all_40000';             methods(end).io_func = @read_one_cont_png;  methods(end).legend = methods(end).name;  methods(end).type = 'contour';
        methods(end+1).name = 'Khoreva';             methods(end).io_func = @read_one_cont_png;  methods(end).legend = methods(end).name;  methods(end).type = 'contour';
        methods(end+1).name = 'Bharath';             methods(end).io_func = @read_one_cont_png;  methods(end).legend = methods(end).name;  methods(end).type = 'contour';
        %methods(end+1).name = 'COB';             methods(end).io_func = @read_one_ucm;       methods(end).legend = 'COB';              methods(end).type = 'segmentation';
    otherwise
        error('Unknown name of the database');
end

% Colors to display
colors = {'b','g','r','k','m','c','y','b','g','r','k','m','c','y','k','g','b','g','r'};

%% Evaluate your method (just once for all parameters)

% % Evaluate using the correct reading function
if ~USEprecomputed
    for ii=1:length(measures)
        for jj=1:length(methods)
            % Contours only in 'fb'
            is_cont = strcmp(methods(ii).type,'contour');
            if strcmp(measures{ii},'fb') || ~is_cont
                if exist('cat_id','var')
                    eval_method_all_params(methods(jj).name, measures{ii}, methods(jj).io_func, database, gt_set, is_cont,cat_id);
                else
                    eval_method_all_params(methods(jj).name, measures{ii}, methods(jj).io_func, database, gt_set, is_cont);
                end
            end
        end
    end
end

% % Helper to check existence of files
% test_io(methods, database, gt_set);

%% Plot PR curves
addpath(genpath('src'));
figure('units','normalized','outerposition',[0 0 1 1])
for ll=cat_id
    subplottight(4,5,ll),
    hold on;for F = 0.1:0.1:0.9,iso_f_plot(F);end;axis square;
    % iso_f_axis([measures{kk} '_' num2str(ll)])
    fig_handlers = [];
    legends = {};
    % Plot methods
    for ii=1:length(methods)
        try
            display(['Evaluating method: ' methods(ii).name ' for class ' classes{ll} '...']);
            % Plot the contours only in 'fb'
            if strcmp(methods(ii).type,'contour'),style='-';else style='-';end
            
            if kill_internal,
                precomputed_dir = fullfile(seism_root,'results','pr_curves',[database '_killintern']);
            else
                precomputed_dir = fullfile(seism_root,'results','pr_curves',database);
            end
            
            fname_core = [database '_' gt_set '_' measures{1} '_' methods(ii).name '_' num2str(ll)];
            if exist(fullfile(precomputed_dir, [fname_core '.txt']),'file'),
                temp = importdata(fullfile(precomputed_dir, [fname_core '.txt']));
                curr_meas.mean_prec = temp.data(:,1);
                curr_meas.mean_rec = temp.data(:,2);
                temp = importdata(fullfile(precomputed_dir, [fname_core '_ods.txt']));
                curr_ods.mean_prec = temp.data(1);
                curr_ods.mean_rec = temp.data(2);
                curr_ods.mean_value = importdata(fullfile(precomputed_dir, [fname_core '_ods_f.txt']));
                curr_ap = importdata(fullfile(precomputed_dir, [fname_core '_ap.txt']));
            else
                % Get all parameters for that method from file
                params = get_method_parameters(methods(ii).name);
                % Gather pre-computed results
                curr_meas = gather_measure(methods(ii).name,params,'fb',database,gt_set,ll,kill_internal);
                curr_ods  = general_ods(curr_meas);
                curr_ap   = general_ap(curr_meas);
            end
            
            % Plot method
            display(['ODS: ' num2str(curr_ods.mean_value) ' AP: ' num2str(curr_ap) ])
            fig_handlers(end+1) = plot(curr_meas.mean_rec,curr_meas.mean_prec,[colors{ii} style],'LineWidth',2); %#ok<SAGROW>
            plot(curr_ods.mean_rec,curr_ods.mean_prec,[colors{ii} '*'],'LineWidth',2)
            legends{end+1} = ['[F:' sprintf('%.0f',curr_ods.mean_value*100) ', AP:' sprintf('%.0f',curr_ap*100) '] ' methods(ii).legend ]; %#ok<SAGROW>
            Fscore(ii,ll) = curr_ods.mean_value*100;
            AP(ii,ll) = curr_ap*100;
        end
    end
    
    if strfind(gt_set,'_'), set_title = strrep(gt_set,'_','\_');else set_title=gt_set;end
    title(classes{ll});
    legend(fig_handlers,legends);%, 'Location','NorthEastOutside')
    hold off;
end

%% Write the results for latex processing
if writePR,
    if strcmp(database,'SBD'),
        for ll=cat_id,
            if kill_internal,
                pr_curves_to_file(measures, database, gt_set, methods, ll,fullfile(seism_root,'results','pr_curves','SBD_killintern'),kill_internal);
            else
                pr_curves_to_file(measures, database, gt_set, methods, ll);
            end
        end
    else
        pr_curves_to_file(measures, database, gt_set, methods);
    end
end

for ii=1:length(methods),
    row_names{ii} = methods(ii).legend;
end
col_names = importdata('/srv/glusterfs/kmaninis/Databases/Boundary_Detection/PASCALContext/categories.txt')';
col_names{end+1} =  'Mean';
Fscore(:,end+1) = mean(Fscore,2);
AP(:,end+1) = mean(AP,2);
table_with_max_per_col(Fscore, row_names, col_names);
table_with_max_per_col(AP, row_names, col_names);
