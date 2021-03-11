img1 = 'D:\New folder (2)\Matlab\bin\bio\new\Database\1\p (1).bmp';
img2 = 'D:\New folder (2)\Matlab\bin\bio\new\Database\1\p (2).bmp';
img3 = 'D:\New folder (2)\Matlab\bin\bio\new\Database\1\p (3).bmp';
img4 = 'D:\New folder (2)\Matlab\bin\bio\new\Database\1\p (4).bmp';
img5 = 'D:\New folder (2)\Matlab\bin\bio\new\Database\1\p (5).bmp';


addpath('..\Simple_FingerPrint_Matching');
%img1 = imread(img1);
%img2 = imread(img2);
%img3 = imread(img3);
%img4 = imread(img4);
%img5 = imread(img5);

%% 
img1_f = main_total(img1);

%% 
img2_f = main_total(img2);

%% 
img3_f = main_total(img3);
%% 
img4_f = main_total(img4);
%% 
img5_f = main_total(img5);

%% 
i12 = main_f(img1_f,img2_f);
%i13 = main_f(i12,img3_f);
%i14 = main_f(i13,img4_f);
%i15 = main_f(i14,img5_f);