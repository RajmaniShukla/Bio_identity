img1 = 'D:\New folder (2)\Matlab\bin\bio\new\Database\1\l.bmp';
img2 = 'D:\New folder (2)\Matlab\bin\bio\new\Database\1\r.bmp';

addpath('..\IrisRecognition-master');
%img1 = imread(img1);
%img2 = imread(img2);

%% 
img1_f = gen_compare(img1);

%% 
img2_f = gen_compare(img2);

%% 
i12 = main_f(img1_f,img2_f);