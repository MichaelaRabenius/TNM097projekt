function [ res ] = calColorDistance( img, colors )
%UNTITLED Summary of this function goes here
%   Calculates which image to use by finding the one closest in color.
% Colors are assumed to already be in the CIELab color space

% 1. transform to CIELab
%img_lab = rgb2lab(img);

nr_colors = length(colors);

% for i=1:nr_colors
%     colors_lab{i} = rgb2lab(colors{i});
% end

% Calculate the average color.
avg_img = mean(mean(img));


% 2. calculate the difference in color between img and the colors
% by the euclidean distance
L1 = avg_img(:,:,1);
a1 = avg_img(:,:,2);
b1 = avg_img(:,:,3);

dist = zeros([1 nr_colors]);
for i = 1:nr_colors
%      c = colors{i};
%     [row, col] = size(c(:,:,1));
%     L2 = c(floor(row/2), floor(col/2),1);
%     a2 = c(floor(row/2), floor(col/2),2);
%     b2 = c(floor(row/2), floor(col/2),3);
    
    
    c = colors{i};
    avg_c = mean(mean((c)));
    
    [row, col] = size(c(:,:,1));
    L2 = avg_c(:,:,1);
    a2 = avg_c(:,:,2);
    b2 = avg_c(:,:,3);
    
    dist(i) = sqrt( (L2 - L1)^2 + (a2 - a1)^2 + (b2 - b1)^2 );
end

% 3. Compare all colors to the original to find the closest match.
[mindist, index] = min(dist);

% 4. return the the image to substitute area img
res = index;

end

