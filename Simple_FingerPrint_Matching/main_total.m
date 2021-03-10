% function ffnew = main_total(filename)
filename ='E:\Matlab\bin\bio\new\Simple_FingerPrint_Matching\FVC2002\DB1_B\102_3.tif';
 addpath(genpath(pwd));
%% BUILD FINGERPRINT TEMPLATE DATABASE
% build_db(9,8);        %THIS WILL TAKE ABOUT 30 MINUTES
load('db.mat');

%% EXTRACT FEATURES FROM AN ARBITRARY FINGERPRINT
%filename='101_1.tif';
img = imread(filename);
if ndims(img) == 3; img = rgb2gray(img); end  % Color Images
disp(['Extracting features from ' filename ' ...']);
ffnew=ext_finger(img,1);

figure ;
    imshow(ffnew);
    title('ffnew');
