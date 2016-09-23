clear VOCopts

VOCopts.dataset=database;

% get devkit directory with forward slashes
devkitroot=seism_root;

% change this path to point to your copy of the PASCAL VOC data
VOCopts.datadir=[devkitroot '/datasets_semseg/'];

% change this path to a writable directory for your results
VOCopts.resrootdir=[devkitroot '/results_semseg/'];
VOCopts.resdir=[VOCopts.resrootdir VOCopts.dataset '/'];

% initialize the test set
VOCopts.gt_set = gt_set; % use validation data for development test set

% initialize segmentation task paths
VOCopts.clsrespath=[VOCopts.resdir '%s.txt'];
VOCopts.clsimgpath=[VOCopts.datadir VOCopts.dataset '/%s/%s.png'];

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