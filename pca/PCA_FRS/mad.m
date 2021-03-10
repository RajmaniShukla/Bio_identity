function result = mad(filename)
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%STEP 1
%Load data and calculate the mean face
%load data
display('loading data...');
[test_ids,test_imgs,train_ids,train_imgs,nonface_imgs]=load_data();
%calculate the average face
display('calculate the average face...');
avg_face=getAvgFace(train_imgs);
%get the size of the original images (all datasets have images with the
%same dimensions)
img_size=[size(train_imgs,2),size(train_imgs,3)];
%get the number of samples in the training data
n=size(train_imgs,1);
%Too much figures..ask for closing figures of step1
choice = questdlg('would you like to close all figures of step1?', ...
    'Step1', ...
    'Yes','No','No');
% Handle response
switch choice
    case 'Yes'
        close all
end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%STEP 2
%get principle components W and the N latent coordinates
%resize data to be (height*width)xN matrix
train_imgs=(reshape(train_imgs,[size(train_imgs,1),size(train_imgs,2)*...
    size(train_imgs,3)]))';
nonface_imgs=(reshape(nonface_imgs,[size(nonface_imgs,1),size(nonface_imgs,2)*...
    size(nonface_imgs,3)]))';
test_imgs=(reshape(test_imgs,[size(test_imgs,1),size(test_imgs,2)*...
    size(test_imgs,3)]))';
avg_face=avg_face(:); %resize the mean to be (height*width)x1 vector
display('calculate the principal components...');
[W,X,L]=PCA_(train_imgs,avg_face); %get the principle components
%get the bound of x axis in plots
m=length(L);
%Scree Plot
figure;
plot(L);
title('Scree Plot');
ylim([-200,max(L(:))])
xlim([-50,m])
xlabel('Index of Eigenvalues') % x-axis label
set(gca,'XTickLabel',num2str(get(gca,'XTick').')) %to avoid x10^k
ylabel('Eigenvalues') % y-axis label
set(gca,'YTickLabel',num2str(get(gca,'YTick').')) %to avoid x10^k
print('visualization\\ScreePlot','-dpng');  %save it
%Fraction of Variance (FVE)
FVE=cumsum(L(:))/sum(L(:)); %calc FVE
%plot FVE
figure;
plot(FVE);
title('Fraction of Variance Explained');
xlabel('c') % x-axis label
ylabel('FVE') % y-axis label
ylim([min(FVE(:)),1])
print('visualization\\FVE','-dpng');  %save it
%Plot first 10 principle components (Eigenvectors)
figure('units','normalized','outerposition',[0 0 1 1]) %full screen
for i=1:10
    subplot(2,5,i);
    imshow(reshape(W(:,i),img_size(1),img_size(2)),[]);
    colormap(jet);
    title(sprintf('Eigenvector %d',i));
end
print('visualization\\10EigenVectors','-dpng'); %save it
%reconstruct the data
%pick random image
num=round(rand*n-1)+1;
%reconstruct the original images using few number of basis vectors
figure('units','normalized','outerposition',[0 0 1 1]) %full screen
j=2;
subplot(2,5,1);
imshow(reshape(train_imgs(:,num),img_size(1),img_size(2)),[]);
title('original image');
for i=5:10:90
    display(sprintf('reconstructing the data using only the first %d basis vectors...',i));
    X=W(:,1:i)'*(train_imgs(:,num)-avg_face); %recalculate X
    Y=(W(:,1:i)*X)+avg_face; %reconstruct the image using (i)th basis vectors
    subplot(2,5,j); j=j+1;
    imshow(reshape(Y,img_size(1),img_size(2)),[]);
    title(sprintf('Using %d principal components',i));
end
print('visualization\\reconst_low','-dpng'); %save it
%find the smallest dimensionality such that at least 90% of the variance is
%explained
alpha=0.9;
indices=find(FVE>=alpha); %pick all c values (number of dimentions) that
%satisfy the condition >= alpha
index=indices(1); %get the first one
display(sprintf('The smallest dimensionality that explain at least 90%s of the variance=%d','%',index));
%Too much figures..ask for closing figures of step2
choice = questdlg('would you like to close all figures of step2?', ...
    'Step2', ...
    'Yes','No','No');
% Handle response
switch choice
    case 'Yes'
        close all
end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%STEP 3
%Reconstruction using low dimensionality data
%calculate the latent coordinates using only the first 115 principle
%components.
%we can compute the first c(th) principle components using:
%[W,X,L]=PCA_(train_imgs,avg_face,index); %get the first (index=value) principle components
%or..
W=W(:,1:index); %discard principle components starting from the basis vector after (index)
X=W'*(train_imgs-repmat(avg_face,[1,n])); %recalculate X
%reconstruct face images (training set)
display('reconstructing face images...');
%Y=sqrt(n)*(W*X)+repmat(avg_face,[1,n]);
Y=(W*X)+repmat(avg_face,[1,n]);
%reconstruct nonface images
display('reconstructing non-face images...');
%avg_nonface(:,:)=mean(nonface_imgs,2); %get mean of non face images
X_nonfaces=W'*(nonface_imgs-repmat(avg_face,[1,size(nonface_imgs,2)])); %recalculate X
Y_nonface=(W*X_nonfaces)+repmat(avg_face,[1,size(nonface_imgs,2)]); %reconstruct
%compute the absolute difference images of training face images
diff_face=abs(Y-train_imgs);
%compute the squared reconstruction error of training face images
error_face=(sum((Y-train_imgs).^2,1));
%compute the absolute difference images of non-face images
diff_nonface=abs(Y_nonface-nonface_imgs);
%compute the squared reconstruction error of non-face images
error_nonface=(sum((Y_nonface-nonface_imgs).^2,1));
%show 5 random samples from reconstructed faces and reconstructed non-faces
%images
%pick 5 reconstructed face images
for i=1:5
    
    figure('units','normalized','outerposition',[0 0 1 1]) %full screen
    num=round(rand*n-1)+1;
    %original image
    ax1 =subplot(1,3,1);
    imshow(reshape(train_imgs(:,num),img_size(1),img_size(2)),[]);
    title(sprintf('original image# %d',num));
    colormap(ax1,gray);
    %reconstructed image
    ax2=subplot(1,3,2);
    imshow(reshape(Y(:,num),img_size(1),img_size(2)),[]);
    title('reconstructed image');
    colormap(ax2,gray);
    %abs error
    ax3=subplot(1,3,3);
    imshow(reshape(diff_face(:,num),img_size(1),img_size(2)),[]);
    title('abs error');
    colormap(ax3,jet);
    axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off',...
        'Visible','off','Units','normalized', 'clipping' , 'off');
    %report squared reconstruction error
    t=text(0.5, 1,sprintf('Squared Reconstruction Error: %f',...
        error_face(num)),'HorizontalAlignment',...
        'center','VerticalAlignment', 'top');
    t.FontSize = 12;
    %save it
    print(fullfile('visualization',sprintf('reconst_face_%d',i)),'-dpng');
end
%pick 5 reconstructed non-face images
for i=1:5
    figure('units','normalized','outerposition',[0 0 1 1]) %full screen
    num=round(rand*size(nonface_imgs,2)-1)+1;
    %original image
    ax1=subplot(1,3,1);
    imshow(reshape(nonface_imgs(:,num),img_size(1),img_size(2)),[]);
    colormap gray %restore the gray colormap
    title(sprintf('original image# %d',num));
    colormap(ax1,gray)
    %reconstructed image
    ax2=subplot(1,3,2);
    colormap(ax2,gray);
    imshow(reshape(Y_nonface(:,num),img_size(1),img_size(2)),[]);
    title('reconstructed image');
    %abs error
    ax3=subplot(1,3,3);
    imshow(reshape(diff_nonface(:,num),img_size(1),img_size(2)),[]);
    colormap(ax3,jet);
    title('abs error');
    axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off',...
        'Visible','off','Units','normalized', 'clipping' , 'off');
    %report squared reconstruction error
    t=text(0.5, 1,sprintf('Squared Reconstruction Error: %f',...
        error_nonface(num)),'HorizontalAlignment',...
        'center','VerticalAlignment', 'top');
    t.FontSize = 12;
    %save it
    print(fullfile('visualization',sprintf('reconst_nonface_%d',i)),'-dpng');
end
%picking a threshold value to distinguish between face and non-face images
T=(mean(error_face)+(max(error_face)-mean(error_face))/2+...
    mean(error_nonface)-(mean(error_nonface)-min(error_nonface))/2)/2;
display(sprintf('The suggested threshold value is %f',T));
%Plot reconstruction error for each image (face images)
figure('units','normalized','outerposition',[0 0 1 1]) %full screen
bar(error_face);
title('Squared reconstruction error of each image (face images)');
xlabel('Image number') % x-axis label
ylabel('Squared reconstruction error') % y-axis label
hold on %draw Threshold line
plot([1,length(error_face)],[T,T],'--','LineWidth',4,'color','red');
legend('Squared error','Threshold value')
print(fullfile('visualization','SRE_face'),'-dpng');
hold off
%Plot reconstruction error for each image (non-face images)
figure('units','normalized','outerposition',[0 0 1 1]) %full screen
bar(error_nonface);
title('Squared reconstruction error of each image  (non-face images)');
xlabel('Image number') % x-axis label
ylabel('Squared reconstruction error') % y-axis label
hold on %draw Threshold line
plot([1,length(error_nonface)],[T,T],'--','LineWidth',4,'color','red');
legend('Squared error','Threshold value')
print(fullfile('visualization','SRE_nonFace'),'-dpng');
hold off
%Plot histogram of  squared reconstruction error for face images
figure('units','normalized','outerposition',[0 0 1 1]) %full screen
hist(error_face);
title('Histogram of squared reconstruction error (face images)');
xlabel('Squared reconstruction error') % x-axis label
ylabel('Number of occurrences') % y-axis label
print(fullfile('visualization','hist_face'),'-dpng');
%Plot reconstruction error for each image (non-face images)
figure('units','normalized','outerposition',[0 0 1 1]) %full screen
hist(error_nonface);
title('Histogram of squared reconstruction error (non-face images)');
xlabel('Squared reconstruction error') % x-axis label
ylabel('Number of occurrences') % y-axis label
print(fullfile('visualization','hist_nonface'),'-dpng');
hold off
%classification
display('classification between face images and non-face images using hard thresholding...');
false_nonface_ind=find(error_face>T);
false_face_ind=find(error_nonface<=T);
accuracy=1-((length(false_nonface_ind)+length(false_face_ind))/...
    (size(nonface_imgs,2)+size(train_imgs,2)));
display(sprintf('Classification accuracy= %f%s',accuracy*100,'%'));
%show the misclassified face images (false nonface)
for i=1:length(false_nonface_ind)
    ind=false_nonface_ind(i);
    figure('units','normalized','outerposition',[0 0 1 1]) %full screen
    %original image
    ax1=subplot(1,3,1);
    imshow(reshape(train_imgs(:,ind),img_size(1),img_size(2)),[]);
    colormap gray %restore the gray colormap
    title(sprintf('original image# %d',ind));
    colormap(ax1,gray)
    %reconstructed image
    ax2=subplot(1,3,2);
    colormap(ax2,gray);
    imshow(reshape(Y(:,ind),img_size(1),img_size(2)),[]);
    title('reconstructed image');
    %abs error
    ax3=subplot(1,3,3);
    imshow(reshape(diff_face(:,ind),img_size(1),img_size(2)),[]);
    colormap(ax3,jet);
    title('abs error');
    axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off',...
        'Visible','off','Units','normalized', 'clipping' , 'off');
    %report squared reconstruction error
    t=text(0.5, 1,sprintf('Squared Reconstruction Error: %f',...
        error_face(ind)),'HorizontalAlignment',...
        'center','VerticalAlignment', 'top');
    t.FontSize = 12;
    %save it
    print(fullfile('visualization',sprintf('false_nonface_%d',i)),'-dpng');
end
%show the misclassified non-face images (false face)
for i=1:length(false_face_ind)
    ind=false_face_ind(i);
    figure('units','normalized','outerposition',[0 0 1 1]) %full screen
    %original image
    ax1=subplot(1,3,1);
    imshow(reshape(nonface_imgs(:,ind),img_size(1),img_size(2)),[]);
    colormap gray %restore the gray colormap
    title(sprintf('original image# %d',ind));
    colormap(ax1,gray)
    %reconstructed image
    ax2=subplot(1,3,2);
    colormap(ax2,gray);
    imshow(reshape(Y_nonface(:,ind),img_size(1),img_size(2)),[]);
    title('reconstructed image');
    %abs error
    ax3=subplot(1,3,3);
    imshow(reshape(diff_nonface(:,ind),img_size(1),img_size(2)),[]);
    colormap(ax3,jet);
    title('abs error');
    axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off',...
        'Visible','off','Units','normalized', 'clipping' , 'off');
    %report squared reconstruction error
    t=text(0.5, 1,sprintf('Squared Reconstruction Error: %f',...
        error_nonface(ind)),'HorizontalAlignment',...
        'center','VerticalAlignment', 'top');
    t.FontSize = 12;
    %save it
    print(fullfile('visualization',sprintf('false_face_%d',i)),'-dpng');
end
%Too much figures..ask for closing figures of step3
choice = questdlg('would you like to close all figures of step3?', ...
    'Step3', ...
    'Yes','No','No');
% Handle response
switch choice
    case 'Yes'
        close all
end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%STEP 4
%Face recongition using PCA and KNN
%produce plots of pairs of subspace coe?cients of all face images against
%the first three subjects in the training face-images set
%we?ll produce some plots of the subspace coe?cients but colour coded based
%on subject identity. For the ?rst 3 subjects, we will plot 2D scatter plots
%of pairs of subspace coe?cients of all face images where the points are 
%colour coded based on whether they are of the same person (black) or a 
%di?erent person (yellow). For each subject produce plots of subspace
%dimensions (1,2), (2,3), and (3,4). 
figure('units','normalized','outerposition',[0 0 1 1]) %full screen
for i=1:3
    ind=find(train_ids==i);
    %subspace dimensions (1,2)
    subplot(3,3,1+((i-1)*3));
    %plot yellow dots for all data with size=8
    scatter(X(1,:),X(2,:),8,'MarkerEdgeColor',[1 1 0],'MarkerFaceColor',[1 1 0]);
    hold on
    %plot black dots for subject number i with size=9 to totally hide yellow dots
    scatter(X(1,ind),X(2,ind),9,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 0 0]);
    hold off
    title(sprintf('subject #%d, subspace dimensions (1,2)',i));
   
   %% subspace dimensions (2,3)
    subplot(3,3,2+((i-1)*3));
    scatter(X(2,:),X(3,:),8,'MarkerEdgeColor',[1 1 0],'MarkerFaceColor',[1 1 0]);
    hold on
    scatter(X(2,ind),X(3,ind),9,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 0 0]);
    hold off
    title(sprintf('subject #%d, subspace dimensions (2,3)',i));
  
    %% subspace dimensions (3,4)
    subplot(3,3,3+((i-1)*3));
    scatter(X(3,:),X(4,:),8,'MarkerEdgeColor',[1 1 0],'MarkerFaceColor',[1 1 0]);
    hold on
    scatter(X(3,ind),X(4,ind),9,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 0 0]);
    hold off
    title(sprintf('subject #%d, subspace dimensions (3,4)',i));  
end
%save it
print(fullfile('visualization','subspace_dimensions_subj=1-2-3'),'-dpng');
%classify using K-NN
display('Face recognition using PCA and k-NN');
n_subspaces=10;
%preparing testing data
X_testing=W'*(test_imgs-repmat(avg_face,[1,n])); %calculate  subspace coe?cients X
%perform 1-NN
[predicted_labels,nn_indices,Knn_accuracy]=...
    KNN_(1,X(1:n_subspaces,:)',train_ids,X_testing(1:n_subspaces,:)',test_ids);
display(sprintf('Classification accuracy using 1NN classifier on testing data=%f%s',...
    Knn_accuracy*100,'%'));
%% show the misrecognized images of the face recognition process.
misrecognized_ind=find(predicted_labels~=test_ids);
for i=1:length(misrecognized_ind)
    figure('units','normalized','outerposition',[0 0 1 1]) %full screen
    subplot(2,2,1); %show the original test image
    imshow(reshape(test_imgs(:,misrecognized_ind(i)),[img_size(1),img_size(2)]),[]);
    title('Original test image');
    
    Y_test_img=(W(:,1:n_subspaces)*X_testing(1:n_subspaces,misrecognized_ind(i)))+avg_face; %reconstruct the test image
    subplot(2,2,2); %show the reconstructed image
    imshow(reshape(Y_test_img,[img_size(1),img_size(2)]),[]);
    title('Reconstructed test image');
    
    %find the train image of the wrong label
    ind_train=nn_indices(misrecognized_ind(i));
    subplot(2,2,3); %show the original train image (the wrong label of test image)
    imshow(reshape(train_imgs(:,ind_train),[img_size(1),img_size(2)]),[]);
    title('Original train image');
    
    subplot(2,2,4); %show the reconstructed image
    Y_train_img=(W(:,1:n_subspaces)*X(1:n_subspaces,ind_train))+avg_face; %reconstruct the test image
    imshow(reshape(Y_train_img,[img_size(1),img_size(2)]),[]);
    title('Reconstructed train image');
    %save it
    print(fullfile('visualization',sprintf('misrecognized_face%d',i)),'-dpng');
end
%% now we are repeating the same process, but using incremental number of
%subspaces
acc=zeros(14,1);
count=1;
%% classify using K-NN
for i=5:5:70
if i==1
    s='';
else
    s='s';
end
display(sprintf('Face recognition using PCA and k-NN (%d subspace%s)...',i,s));
n_subspaces=i;
%preparing testing data
X_testing=W'*(test_imgs-repmat(avg_face,[1,n])); %calculate  subspace coe?cients X
%perform 1-NN
[predicted_labels,nn_indices,Knn_accuracy]=...
    KNN_(1,X(1:n_subspaces,:)',train_ids,X_testing(1:n_subspaces,:)',test_ids);
acc(count)=Knn_accuracy;
count=count+1;
end
figure;
plot(5:5:70,acc);
title('Face recognition accuracy using PCA and 1-NN');
xlabel('number of PCA subspaces');
ylabel('Face recognition accuracy');
print(fullfile('visualization','face_rec_accuracy'),'-dpng');
%% Too much figures..ask for closing figures of step4
choice = questdlg('would you like to close all figures of step4?', ...
    'Step4', ...
    'Yes','No','No');
% Handle response
switch choice
    case 'Yes'
        close all
        msgbox('Thank You!')
end
