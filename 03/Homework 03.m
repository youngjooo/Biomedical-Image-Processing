%% Fall 2021. BMED318. hw03.

%% Histogram Stretching.
% (1)
clc, clear all, close all;

xx = 0:255;
lut1 = 2*xx;
lut2 = (1/2)*xx;
lut3 = -xx+255;
t1 = (32/96)*[1:96]; 
t2 = (160/104)*([97:200]-96) + 32; 
t3 = (63/55)*([200:255]-200) + 192;
lut4 = floor([t1 t2 t3]);

xx = uint8(xx);
lut1 = uint8(lut1);
lut2 = uint8(lut2);
lut3 = uint8(lut3);
lut4 = uint8(lut4);
% (2)
figure;
subplot(2,2,1), plot(xx,lut1); title('LUT1 plot');
subplot(2,2,2), plot(xx,lut2); title('LUT2 plot');
subplot(2,2,3), plot(xx,lut3); title('LUT3 plot');
subplot(2,2,4), plot(xx,lut4); title('LUT4 plot');
% (3)-a/b
x = imread('x-ray.png');
% (3)-c
x1 = Image_Adjust_LUT(x,lut1);
x2 = Image_Adjust_LUT(x,lut2);
x3 = Image_Adjust_LUT(x,lut3);
x4 = Image_Adjust_LUT(x,lut4);
% (3)-d
figure;
subplot(2,2,1), imshow(x1); title('x1 image');
subplot(2,2,2), imshow(x2); title('x2 image');
subplot(2,2,3), imshow(x3); title('x3 iamge');
subplot(2,2,4), imshow(x4); title('x4 image');


%% Histogram Equalization.
% (4)-a
figure, subplot(1,3,1), imshow(x2); subplot(1,3,2), imshow(x2,[]);
% (4)-b/c
x2_eq = hequal(x2);
subplot(1,3,3), imshow(x2_eq);
% Q : 세 영상을 비교하여 차이점을 4장에서 배운 이론을 근간으로 하여 간단히 설명하시오.
% A : 첫 번째는 uint8 typee을 imshow한 영상으로, 0-255 범위의 영상을 출력하였다.
% 두 번째는 같은 uint8 type이지만, 뒤에 []를 붙임으로서 출력 범위에 제한을 둬, grayscale의 min-max 범위의
% 영상이 출력되었다.
% 마지막 세 번째는 histogram equalization을 시행하여, 영상의 모든 grayscale의 빈도수를 맞춘 후
% 출력하였다.

%% Histogram Specification.
% (5)-a
x_ray2 = imread('x_ray2.png');
% (5)-b
x_ray_HE = hequal(x_ray2);
% (5)-c
figure;
subplot(1,2,1), imshow(x_ray2); title('x-ray2 image');
subplot(1,2,2), imshow(x_ray_HE); title('x-ray-HE image');
% (5)-d
load hist_desired.mat
% (5)-e
hist_xray2 = imhist(x_ray2);
% (5)-f
cdf_desired = CDF(hist_desired);
cdf_input = CDF(hist_xray2);
% (5)-g
LUT = uint8(round(255*cdf_desired));
% (5)-h
x_ray_HS = LUT(x_ray2 + 1);
% (5)-i
figure;
subplot(1,3,1), imshow(x_ray2); title('x-ray2 image');
subplot(1,3,2), imshow(x_ray_HE); title('x-ray-HE image');
subplot(1,3,3), imshow(x_ray_HS); title('x-ray-HS image');
% Q : Which one looks better ?
% A : histogram specification을 적용한 x_ray_HS 영상이 더 좋아보인다. 왜냐하면 histogram
% equalization(x_ray_HE)보다 명암이 뚜렷하고 뼈속이 잘 보인다.
