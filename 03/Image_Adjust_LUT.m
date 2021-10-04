function c = Image_Adjust_LUT(a,b)
% Histogram Stretching. Practice (3). 
% a= 변환하고자 하는 이미지, b=LUT, c= 결과물.

% c = output. 변환한 이미지.
c = zeros(size(a));
aa = 0:255;

N = length(aa); % N = 256.
for i=1:N-1
  pix=find(a >= aa(i) & a < aa(i+1));
  c(pix)=(a(pix)-i)*(b(i+1)-b(i))/(aa(i+1) - aa(i)) + b(i);
end

c = uint8(c);

%% Ver02.
%{
function c = Image_Adjust_LUT(a,b)
% Histogram Stretching. Practice (3). 
% a= 변환하고자 하는 이미지, b=LUT, c= 결과물.

% c = output. 변환한 이미지.
c = zeros(size(a));

N = length(b); % N = 256.
for i=1:N-1
  pix=find(a >= i & a < i+1);
  c(pix)=(a(pix)-i)*(b(i+1)-b(i))/1 + b(i);
end
%}