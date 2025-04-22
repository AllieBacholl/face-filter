function [outfname, rows, cols] = hexfilegen(infile, outfname, numrows, numcols)

img = imread(infile);

imgresized = imresize(img, [numrows numcols]);

[rows, cols, rgb] = size(imgresized);

imgscaled = imgresized/16 - 1;
imshow(imgscaled*16);

fid = fopen(outfname,'w');

count = 0;
for r = 1:rows
    for c = 1:cols
        red = floorDiv(uint16(imgscaled(r,c,1)),2);
        green = floorDiv(uint16(imgscaled(r,c,2)),2);
        blue = floorDiv(uint16(imgscaled(r,c,3)),4);
        color = bitshift(red, 5) + bitshift(green, 2) + blue;
        fprintf(fid,'%2X ', color);
        count = count + 1;
    end
end

fclose(fid);