% Template config file for pose3d
% Edit this file to enter your project specifics
%
% Copyright (c) 2019 Swathi Sheshadri
% German Primate Center
% swathishesh AT gmail DOT com
%
% If used in published work please see repository README.md for citation
% and license information: https://github.com/SwathiSheshadri/pose3d

%% Specify path and file name for pose3d to save your 3D reconstruction related files in
% exp_path holds the name of the folder that gets created by pose3d for
% your experiment. This folder will be created in your present working directory.
% All experiments in this folder access the same calibration files
% Therefore, everytime you move cameras or record from a different setup
% change this name, otherwise you can keep this fixed

exp_path = 'AllExperiments'; %./AllExperiments **To be different for every new camera configuration/experiment setup**

% exp_name holds the name of the session of your experiment 
% this is created as a folder withint exp_path directory by pose3d for your session specific data files

exp_name = 'Experiment1'; % ./AllExperiments/Experiment1; **To be different for every new experiment**

%Are you using DeepLabCut for 2D tracking?
usingdlc = 1; %set to 0, if using other software

%which mode of 3D reconstruction do you want to use
% 1. 'all' (2D tracked data from all cameras is used for reconstruction
% 2. 'bestpair' (2D tracked data from best camera pair is used for 3D
% reconstruction for every time point and feature)
% 3. 'avg' (3D reconstructed data averaged over pairs)
% You can also select more than 1 mode and all specified moved will be saved in the specified ordered in Data3d.mat, for instance by setting modes_3drecon = {'all', 'bestpair'};
modes_3drecon = {'all'}; %this is the recommended mode (other possible modes are {'bestpair'},{'avg'}};

%% Enter your experiment specifics
% Fill in the number of features you have tracked in 2D using DLC or any
% other 2D tracking software (eg: for our demo nfeatures = 8;)
% Change this to match your current experiment
nfeatures = 8; %Edit this to match your current experiment

% Fill in precise duration of recording in **seconds** (eg: for our demo rec_time = 10;)
rec_time =  10; %Edit this to match your experiment recording time 

% Fill in frames per second (eg: for our demo fps = 100;)
fps =100; %Edit this to match your current experiment**

% Fill in the overall number of cameras in your experiment (for our demo we had 5 cameras)
% Change this to the number of cameras you have in your setup
ncams = 5; %Edit this to match your current experiment (minimum allowed value is 2)

%% Copy and paste your 2D tracked csv file paths with filenames
% There must be one path cell entry for primary camera DLC tracked data
% copy and paste the full path to your csv files generated by DLC
% this path can be anywhere that is readable by your user on the computer
primary2D_datafullpath     = {'csvdatafullpath../Primary-Rubiks_1030000.csv'}; 
% If you are using other software use the csv files in Rubikscube_other2d folder as
% reference to ensure the row and column entries are similar

% There must be ncams-1 path cell entries for secondary cameras (we have 5 cameras of
% which 1 is primary and remaining are secondary)
% this path can be anywhere that is readable by your user on the computer
%
% **Important info** -- 
%----------------------
% please maintain the order of secondary files here similar to the order you use 
% in the variable calibvideos_secondary
% For example : 2D tracked data from secondary1 should be from the same camera as the
% secondary2 calib file
secondary2D_datafullpath = [{'csvdatafullpath../Secondary1-Rubiks_1030000.csv'};...
                            {'csvdatafullpath../Secondary2-Rubiks_1030000.csv'};...
                            {'csvdatafullpath../Secondary3-Rubiks_1030000.csv'};...
                            {'csvdatafullpath../Secondary4-Rubiks_1030000.csv'}];

                        
%% Calibration Specifics

squareSize = 24; %%enter your checkboard square length in mm default is 24

calib_videos = 1; %set this to zero if you have acquired calibration images and 1 if videos

% Number of frames to extract from calibration videos to use for calibration
% Matlab recommends 10 to 20. 
% If you have noisy calibration videos set this to 50 or more to account for some frames that get
% rejected automatically during stereoCameraCalibration 
frames_to_use = 35; 

%% Copy and paste your calibration video paths and file names (relevant only if you record calibration videos)
% Ignore this section if you have taken images for calibration

% For pose3d there must be ncams-1 videos recorded from primary (each video
% recorded simultaneously with every secondary camera)
% Example below for a 5 camera system with 1 primary and 4 secondary
% this path can be anywhere that is readable by your user on the computer

% **Important info** -- 
%----------------------
% please maintain the order of primary and secondary video files  
% Eg : calibPrimarywithsec1.avi is the calibration video recorded from
% primary camera while simultaneously recording calib_sec1.avi from 
% camera secondary1

calibvideos_primary = [{'calibvideospath../calibPrimarywithsec1.avi'};...
                       {'calibvideospath../calibPrimarywithsec2.avi'};...
                       {'calibvideospath../calibPrimarywithsec3.avi'};...
                       {'calibvideospath../calibPrimarywithsec4.avi'}];


%Every secondary camera must have one calibration video recorded
%simultaneously with primary camera
% this path can be anywhere that is readable by your user on the computer
calibvideos_secondary = [{'calibvideospath../calib_sec1.avi'};...
                         {'calibvideospath../calib_sec2.avi'};...
                         {'calibvideospath../calib_sec3.avi'};...
                         {'calibvideospath../calib_sec4.avi'};]; %path to your calibration video recorded from secondary camera 1 with primary

%% calibfiles_format & folderwithpngs (relevant only when you have taken images for calibration)
% format variable relevant only if you have calibration images (i.e
% calib_videos = 0), if you have videos the file path must include the full
% file name with video format
CalibrationImages_format = '.png'; 

% pose3d opens this folder and allows you to select multiple calibration
% files for each camera pair sequentially, giving appropriate path here 
% reduces navigation time for you (HINT: give path to folder under which 
% calibration images from every camera pair are saved)
% edit example path below to the path where you have saved your calibration
% images
folderwithpngs = '/Users/username/CalibFiles/';

%% You are now done with fill up the main parameters!!! edit below for post-processing
% (Default setting we use are below.)
% Do you want to undistort 2D coordinates?
% If your lens have high distortion set this to 1
run_undistort = 0; %1: run undistort, 0: do not undistort

% plots 3D reconstructed data (if you have really long recordings set nskip to higher 
% values so only a few example frames are vizualized while saving everything)
plotresults = 1; %plots resulting 3D coordinates at recorded fps
nskip = 1; %min value nskip can take is 1, increase this when you have long recording (plots results from every nskip frames)

% the DLC based likelihood value threshold
llh_thresh = 0.9; %Can choose values between 0 and 1; 

% To draw a stick diagram/skeleton, list point pairs you want to join 
% If you don't want to draw skeleton, set this to 0
drawline = 0; %0 : skeleton will not be drawn, Eg : [ 1 2; 2 3;], draws lines between features 1 and 2, 2 and 3 

whichfilter = 2; % 0: No filter; 1: moving average; 2:median filter (if you observe jumps in your feature trajectories try 2 or 1)
npoints = 5;%number of data points to use for filter (if you choose 1 or 2 for which filter this value has to be filled)               

nframes = rec_time*fps; %nothing to edit here onwards

%% Some checks to make pose3d user-friendly
% Check if there are the right number csv of files & if all files are unique

if ((length(unique(secondary2D_datafullpath))) ~= ncams-1 || (length(unique(primary2D_datafullpath)) ~= 1))
   flag_mis = 1;
   uiwait(msgbox('Mismatch between number of cameras and number of 2D tracked data csv files detected. Check if all file names are unique and are as many as the number of cameras and re-run main program to proceed.'))
end

% Check if .csv files are provided for 2D tracked data (secondary cameras)
if(~all(arrayfun(@(x,y)strcmp(secondary2D_datafullpath{x}(end-2:end),'csv'),1:ncams-1)))
    flag_mis = 1;
    uiwait(msgbox('csv file expected by pose3d. Please enter 2D tracked data in csv format and re-run main program to proceed.'))
end

% Check if .csv files are provided for 2D tracked data primary camera
if~(strcmp(primary2D_datafullpath{1}(end-2:end),'csv'))
    flag_mis = 1;
    uiwait(msgbox('csv file expected by pose3d. Please enter 2D tracked data in csv format and re-run main program to proceed.'))
end


%Check if there are the right number of unique calibration videos
if calib_videos
    if ((length(unique(calibvideos_primary))) ~= (ncams-1) || (length(unique(calibvideos_secondary))) ~= (ncams-1))
       flag_mis = 1;
       uiwait(msgbox('Check if all calibration file names are unique and are included for every primary-secondary pair and re-run main program to proceed.'))
    end
end

if nskip == 0 || fps == 0 
    flag_mis = 1;
    uiwait(msgbox('nskip, fps cannot be 0. Change this and re-run main program to proceed.'))
end

if usingdlc
    if llh_thresh == 1
        flag_mis=1;
        uiwait(msgbox('llh_thresh must be lesser than 1. Change this and re-run main program to proceed.'))
    end
end

if ~iscell(modes_3drecon)
    flag_mis = 1;
    uiwait(msgbox('modes_3drecon must be cell type. Change this and re-run main program to proceed.'))
end

if ~iscell(calibvideos_primary)
    flag_mis = 1;
    uiwait(msgbox('calibvideos_primary must be cell type. Change this and re-run main program to proceed.'))
end

if ~iscell(calibvideos_secondary)
    flag_mis = 1;
    uiwait(msgbox('calibvideos_secondary must be cell type. Change this and re-run main program to proceed.'))
end

if ~iscell(secondary2D_datafullpath)
    flag_mis = 1;
    uiwait(msgbox('secondary2D_datafullpath must be cell type. Change this and re-run main program to proceed.'))
end

if ~iscell(primary2D_datafullpath)
    flag_mis = 1;
    uiwait(msgbox('primary2D_datafullpath must be cell type. Change this and re-run main program to proceed.'))
end

if ~exist('flag_mis','var')
    flag_mis = 0; %Nothing to flag, checks passed
end