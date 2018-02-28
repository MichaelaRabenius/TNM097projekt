img1 = imread('shape01.png');
img2 = imread('oval_a.png');
img3 = imread('oval_b.png');

%imshow(img);
im1 = rgb2gray(im2double(img1));
im2 = rgb2gray(im2double(img2));
im3 = rgb2gray(im2double(img3));

circleshape = (im1 > 0);
blobshape = (im2 > 0);
blibshape = (im3 > 0);

%imshow(shape);

swatches = im2double(imread('swatches.png'));

colors = zeros([171, 3]);

index = 1;

for col = 10:20:400
    for row = 10:20:184
        colors(index,1) = swatches(row, col, 1);
        colors(index,2) = swatches(row, col, 2);
        colors(index,3) = swatches(row, col, 3);      
        if(index < 171)
            index = index + 1;
        end
    end   
end

showRGB(colors);
palette = zeros(size(circleshape));

circles = {};
for i = 1:171
   palette(:,:,1) = colors(i,1);
   palette(:,:,2) = colors(i,2);
   palette(:,:,3) = colors(i,3);
   
   c = createShape(palette, circleshape);
   b = createShape(palette, blobshape);
   d = createShape(palette, blibshape);
   
   c = whiteBG(c);
   b = whiteBG(b); 
   d = whiteBG(d); 
   %palette = whiteBG(palette);
   %circles{i} = palette;
   circles{i} = c;
   blobs{i} = b;
   blibs{i} = d;

   subplot(9,19,i), imshow(circles{i});
   %truesize
   
end
% blobs = circles;
save('circles.mat', 'circles')
save('blobs.mat', 'blobs')
save('blibs.mat', 'blibs')


%%
filename1 = 'db1/blob_';
filename2 = 'db2/blab_';
filename3 = 'db3/blib_';

for i =1:171
    %subplot(9,19,i), imshow(circles{i});
    
    name1 = strcat(filename1, int2str(i));
    name1 = strcat(name1, '.png');
    
    name2 = strcat(filename2, int2str(i));
    name2 = strcat(name2, '.png');
    
    name3 = strcat(filename3, int2str(i));
    name3 = strcat(name3, '.png');
    
    imwrite(circles{i}, name1);
    imwrite(blobs{i}, name2);  
    imwrite(blibs{i}, name3);  
end

%%
clear all
clc
load blobs
load blibs
load circles

for i =1:171
    subplot(9,19,i), imshow(blobs{i});
    
end
figure
for i =1:171
    subplot(9,19,i), imshow(blibs{i});
    
end

figure
for i =1:171
    subplot(9,19,i), imshow(circles{i});
end

%%

figure
for i =1:171
    b = imrotate(blobs{i},90);
    subplot(9,19,i), imshow(b);
end
%%
figure
for i =1:171
    b = imrotate(blibs{i},90);
    subplot(9,19,i), imshow(b);
end


function [ shapes, colors ] = GenPearls( inshape, swatches, nr_colors )
%GENPEARLS Summary of this function goes here
%   Detailed explanation goes here

%imshow(img);
im1 = rgb2gray(im2double(inshape));

shapemask = (im1 > 0);

%imshow(shape);

swatches = im2double(swatches);

colors = zeros([nr_colors, 3]);

[swatch_r, swatch_c] = size(swatches(:,:,1));

index = 1;

% Solve equation system in order to find the number of swatch squares.
height = round(SizeOfSwatch(swatch_r, swatch_c, nr_colors));
width = height;

start_height = round(height/2);
start_width = round(width/2);

for col = start_width:width:swatch_c
    for row = start_height:height:swatch_r
        colors(index,1) = swatches(row, col, 1);
        colors(index,2) = swatches(row, col, 2);
        colors(index,3) = swatches(row, col, 3);      
        if(index < nr_colors)
            index = index + 1;
        end
    end   
end

%showRGB(colors);
palette = zeros(size(shapemask));

shapes = {[1 nr_colors]};
for i = 1:nr_colors
   palette(:,:,1) = colors(i,1);
   palette(:,:,2) = colors(i,2);
   palette(:,:,3) = colors(i,3);
   
   c = createShape(palette, shapemask);
   %c = whiteBG(c);
   shapes{i} = c;

end

end


