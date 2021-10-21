function J = median_filt(I)
% 02. Median Filter - (b)
% perform the same function medfilt2().

% Check input image size.
[r,c] = size(I);
% Define the window size(5 * 5).
M = 5;
% Define pad size and pixel size, output image size.
pad_size = floor(M/2);
pixels = zeros(M.^2, 1);
J = zeros(r,c);

pad_image = padarray(I, [pad_size pad_size], 0, 'post');
pad_iamge = padarray(I, [pad_size pad_size], 0, 'pre');

[pad_r, pad_c] = size(pad_image);

for i = 1 + pad_size : pad_r - pad_size
    for j = 1 + pad_size : pad_c - pad_size
        idx = uint8(1);
        
        for hx = i - pad_size : i + pad_size
            for hy = j - pad_size : j + pad_size
                pixels(idx) = uint8(pad_image(hx, hy));
                idx = idx + 1;
            end
        end
        sort_pixel = sort(pixels);
        median_val = median(sort_pixel);
        J(i - pad_size, j - pad_size) = median_val;
    end
end

figure('Name', 'Median filter');
subplot(1,2,1), imshow(I); title('Original sad image');
subplot(1,2,2), imshow(J,[]); title('Apply median filter');

end