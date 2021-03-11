function AvgFc = getAvgFace(training_set,display)
%getAvgFace: calculate the average of the training face images and display
%it
%Usage:
%       image=getAvgFace(training_dataset,1) %for display the average face
%       image
%       image=getAvgFace(training_dataset,0) %for just return the average
%       face without displaying it
%Input:
%       - training_set: training set contains the face images, it should be
%       aligned and has this structure (numberOfImages,height,width)
%       - display: display flag; 1 for display and save the average face, 0
%       for not displaying it. (default = 1)
%Output:
%       - AvgFc: image contains the average of the training face images. 
%checks
if nargin < 1
    error('Too few input arguments.')
elseif nargin < 2
    display=1;
end
AvgFc(:,:)=mean(training_set,1);
if display==1
    figure;
    imshow(AvgFc,[]);
    title('Average face');
    print(fullfile('visualization','avg_face'),'-dpng');
end
end

