%% Fall 2021. BMED318. hw05.


%% 01. LoG filter
clc, close all, clear all;
% (a)
bw = imread('brain_whitenoise.jpg');
% (b)
f1 = fspecial('log', [7 7], 0.5);
% (c)
cf1 = filter2(f1, bw);
% (d)
f2 = fspecial('laplacian', 0.01);
% (e)
cf2 = filter2(f2, bw);
% (f)
figure('Name', 'LoG filter');
subplot(1,3,1), imshow(bw); title('Brain whitenoise');
subplot(1,3,2), imshow(cf1/100); title('LoG filter');
subplot(1,3,3), imshow(cf2/100); title('Laplacian filter');
% Q : Describe how the division by 100 affects the displayed images.
% A : imshow는 figure에 회색조 영상을 출력한다. 때문에 [0 255]의 값으로 영상을 출력한다.
% 하지만 영상을 100으로 나눠져 영상이 명암이 더 두드러지게 표현된다(어두운건 더 어둡게 / 밝은건 더 밝게).


%% 02. Median Filter
% (a)
sad1 = imread('sadimg.bmp');
% (b)/(c)
re_sad1 = median_filt(sad1);


%% 03. Interpolation
% (a)
ori = imread('body.jpg');
% (b)
sma = imresize(ori, [32 32]);
% (c)
nea = imresize(sma, size(ori), 'nearest');
% (d)
bil = imresize(sma, size(ori), 'bilinear');
% (e)
bic = imresize(sma, size(ori), 'bicubic');
% (f)
figure('Name', 'Interpolation');
subplot(2,2,1), imshow(ori); title('Original image');
subplot(2,2,2), imshow(nea); title('Nearest interpolation');
subplot(2,2,3), imshow(bil); title('Bilinear interpolation');
subplot(2,2,4), imshow(bic); title('Bicubic interpolation');
% (g)
figure('Name', 'Difference between bil and bic'), imshow(bil - bic,[]);


%% 04. Rotation
% (a)
ori = imread('body.jpg');
% (b)
nrot = imrotate(ori, 30, 'nearest');
% (c)
brot = imrotate(ori, 30, 'bicubic');
% (d)
figure('Name', 'Rotation');
subplot(1,3,1), imshow(nrot); title('Nearest rotation');
subplot(1,3,2), imshow(brot); title('Bicubic rotation');
subplot(1,3,3), imshow((nrot - brot) > 0,[]); title('Difference between nrot and brot');


%% 05. Image geometry
% (a)
sadimg = imread('sadimg2.bmp');
% (b)
sad_res = imresize(sadimg, [350 350]);
sad_rotate = imrotate(sad_res, -30, 'bicubic');
sad_noise = medfilt2(sad_rotate);
% (c)
figure('Name', 'Image geometry');
subplot(1,3,1), imshow('img.jpg'); title('Original image');
subplot(1,3,2), imshow(sadimg); title('Sad image');
subplot(1,3,3), imshow(sad_noise); title('Resultant image');


%% 06. Image geometry: Affine transform
% (a)
affined_img = imread('affined_img.bmp');
% (b)
aff_rot = imrotate(affined_img, -30);
aff_shear = imwarp(aff_rot, invert(affine2d([1 0.5 0;0 1 0;0 0 1])));
% (c)
figure('Name', 'Image geometry');
subplot(2,2,1), imshow('img.jpg'); title('Original image');
subplot(2,2,2), imshow(affined_img); title('Affined image');
subplot(2,2,3), imshow(aff_rot); title('After rotation');
subplot(2,2,4), imshow(aff_shear); title('After shear');

