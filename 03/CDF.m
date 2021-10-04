function c = CDF(input)
% culmulative distributed function.
% c = output(=cdf).

CumuPixel = zeros(1,256);
for i = 1:length(input)
    CumuPixel(i) = sum(input(1:i));
end

c = CumuPixel/max(CumuPixel);
