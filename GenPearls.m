function [ shapes ] = GenPearls( inshape, colors )
%GENPEARLS Summary of this function goes here
%   Detailed explanation goes here

%imshow(img);
im1 = rgb2gray(im2double(inshape));

shapemask = (im1 > 0);

%imshow(shape);
[nr_colors e] = size(colors);


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

