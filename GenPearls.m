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

