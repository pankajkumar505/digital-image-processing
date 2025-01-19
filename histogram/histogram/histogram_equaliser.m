% Created by Pankaj Kumar(BT22ECI060)
% DIP LAB: Experiment 2
% Histogram Equalization without using inbuilt functions

clc;
clear all;
close all;

% Static image path
imagePath = '/MATLAB Drive/rgb_to_grayscale/car.jpeg'; % Update with the actual path and filename

% Read the image
img = imread(imagePath);

% Convert to grayscale if the image is RGB
if size(img, 3) == 3
    gray_img = rgb2gray(img);
else
    gray_img = img;
end

% Get image dimensions
[m, n] = size(gray_img);

% Flatten the image array
img_array = double(gray_img(:));

% Compute the histogram
counts_original = histcounts(img_array, 0:256);

% Compute the cumulative distribution function (CDF)
cdf = cumsum(counts_original);
cdf_min = min(cdf(cdf > 0));  % Minimum non-zero CDF value
L = 255; % Maximum intensity value

% Histogram equalization transformation function
h_v = round(((cdf - cdf_min) / ((m * n) - cdf_min)) * L);

equalized_img = h_v(gray_img + 1);
counts_equalized = histcounts(equalized_img(:), 0:256);

% Display the results
figure;

subplot(2, 2, 1);
imshow(gray_img);
title('Original Image');

subplot(2, 2, 2);
imshow(uint8(equalized_img));
title('Equalized Image');

subplot(2, 2, 3);
bar(0:255, counts_original, 'FaceColor', 'blue', 'EdgeColor', 'none');
title('Original Histogram');
ylabel('Count');
xlabel('Pixel Intensity');
xlim([0, 255]);

subplot(2, 2, 4);
bar(0:255, counts_equalized, 'FaceColor', 'red', 'EdgeColor', 'none');
title('Equalized Histogram');
ylabel('Count');
xlabel('Pixel Intensity');
xlim([0, 255]);
saveas(gcf, 'histogram_equaliser.png'); % Save the current figure
