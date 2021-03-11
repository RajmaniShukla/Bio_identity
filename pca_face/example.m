function [ProjectedTestImage] = example(TestImage,i)
% A sample script, which shows the usage of functions, included in
% PCA-based face recognition system (Eigenface method)
%
% See also: CREATEDATABASE, EIGENFACECORE, RECOGNITION

% Original version by Amir Hossein Omidvarnia, October 2007
%                     Email: aomidvar@ece.ut.ac.ir                  

%% You can customize and fix initial directory paths
%TrainDatabasePath = uigetdir('D:\Program Files\MATLAB\R2006a\work', 'Select training database path' );
TrainDatabasePath = '.\Database';
%TestDatabasePath = uigetdir('D:\Program Files\MATLAB\R2006a\work', 'Select test database path');
TrainDatabasePath = strcat(TrainDatabasePath,'\',i);
%% To get TestImage Manually
%prompt = {'Enter test image name (a number between 1 to 10):'};
%dlg_title = 'Input of PCA-Based Face Recognition System';
%num_lines= 1;
%def = {'1'};

%%TestImage = strcat(TestDatabasePath,'\',char(TestImage),'.bmp');
%im = imread(TestImage);
%im = TestImage;
T = CreateDatabase(TrainDatabasePath);
[m, A, Eigenfaces] = EigenfaceCore(T);

InputImage = TestImage;
temp = InputImage(:,:,1);

[irow icol] = size(temp);
InImage = reshape(temp',irow*icol,1);
Difference = double(InImage)-m; % Centered test image
ProjectedTestImage = Eigenfaces'*Difference; % Test image feature vector
%figure;
%imshow(fea_re);
%% Display Results
%SelectedImage = strcat(TrainDatabasePath,'\',OutputName);
%SelectedImage = imread(SelectedImage);
%figure;
%imshow(im)
%title('Test Image');
%figure,imshow(SelectedImage);
%title('Equivalent Image');

%str = strcat('Matched image is :  ',OutputName);
%disp(str)
