

I = imread('C:\Users\Adarsh\Pictures\matlab\Histogram\face\f1.jpg');
figure(1),imshow(I);
figure(2),
imhist(rgb2gray(I));