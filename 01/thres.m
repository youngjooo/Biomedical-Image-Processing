function u = thres(v)
% PART 04. (3).
% If a value in v is great than 0, move it to u at the same location.
% Otherwise, change the value to 0.
% Perform the same things as 1-1.

u = zeros(size(v));
[row, col] = find(v > 0);

[r, c] = size(col);
for i = 1:c
    u(row(i), col(i)) = v(row(i), col(i));
end