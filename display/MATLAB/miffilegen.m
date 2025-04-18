function [outfname, rows, cols] = miffilegen(infile, outfname, numrows, numcols)

img = imread(infile);

imgresized = imresize(img, [numrows numcols]);

[rows, cols, rgb] = size(imgresized);

imgscaled = imgresized/16 - 1;
imshow(imgscaled*16);

fid = fopen(outfname,'w');

fprintf(fid,'-- %3ux%3u 8bit image color values\n\n',rows,cols);
fprintf(fid,'WIDTH = 8;\n');
fprintf(fid,'DEPTH = %4u;\n\n',rows*cols);
fprintf(fid,'ADDRESS_RADIX = UNS;\n');
fprintf(fid,'DATA_RADIX = UNS;\n\n');
fprintf(fid,'CONTENT BEGIN\n');

count = 0;
for r = 1:rows
    for c = 1:cols
        red = floorDiv(uint16(imgscaled(r,c,1)),2);
        green = floorDiv(uint16(imgscaled(r,c,2)),2);
        blue = floorDiv(uint16(imgscaled(r,c,3)),4);
        color = bitshift(red, 5) + bitshift(green, 2) + blue;
        fprintf(fid,'%4u : %4u;\n',count, color);
        count = count + 1;
    end
end
fprintf(fid,'END;');
fclose(fid);