function m2 = func1(m1)
% PART 05. (6).
% Perform the same things as 2-4.

[m1_row, m1_col] = size(m1);
m1_mean = mean(mean(m1));
m2 = zeros(size(m1));

for i = 1:m1_row
    for j = 1:m1_col
        if (m1(i,j) < m1_mean)
            m2(i,j) = 0;
        else
            m2(i,j) = m1(i,j);
        end
    end
end