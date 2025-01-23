clc;
clear;
close all;
% Pankaj Kumar(BT22ECI060)

% Specify the image path (hardcoded)
imagePath = '/MATLAB Drive/car.jpeg'; % Replace with your image file path

% Read the grayscale image
grayImage = imread(imagePath);

% Check if the image is already grayscale
if size(grayImage, 3) == 3
    grayImage = rgb2gray(grayImage); % Convert to grayscale if needed
end

% Get the image size
[rows, cols] = size(grayImage);

% Display the original grayscale image
figure;
subplot(3, 3, 1);
imshow(grayImage, []);
title('Original Grayscale Image');

% Save the original grayscale image in the current directory
imwrite(grayImage, 'Original_Grayscale_Image.png');

% Loop through each bit plane and display them
for bp = 0:7
    % Extract the specific bit plane
    bitPlaneImage = bitget(grayImage, bp + 1);
    
    % Save the bit plane image in the current directory
    outputFileName = sprintf('BitPlane_%d.png', bp);
    imwrite(logical(bitPlaneImage), outputFileName);
    
    % Display the bit plane
    subplot(3, 3, bp + 2); % Position the subplot
    imshow(logical(bitPlaneImage)); % Show as logical (binary image)
    title(['Bit Plane ', num2str(bp)]);
end

% Maximize the figure window
set(gcf, 'Position', get(0, 'Screensize'));

% Save the full figure in the current directory
saveas(gcf, 'BitPlane_Slicing_Results.png');

disp('Bit-plane slicing completed. All outputs are saved in the current directory.');
