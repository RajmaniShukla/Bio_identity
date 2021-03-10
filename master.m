%DEMO
clear 
clc
close all
%% Adding Path for required directory
addpath('IrisRecognition-master','pca','Simple_FingerPrint_Matching','image_fusion' );
%% Files For Operation
filename_f = 'D:\New folder (2)\Matlab\bin\bio\new\pca\TestDatabase\12.jpg';
filename_i = 'D:\New folder (2)\Matlab\bin\bio\new\IrisRecognition-master\1\left\aeval1_direct.jpg';
filename_fp = 'D:\New folder (2)\Matlab\bin\bio\new\Simple_FingerPrint_Matching\FVC2002\DB1_B\102_3.tif';
%%  feacture extration for FACE image
m1 = face_recognition(strcat(filename_f));
figure;
imshow(m1);
title('feacture FACE');
%%  feacture extration for IRIS image
m2 = gen_compare(filename_i);
figure;
imshow(m2);
title('feacture IRIS');
%%  feacture extration for FingerPrint image
m3 = main_total(filename_fp);
figure;
imshow(m3);
title('feacture FingerPrint');
%%  Feacture Fusion image
m12 = main_f(m1,m2);
m = main_f(m12,m3);
figure;
imshow(m);
title('Fused Image M')
%% FOR EACH image TEMPLATE, CALCULATE MATCHING SCORE IN COMPARISION WITH FIRST ONE
S=zeros(72,1);
for i=1:72
    second=['10' num2str(fix((i-1)/8)+1) '_' num2str(mod(i-1,8)+1)];
    fprintf(['Computing similarity between ' filename ' and ' second ' from Database : ']);
    S(i)=match(m,strcat('database',i,'.jpg'));
    fprintf([num2str(S(i)) '\n']);
    drawnow
end
