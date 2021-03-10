%function [result_p]=face_recognition(TestImage)

%% % face recognition by Kalyan Sourav Dash %%%
%%%%%%%  provide the data path where the training images are present  %%%%%%%
%%% if your matlab environment doesn't support 'uigetdir' function
%%% change those lines in code for datapath and testpath as :
% datapath = 'give here the path of your training images';
% testpath = 'similarly give the path for test images';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
datapath = uigetdir('D:\New folder (2)\Project\RM\Face Database part2\054');
%% testpath = uigetdir('C:\Documents and Settings\KsDash\My Documents\MATLAB','select path of test images');
%prompt = {'Enter test image name (a number between 1 to 10):'};
%dlg_title = 'Input of PCA-Based Face Recognition System';
%num_lines= 1;
%def = {' '};
%%TestImage = strcat(testpath,'\',char(TestImage),'.jpg');
TestImage ='D:\New folder (2)\Project\RM\Face Database part2\054\054_illumination_two_7.bmp';
 
TestImage = strcat(TestImage);
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Face detection using VIOLA_JONES_ALGORITHM
%to detect face
Fdetect = vision.CascadeObjectDetector;
%Return Bounding box values based on number of objects
I = imread(TestImage);
BB = step(Fdetect,I);
figure,
imshow(I);
hold on;
for i =1:size(BB,1)
    rectangle('Position',BB(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','r');
end
title('Face Detection');
hold off;
% face crop 
for i=1:size(BB,1)
    j=imcrop(I,BB(i,:));
    figure;
    imshow(j);
end
% rgb2gray
j = rgb2gray(j);
%% %%%%%%%%%%%  calling the functions  %%%%%%%%%%%%%%%%%%%%%%%%
[recog_img, result_p] = facerecog(datapath,TestImage);
selected_img = strcat(datapath,'\',recog_img);
select_img = imread(selected_img);
figure;
imshow(select_img);
title('Recognized Image');
test_img = imread(TestImage);
figure,imshow(test_img);
title('Test Image');
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
result = strcat('the recognized image is : ',recog_img);
disp(result);