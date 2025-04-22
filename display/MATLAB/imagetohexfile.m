% Image to text conversion
% Read the image from the file
 [filename, pathname] = uigetfile('*.bmp;*.tif;*.jpg;*.pgm','Pick an M-file');
img = imread(filename);
img = imresize((img),[640 480]);
[ row col p ] =size(img);
if p == 3
    img = rgb2gray(img);
end
rectImg = img(16:80,16:80);
% noise add
rectImg = imnoise(rectImg,'salt & pepper', 0.02);
img(16:80,16:80) = rectImg;
% Image Transpose
imgTrans = img';
% iD conversion
img1D = imgTrans(:);
% Decimal to Hex value conversion
imgHex = dec2hex(img1D);
% New txt file creation
fid = fopen('inputHex.txt', 'wt');
% Hex value write to the txt file
fprintf(fid, '%x\n', img1D);
% Close the txt file
fclose(fid)
