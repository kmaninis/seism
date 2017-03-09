clear VOCopts

VOCopts.dataset=database;

% get devkit directory with forward slashes
devkitroot=seism_root;

% change this path to point to your copy of the PASCAL VOC data
   VOCopts.datadir=fullfile(devkitroot, 'datasets_semseg'); 


% change this path to a writable directory for your results
VOCopts.resrootdir=[devkitroot '/results_semseg/'];
VOCopts.resdir=fullfile(VOCopts.resrootdir, VOCopts.dataset);

% initialize the test set
VOCopts.gt_set = gt_set; % use validation data for development test set

% initialize segmentation task paths
VOCopts.clsrespath=fullfile(VOCopts.resdir, '%s.txt');
VOCopts.clsimgpath=fullfile(VOCopts.datadir, VOCopts.dataset, gt_set, '%s', '%s.png');

% initialize the VOC challenge options

% classes

VOCopts.classes={...
    'aeroplane'
    'bicycle'
    'bird'
    'boat'
    'bottle'
    'bus'
    'car'
    'cat'
    'chair'
    'cow'
    'diningtable'
    'dog'
    'horse'
    'motorbike'
    'person'
    'pottedplant'
    'sheep'
    'sofa'
    'train'
    'tvmonitor'};

VOCopts.nclasses=length(VOCopts.classes);