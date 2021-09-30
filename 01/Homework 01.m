%% Fall 2021. BMED318

%% PART 01.
%{

clear all
close all

N = 5
v = [1 0 0]
v = [1;2;3]
v = v'
v = pi*[-4:4]/4
v = []

m = [1 2 3;4 5 6]

m = zeros(2,3)
v = ones(1,3)
m = eye(3)
v = rand(3,1)

matric_data = [2 3 4;5 6 7;1 2 3];
v = [1 2 3];
v(3)

m = [1 2 3;4 5 6]
m(1,3)
m(2,:)
m(:,1)

size(m)
size(m,1)
size(m,2)

m1 = zeros(size(m))

who
whos

% Simple operations and vectors and matrices 
% (A) Pointwise operations:

a = [1 2 3 4];
2*a
a/4
b = [5 6 7 8];
a + b
a - b
a.^2
a.*b
a./b

log([1 2 3 4])
round([1.5 2;2.2 3.1])

% (B) Vector operations:

a = [1 4 6 3]
sum(a)
mean(a)
var(a)
std(a)
max(a)

a = [1 2 3;4 5 6]
mean(a)
max(a)
max(max(a))
max(a(:))

% (C) Matrix operations:

[1 2 3]*[4 5 6]'
[1 2 3]'*[4 5 6]
a = rand(3,2)
b = rand(2,4)
c = a*b

a = [1 2;3 4;5 6]
b = [5 6 7];
b*a
a'*b'

% (4) Plotting:

x = [0 1 2 3 4];
plot(x);
plot(x,2*x);
axis([0 8 0 8]);

x = [0 1 2 3 4];
stem(x);
stem(x,2*x);
axis([0 8 0 8]);

x = pi*[-24:24]/24;
plot(x,sin(x));
xlabel('radians');
ylabel('sin value');
title('dummy');

figure;
subplot(1,2,1);
plot(x,sin(x));
axis square;
subplot(1,2,2);
plot(x,2.*cos(x));

figure;
plot(x,sin(x));
hold on;
plot(x,2.*cos(x),'--');
legend('sin','cos');
hold off;

%}

%% PART 02. Matrix Manipulation
% 01.
clc; clear all; close all;

A = [1 2 3; 4 5 6; 7 8 9]

% 02.
size(A)
whos A

% 03.
A(2,2)

% 04.
A(:,3)

% 05.
A(3,:)

% 06.
A(3,:)'

% 07.
A(4,:) = [10 11 12]

% 08.
[A_row, A_col] = size(A);
verse_A = zeros(size(A));
for i = 1:A_row
    verse_A(A_row - i + 1,:) = A(i,:);
end
verse_A

% 09.
B = A(1:3, 1:2)

% 10.
C = uint8(255*rand(8,8))

% 11.
size(C)
max(max(C))
min(min(C))

% 12.
D = zeros(size(C))

% 13.
[row, col] = find(C >= 128)
for i = 1:size(row)
    D(row(i), col(i)) = C(row(i), col(i));
end
D

%% PART 03. Simple Signal, if and for statements.
% 01.
tt = 0:100;
x1 = 7*cos(2*pi*0.5*tt)
x2 = 3*cos(2*pi*0.01*tt + 0.25*pi)

% (1)
figure;
subplot(2,2,1); plot(x1, tt);
% (2)
subplot(2,2,2); plot(x2, tt);
% (3)
subplot(2,2,3); plot(x1 + x2, tt);
% (4)
subplot(2,2,4);
hold on; 
plot(x1, tt, 'r');
plot(x2, tt, 'b');
plot(x1 + x2, tt, 'g');
hold off;

% 02.
ans = 0;
for i = 3:10;
    ans = ans + 2^i;
end
ans

% 03.
ans = 0;
i = 3;
while i<11
    ans = ans + 2^i;
    i = i+1;
end
ans

%% PART 04. Function & File IO.
% 01.
v = [3 5 -2 5 -1 0]

% (1)
u = zeros(size(v))
[row, col] = find(v>0); % vector v 에서 0보다 큰 값 찾기(find).
[r, c] = size(col);     % 0보다 큰 값의 갯수 = column.
for i = 1:c
    u(row(i), col(i)) = v(row(i), col(i));
end
u
% (2)
[v_row, v_col] = size(v);   % vector v의 사이즈 구하기.
u = zeros(size(v));         % vector v와 같은 사이즈의 vector u 만들기.
for i = 1:v_col
    if(v(1, i) > 0)         % vector v 값이 0보다 클 때. vector u 에 해당 값 넣기.
        u(1, i) = v(1, i)
    else                    % vectro v 값이 0이거나, 그보다 작을 때. vector u = 0.
        u(1,i) = 0; 
    end
end
u
% (3),(4)
u = zeros(size(v))
u = thres(v);
u
% (5)
v2 = [-4 2 -5 3 -2 0 1000]
u2 = zeros(size(v2));
u2 = thres(v2);
u2

% 02.(1)
im = load('lenna.txt', 'ASCII');
% (2)
figure;
imshow(im, []);
% (3)
save('lenna.mat', 'im');

%% PART 05. Simple Image Processing.
% 01.(1)
ori_image = imread('chest_xray.jpg');
% (2)
size(ori_image)
max_value = max(max(ori_image))
min_value = min(min(ori_image))
% (3)
rev_image = zeros(size(ori_image));
% (4)
for i = 1:493 % rev_image = [493, 600]
    for j = 1:600
        rev_image(i, j) = max_value - ori_image(i, j);
    end
end
% (5)
figure;
hold on;
subplot(1,2,1); imshow(ori_image);
subplot(1,2,2); imshow(rev_image, []);
hold off;
% (6)
imwrite(rev_image, 'chest_xray.out.jpg');
% (7)
whos rev_image  % class double.
imwrite(uint8(rev_image), 'chest_xray.out.jpg'); % double type -> uint8 type 으로 변경 시 imwrite 오류없이 됨.
figure; imshow('chest_xray.out.jpg');


% 02.(1)
image1 = imread('lenna.bmp');
figure; hold on;
subplot(2,2,1); imshow(image1);
% (2)
size_image1 = size(image1)
mean_image1 = mean(mean(image1))
% (3)
image2 = zeros(size(image1));
% (4)
for i = 1:256
    for j = 1:256
        if(image1(i,j) < mean_image1)
            image2(i,j) = 0;
        else
            image2(i,j) = image1(i,j);
        end
    end
end
image2
% (5)
hold on;
subplot(2,2,2); imshow(image2);
% (7)
hold on;
image3 = func1(image1);
subplot(2,2,3); imshow(image3);
hold off;
