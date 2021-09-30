%% Fall 2021. BMED318. hw02.

%% 01. Types of Digital Image & File I/O.
clc, clear all, close all;

% (1)
lena_double = load('lena.txt');
% (2)
lena_gray = imread('lena.bmp');
% (3)
korea = imread('koreaUniversity.jpg');
% (4)
figure, imshow(korea);
% (5)
% R plane 만 보였을 때, '고려'보다 '대학교'가 더 선명하고 진하게 출력이 되었다.
figure;
subplot(3,1,1), imshow(korea(:,:,1)), title('R channel');
subplot(3,1,2), imshow(korea(:,:,2)), title('G channel');
subplot(3,1,3), imshow(korea(:,:,3)), title('B channel');
% (6)-a/b
korea_gray = RGB_to_gray(korea);
% (6)-c
korea_gray2 = rgb2gray(korea);
% (6)-d
imwrite(korea_gray2, 'korea_gray.jpg');
% (6)-e
% koreaUniversity.jpg 보다 korea_gray.jpg의 사이즈가 더 작다.
imfinfo('koreaUniversity.jpg')  % fileSize : 12501
imfinfo('korea_gray.jpg')       % fileSize : 8486
% (7)
figure;
subplot(1,2,1), imshow(lena_double);
subplot(1,2,2), imshow(lena_gray);
% (8)
% []를 사용하여 lena_double 의 픽셀 값에 따라, 디스플레이를 스케일링하여 회색조 이미지로 나타낸다.
% lena_double은 double, lena_gray는 uint8 이기에 [] 유무에 따라 출력차가 존재한다.
% (9)
lena_int = uint8(lena_double);
% (10)
figure;
subplot(1,2,1), imshow(lena_int);
subplot(1,2,2), imshow(lena_gray);


%% 02. Image Negative.
% (1)
ori_image = imread('chest_xray.jpg');
% (2)
[row, col] = size(ori_image)
min_value = min(min(ori_image))
max_value = max(max(ori_image))
% (3)
rev_image = zeros(size(ori_image));
% (4)
for i = 1:row
    for j = 1:col
        rev_image(i,j) = max_value - ori_image(i,j);
    end
end
% (5)
figure;
subplot(1,2,1), imshow(ori_image);      % uint8
subplot(1,2,2), imshow(rev_image, []);  % double
% (6)
imwrite(uint8(rev_image), 'rev_image.bmp', 'bmp');


%% 03. Image Thresholding.
% (1)
[row2, col2] = size(lena_gray)
mean = mean(mean(lena_gray))
% (2)
lena_gray2 = zeros(size(lena_gray));
lena_gray3 = zeros(size(lena_gray));
% (3)
[row3, col3] = find(lena_gray >= mean);
for i = 1:size(row3)
    lena_gray2(row3(i), col3(i)) = lena_gray(row3(i), col3(i));
end
% (4)
lena_gray3 = func1(lena_gray);
% (5)
% threshold = 128 을 기준으로 하여, 128 보다 클 때(>128) '1', 작거나 같을 때(<=128) ' 0'으로
% 설정. lena 이미지에 128보다 큰 값이 더 적은 빈도로 있어(0이 많다) 검은 그림이 보인다.
figure;
subplot(1,2,1), imshow(lena_gray2);
subplot(1,2,2), imshow(lena_gray3);
% (6)
imwrite(lena_gray3, 'binary.png', 'png');


%% 04. Sampling.
% (1)-a
lena2 = imresize(lena_gray, 1/2);
% (1)-b
lena3 = imresize(lena_gray, 1/4);
% (1)-c
lena4 = imresize(lena_gray, 1/8);
% (2)
lena2 = imresize(lena2, size(lena_gray));
lena3 = imresize(lena3, size(lena_gray));
lena4 = imresize(lena4, size(lena_gray));
% (3)
figure;
subplot(2,2,1), imshow(lena_gray);
subplot(2,2,2), imshow(lena2);
subplot(2,2,3), imshow(lena3);
subplot(2,2,4), imshow(lena4);
% (4)
% 원본 이미지와 비교하였을 때, 가장 유사하게 복원된 이미지는 lena2이다. 그 다음으로 lena3, lena4 순이다.
% lena4는 원본 이미지를 1/8 사이즈로 축소 후 다시 복원한 이미지로, 과한 축소로 픽셀 값의 손상(유실)이 너무 많이 되어
% 원본상태(lena_gray)로 돌리는데 에로사항이 있다.


%% 05. Bit plane.
% (1)
bp0 = mod(lena_gray,2);
bp1 = mod(floor(lena_gray/2),2);
bp2 = mod(floor(lena_gray/4),2);
bp3 = mod(floor(lena_gray/8),2);
bp4 = mod(floor(lena_gray/16),2);
bp5 = mod(floor(lena_gray/32),2);
bp6 = mod(floor(lena_gray/64),2);
bp7 = mod(floor(lena_gray/128),2);
% (2)
lena_re1 = bp7 + bp6;
% (3)
lena_re2 = bp7 + bp6 +bp5 + bp4;
% (4)
lena_re3 = bp4 + bp3 + bp2 + bp1 + bp0;
% (5)
figure;
subplot(2,2,1), imshow(lena_gray);
subplot(2,2,2), imshow(lena_re1, []);
subplot(2,2,3), imshow(lena_re2, []);
subplot(2,2,4), imshow(lena_re3, []);
% (6)
% lena_re1이 원본 이미지에 가장 근접한 윤곽을 가졌다. 왜냐하면 lena_re1에 포함된 bp7는 most
% sig​nificant b​it plane(MSB)와 bp6으로 이뤄져 있기 떄문이다.


%% 06. Exercises.
% (1)
img = imread('pears.png');
% (1)-a
whos img    % image class : uint8
% (1)-b
img_size = size(img)    % 468*732*8
% (1)-c
% 배(pear) 사진이 보인다.
figure; imshow(img);
% (2)
width = hex2dec('012c');    % width = 300
height = hex2dec('00f6');   % height = 246
color_type = hex2dec('00'); % color_type = 0 (grayscale)
% (3)
[e,map] = imread('trees.tif');
figure, imshow(e, map);
egray = ind2gray(e, map);
figure, imshow(egray);
