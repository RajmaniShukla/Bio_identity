function [test_ids,test_imgs,train_ids,train_imgs,nonface_imgs]=load_data()
%load_data: load face_images and nonface_images, and display samples of
%both datasets. There is a directory called visualization will contain all
%figures.
%Usage:
%       [test_ids,test_imgs,train_ids,train_imgs,nonface_imgs]=load_data();
%Output:
%       - test_ids: (1520x1) uint8 array that contains the the identity of
%       the persons in the testing images
%       - test_imgs: 1520 (180x200 pixels) testing images
%       - train_ids: (1520x1) uint8 array that contains the ids for the 
%       persons in the testing images
%       training images.
%       - train_imgs: 1520 (180x200 pixels) training images
%       - nonface_imgs: 100 (200x180 pixels) non-face images (false
%       samples)
load('face_images.mat');
load('nonface_images.mat');
%create new directory for visualization 
  if  exist('visualization','dir')==0
        mkdir('visualization')
    end
    
   
%get random face samples from testing set
figure('units','normalized','outerposition',[0 0 1 1]) %full screen
for i=1:6
    num=round(rand*(size(test_imgs,1)-1))+1;
    img(:,:)=test_imgs(num,:,:);
    subplot(2,3,i);
    imshow(img,[]);
    title(sprintf('image number %d',num));
end
axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off',...
    'Visible','off','Units','normalized', 'clipping' , 'off');
t=text(0.5, 1,'\bf Samples from testing faces','HorizontalAlignment',...
    'center','VerticalAlignment', 'top');
t.FontSize = 12;
print('visualization\\Samples_testing.png','-dpng');
     
  
%get random face samples from training set
figure('units','normalized','outerposition',[0 0 1 1]) %full screen
for i=1:6
    num=round(rand*(size(train_imgs,1)-1))+1;
    img(:,:)=train_imgs(num,:,:);
    subplot(2,3,i);
    imshow(img,[]);
    title(sprintf('image number %d',num));
end
axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off',...
    'Visible','off','Units','normalized', 'clipping' , 'off');
t=text(0.5, 1,'\bf Samples from training faces','HorizontalAlignment',...
    'center','VerticalAlignment', 'top');
t.FontSize = 12;
print('visualization\\Samples_training.png','-dpng');
%get random face samples from non-face images
figure('units','normalized','outerposition',[0 0 1 1]) %full screen
for i=1:6
    num=round(rand*(size(nonface_imgs,1)-1))+1;
    img(:,:)=nonface_imgs(num,:,:);
    subplot(2,3,i);
    imshow(img,[]);
    title(sprintf('image number %d',num));
end
axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off',...
    'Visible','off','Units','normalized', 'clipping' , 'off');
t=text(0.5, 1,'\bf Samples from non-face images','HorizontalAlignment',...
    'center','VerticalAlignment', 'top');
t.FontSize = 12;
print('visualization\\Samples_nonface_imgs.png','-dpng');
end
