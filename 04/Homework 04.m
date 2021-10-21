%% Fall 2021. BMED318. hw04.


%% 00. Find the difference of conv2, filter2, imfilter functions in matlab by using help command.
% conv2
% conv2(a,b)는 a,b의 2차원 합성곱(convolution)을 출력한다. 때문에 conv2(a,b) !=
% conv2(b,a)이다. perform convolution.

% filter2
% filter2(H,X)는, 행렬 H의 계수에 따라 행렬 X에 유한 임펄스 필터를 적용한다.
% perform correlation(상관).

% imfilter
% imfilter(A,h)는, 다차원 필터 h를 사용하여 다차원 배열 A를 필터링한 결과를 출력한다.
% imfilter는 입력 영상 배열과 동일한 데이터형의 배열을 출력한다는 점에서, 일부 다른 필터링 함수보다 
% 메모리 사용이 더 효율적이다. options으로 'corr'과 'conv'를 지정할 수 있다. corr는 filter2가 수행하는 동일한 출력 방식이다.
% default 값은 corr(상관)이다.


%% 01.Read the image file ‘roundImage.png’ and store it into ‘ri’ variable. (imread())
clc; clear all; close all;
ri = imread('roundImage.png');

%% 02.Low pass filter
% (a)
af = fspecial('average', 15);
% (b)
afr = filter2(af, ri);
% (c)
figure;
subplot(1,2,1), imshow(ri,[]); title('roundImage');
subplot(1,2,2), imshow(afr,[]); title('Average filter');
% (d)
figure, plot(ri(:,128)), hold on, plot(afr(:, 128),'--'), hold off;
% (e)
% blue line은 ri plot, red line은 afr plot이다. ri plot은 어떠한 지점에서 급격한 값
% 변환(0->255)를 보이지만, afr plot은 완만한 값 변환(수직 상승 x, 기울기 존재)를 보인다.
% 이는 앞선 이미지에서 경계선에 대한 선명도 차이로 볼 수 있다(뚜렷한 경계선).


%% 03.Filter genaration: make filters using fspecial() and check the value of filters.
% (a) gaussian filter
gf = fspecial('gaussian', 3, 0.5);
% (b) laplacian filter
lf = fspecial('laplacian', 0.5);
% (c) prewitt filter
% 세로 방향 기울기를 근사하여 가로 방향 경계를 강조하는 3×3 필터를 반환.
pf = fspecial('prewitt');
% (d) sobel filter
% 세로 방향 기울기를 근사하여 평활화 효과를 사용해 가로 방향 경계를 강조하는 3×3 필터를 반환.
sf = fspecial('sobel');


%% 04.Directional filters: ‘sobel’ and ‘prewitt’ are basic high pass filters with directional property.
% (a)
sfr1 = filter2(sf, ri);
pfr1 = filter2(pf, ri);
% (b)
figure;
subplot(1,2,1), imshow(sfr1,[]); title('Sobel filter');
subplot(1,2,2), imshow(pfr1,[]); title('Prewitt filter');
% (c)
sfr2 = edge(ri,'sobel');
pfr2 = edge(ri,'prewitt');
% (d)
df = abs(sfr2 - pfr2);
% (e)
figure;
subplot(1,3,1), imshow(sfr2); title('Sobel filter');
subplot(1,3,2), imshow(pfr2); title('Prewitt filter');
subplot(1,3,3), imshow(df); title('Difference');
% Q : Think about difference between sobel and prewitt filters.
% A : 육안으로 구분하기 어렵다. 
% sobel filter는 prewitt filter의 단점을 극복한 필터로, 수평+수직+대각선 에지도 검출 가능하다.
% 즉, 모든 방향의 에지를 검출하기에 적합하다. prewitt filter는 수평+수직 에지를 검출한다.


%% 05.Application of high pass filter.
% (a)
chest = im2double(imread('chest.png'));
% (b)
lfChest = filter2(lf, chest);
% (c)
new_chest = chest - lfChest;
% (d)
figure;
subplot(1,3,1), imshow(chest); title('Chest');
subplot(1,3,2), imshow(lfChest,[]); title('lfChest');
subplot(1,3,3), imshow(new_chest); title('new-chest');
