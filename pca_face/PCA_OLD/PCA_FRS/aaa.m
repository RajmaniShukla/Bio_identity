storedStructure = load('face_images.mat');
 test_ids = storedStructure.test_ids;
 test_imgs = storedStructure.test_imgs;
 train_ids = storedStructure.train_ids;
 train_imgs = storedStructure.train_imgs;
 %nonface_imgs = storedStructure.nonface_imgs;

 test_ids = imread('D:\New folder (2)\Project\PCA_FRS\TestDatabase\13.jpg');
 test_imgs = imread('D:\New folder (2)\Project\PCA_FRS\TestDatabase\13.jpg');
 train_ids = imread('D:\New folder (2)\Project\PCA_FRS\TestDatabase\13.jpg');
 train_imgs = imread('D:\New folder (2)\Project\PCA_FRS\TestDatabase\13.jpg');
 %nonface_imgs = imread('D:\New folder (2)\Project\PCA_FRS\TestDatabase\12.jpg');

save('face_images.mat', 'test_ids', 'test_imgs', 'train_ids', 'train_imgs' );