img1 = 'D:\New folder (2)\Matlab\bin\bio\new\Database\1\f (1).bmp';
img2 = 'D:\New folder (2)\Matlab\bin\bio\new\Database\1\f (2).bmp';
img3 = 'D:\New folder (2)\Matlab\bin\bio\new\Database\1\f (3).bmp';
img4 = 'D:\New folder (2)\Matlab\bin\bio\new\Database\1\f (4).bmp';
img5 = 'D:\New folder (2)\Matlab\bin\bio\new\Database\1\f (5).bmp';


addpath('..\pca_face');
%img1 = imread(img1);
%img2 = imread(img2);

%% 
img1_f = example();

%%
img2_f = example();

%% 
img3_f = example();
%% 
img4_f = example();
%% 
img5_f = example();

%% 
i12 = main_f(img1_f,img2_f);
i13 = main_f(i12,img3);
i14 = main_f(i13,img4);
i15 = main_f(i14,img5);
figure, imshow(i15),title('Final Fused')