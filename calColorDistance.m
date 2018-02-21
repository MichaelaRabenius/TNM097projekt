function [ res ] = calColorDistance( img, colors )
%UNTITLED Summary of this function goes here
%   Calculates which image to use by finding the one closest in color.

% 1. transform to CIELab
img_lab = rgb2lab(img);

nr_colors = length(colors);

for i=1:nr_colors
    colors_lab{i} = rgb2lab(colors{i});
end

% Calculate the average color.
avg_img = mean(mean(img_lab));


% 2. calculate the difference in color between img and the colors
% by the euclidean distance
L1 = avg_img(:,:,1);
a1 = avg_img(:,:,2);
b1 = avg_img(:,:,3);

res = 0;
for i = 1:nr_colors
    c = colors_lab{i};
    [row, col] = size(c(:,:,1));
    L2 = c(row/2, col/2,1);
    a2 = c(row/2,col/2,2);
    b2 = c(row/2,col/2,3);
    
    dist(i) = sqrt( (L2 - L1)^2 + (a2 - a1)^2 + (b2 - b1)^2 );
end

% 3. Compare all colors to the original to find the closest match.
[mindist, index] = min(dist);

% 4. return the the image to substitute area img
res = colors{index};

end

