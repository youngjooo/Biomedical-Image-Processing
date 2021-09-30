function output = RGB_to_gray(input)
% Practice 01.
% 6)-a. function RGB_to_gray()
% RGB image as an input parameter and a gray scale image as an output
% parameter.

output = 0.3*input(:,:,1) + 0.59*input(:,:,2) + 0.11*input(:,:,3);
