function output = hequal(input)
% Histogram Equalization. Practice (4). 
% output = 출력영상, input = 입력이미지.

output = zeros(size(input));
[height, width] = size(input);

[cnt, loc] = imhist(input);

% Perform pixel grayscale statistics
NumPixel = zeros(1,256);
for i = 1:height
    for j = 1:width
        NumPixel(input(i,j)+1) = NumPixel(input(i,j)+1)+1;
    end
end

% Calculate the gray distribution density
ProbPixel = zeros(1,256);
for i =1:256
	ProbPixel(i) = NumPixel(i)/(height*width*1.0);
end

% Calculate cumulative histogram distribution
CumuPixel = zeros(1,256);
for i = 1:256
	if i == 1
        CumuPixel(i) = ProbPixel(i);
    else
        CumuPixel(i) = CumuPixel(i-1) + ProbPixel(i); %Accumulate
	end
end

% Cumulative distribution rounded
CumuPixel = uint8(256* CumuPixel);

% Mapping the gray value (equalization)
for i = 1:height
	for j = 1:width
        output(i,j)= CumuPixel(input(i,j)+1);
    end
end

output = uint8(output);