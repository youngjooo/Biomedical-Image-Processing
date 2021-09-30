function output = func1(input)
% Practice 03.
% 3). function func1().
% Makes binary image(threshold = 128).

[r,c] = size(input);
output = zeros(size(input));

for i = 1:r
    for j = 1:c
        if (input(i,j) > 128)
            output(i,j) = 1;
        else
            output(i,j) = 0;
        end
    end
end

