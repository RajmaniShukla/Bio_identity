clear 
clear all
clc
display 'start....'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% This examples is created for fun purpose only. Limited accuracy.
%%%%%%%% Trained on 500 images searched on internet with the keywords - actors,
%%%%%%%% actors bollywood, actress, actress indian, monkey face.
%%%%%%%% I found accuracy around 80% on collected dataset.
tic
%% correct the following path
Datapath1 = 'D:\New folder (2)\Matlab\bin\bio\new\DB\'; %path of images
Datapath ='.\';  % path of program files and data on your pc
display 'start....'
display 'reading dataset...'


% image's size
h = 28;
w = 28;

% storage for test images: at least two images required.
test_x = zeros([h w  1]); 
train_x = zeros([h w  1]); % 3 test images
%test_y = zeros([3 120]);


k=0; % k -> index for images
% load multiple images .
% labels
% [1 0 0] - for female
% [0 1 0] - for male
% [0 0 1] - more similar to monkey rather than male or female human - just
% for fun.

% change the file names according to your images.
% we assume filenames are stored as f (1).jpg, f (2).jpg etc.
d=dir(Datapath1);
for j=1:91
    if not(strcmp(d(j).name,'.')|strcmp(d(j).name,'..'))  
        f=dir(strcat(Datapath1,d(j).name));
        for i=1:size(f,1)
            %I=imread(fullfile(Datapath, wiki.full_path{i}));
            %st = sprintf('%s',f(i).name);
             if not(strcmp(f(i).name,'.')|strcmp(f(i).name,'..'))  
                I=imread(fullfile(Datapath1,d(j).name,f(i).name));
                 if(size(I,5) > 1)
                    I = rgb2gray(I);
            %         M=I;
            %         I(:,:,1)=M;
            %         I(:,:,2)=M;
            %         I(:,:,3)=M;
                 end
                I = imresize(I, [h w ] );
                %I = rescale(double(I))/2;
                %I = I - mean(I(:));
                k = k+1;
                train_x(:,:,k)=I;
                %k = k+1;
             end
        end 
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% We create our arbitary CNN and train it with internet dataset
%%%%% The architecture of CNN is arbitrarily choosen for experimental purpose
%%%%% The architecture may be revised for better result.

%   cnnAddConvLayer - Add convolution layer
%   cnn, no_of_feature_maps, sizeof(kernels), activation function -'sigm' 
%   for sigmoid, 'tanh' for tanh, 'rect' for ReLu, 'soft' for softmax, 
%  'none' for none, 'plus' for softplus.

% cnnAddPoolLayer - Add Pool layer
% cnn, subsampling factor, subsampling type. Presently only 'mean'
% subsampling is implemented.

%cnnAddFCLayer - Add fully connected neural network layer
% cnn, no of NN nodes, activation function.




% initialize cnn
cnn.namaste=1; % just intiationg cnn object

cnn=initcnn(cnn,[h w ]);



cnn=cnnAddConvLayer(cnn, 3, [5 5], 'plus');
 cnn=cnnAddPoolLayer(cnn, 2, 'mean');

%cnn=cnnAddFCLayer(cnn,10, 'sigm' ); %add fully connected layer
cnn=cnnAddFCLayer(cnn,15, 'tanh' ); %add fully connected layer
cnn=cnnAddFCLayer(cnn,6, 'soft' ); %add fully connected layer


%load trained cnn network
     %cnn = loadcnn(fullfile(Datapath, 'my_face_cnn5.mat'));
 %following commented code shows the cnn we have trained and saved in above
 %file.
% cnn=cnnAddConvLayer(cnn, 9, [5 5], 'rect');
%  cnn=cnnAddPoolLayer(cnn, 2, 'mean');
% cnn=cnnAddConvLayer(cnn, 15, [5 5], 'rect');
%  cnn=cnnAddPoolLayer(cnn, 2, 'mean');
%  cnn=cnnAddConvLayer(cnn, 21, [5 5], 'rect');
%  cnn=cnnAddPoolLayer(cnn, 2, 'mean');
% 
% cnn=cnnAddFCLayer(cnn,300, 'tanh' ); %add fully connected layer
% cnn=cnnAddFCLayer(cnn,3, 'sigm' ); %add fully connected layer % last layer no of nodes = no of lables

train_y = zeros([6 240]);
no_of_epochs = 2;
batch_size=3;
display 'training started...Wait for ~200 seconds...'
 
cnn=traincnn(cnn,train_x,train_y, no_of_epochs,batch_size);
%%
k=0;
d=dir(Datapath1);
for j=63:82
    if not(strcmp(d(j).name,'.')|strcmp(d(j).name,'..'))  
        f=dir(strcat(Datapath1,d(j).name));
        for i=1:size(f,1)
            %I=imread(fullfile(Datapath, wiki.full_path{i}));
            %st = sprintf('%s',f(i).name);
             if not(strcmp(f(i).name,'.')|strcmp(f(i).name,'..'))  
                I=imread(fullfile(Datapath1,d(j).name,f(i).name));
                  if(size(I,5) > 1)
                    I = rgb2gray(I);
            %         M=I;
            %         I(:,:,1)=M;
            %         I(:,:,2)=M;
            %         I(:,:,3)=M;
                 end
                I = imresize(I, [h w ] );
                %I = rescale(double(I))/2;
                %I = I - mean(I(:));
                k = k+1;
                test_x(:,:,k)=I;
                %k = k+1;
             end
        end 
    end
end

test_y = zeros([6 60]);
testcnn(cnn,test_x,test_y);
%display '...predicting gender..'
%[a l1]=predictcnn(cnn, test_x);
%for i=1:size(test_x, 3)
%    if l1(i) == 1
%        str=sprintf('f (%d).jpg looks alike female with prob. %f\n', i, a(i));
%        display(str)
%    elseif l1(i) == 2
%        str=sprintf('f (%d).jpg looks alike male with prob. %f\n', i, a(i));
%        display(str)
%     elseif l1(i) == 3
%        str=sprintf('f (%d).jpg looks alike monkey with prob. %f\n', i, a(i));
%        display(str)
%    end
%end


toc