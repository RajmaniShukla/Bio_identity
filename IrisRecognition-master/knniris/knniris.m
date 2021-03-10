%KNN_IRIS Summary of this scriptt goes here
%   1: Load iris.mat file which contains Iris data and its label
%      seperately. 
%   2: Randomize the order of data for each iternation so that new sets of
%      training and test data are formed.
%     
%      The training data is of having size of Nxd where N is the number of
%      measurements and d is the number of variables of the training data.
%  
%      Similarly the size of the test data is Mxd where M is the number of
%      measurements and d is the number of variables of the test data.

%   3: For each observation in test data, we compute the euclidean distance
%      from each obeservation in training data.
%   4: We evalutate 'k' nearest neighbours among them and store it in an
%      array.
%   5: We apply the label for which distance is minimum
%       5.1: In case of a tie, we randomly label the class.
%   6: Return the class label.
%   7: Compute confusion matrix.
%----------------Program Code starts below--------------------------

clear all;
clc;

% Step 1
load iris.mat;

%Step 2: Randomizing and dividing data into 1:1 ratio for training and
%testing

split=0;
count=0;
while(count~=1)
    numofobs=length(irisdata);
    rearrangement= randperm(numofobs);
    newirisdata=irisdata(rearrangement,:);
    newirislabel=irislabel(rearrangement);
    split = ceil(numofobs/2);
    count=count+1;
end
iristrainingdata = newirisdata(1:split,:);
iristraininglabel = newirislabel(1:split);
iristestdata = newirisdata(split+1:end,:);
originallabel = newirislabel(split+1:end);

numoftestdata = size(iristestdata,1);
numoftrainingdata = size(iristrainingdata,1);

for sample=1:numoftestdata
    %Step 3: Computing euclidean distance for each testdata
    euclideandistance = sum((repmat(iristestdata(sample,:),numoftrainingdata,1)-iristrainingdata).^2,2);
        
    %Step 4: compute k nearest neighbors and store them in an array
    [dist position] = sort(euclideandistance,'ascend');
    nearestneighbors=position(1:4);
    nearestdistances=dist(1:4);
    
    % Step 5: We apply the label for which distance is minimum
            %Step 5.1: In case of a tie, we randomly label the class.
    if(nearestdistances(1)<nearestdistances(2))
        iristestlabel(sample)=iristraininglabel(position(1));
    end
    
    if (nearestdistances(1)==nearestdistances(2)&&nearestdistances(1)<nearestdistances(3))
            index=randi(2,1,1);
            iristestlabel(sample)=iristraininglabel(position(index));
    end
        
    if (nearestdistances(1)==nearestdistances(2)&&nearestdistances(2)==nearestdistances(3)&&nearestdistances(3)<nearestdistances(4))
            index=randi(3,1,1);
            iristestlabel(sample)=iristraininglabel(position(index));
    end
        
    if (nearestdistances(1)==nearestdistances(2)&&nearestdistances(2)==nearestdistances(3)&&nearestdistances(3)==nearestdistances(4))
            index=randi(4,1,1);
            iristestlabel(sample)=iristraininglabel(position(index));
    end
end

%Step 7: Confusion Matrix
originallabel=originallabel';
[confusionmatrix order]=confusionmat(originallabel,iristestlabel);
accuracy=(confusionmatrix(1,1)+confusionmatrix(2,2)+confusionmatrix(3,3))/sum(sum(confusionmatrix));

gscatter(irisdata(:,2),irisdata(:,4),irislabel);

clear count,
clear numofobs,
clear numoftestdata,
clear numoftrainingdata,
clear sample,
clear newposition,
clear split,
clear euclideandistance,
clear position,
clear testcount,
clear trainingcount,
clear nearestdistances,
clear nearestneighbors,