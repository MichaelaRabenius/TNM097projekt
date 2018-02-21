% %% CalColorDistance test
% 
% testimg = im2double(imread('test3.png'));
% 
% res = zeros(size(testimg));
% for j = 1:90:270
%    
% for i = 1:90:270
%     c = testimg(j:j+89,i:i+89,:);
%     d = calColorDistance(c, blibs);
%     res(j:j+89,i:i+89,:) = d;
% 
% end
% end
% %d = calColorDistance(testimg, blibs);
% imshow(res);

%% Inserting pearls in an image of favourable proportions
clear all
%load circles.mat;
load blobs.mat;
circles = blobs;

% load blibs.mat;
% circles = blibs;

im = im2double(imread('images/dog.jpg'));
imshow(im);
im = rgb2lab(im);
[nr_rows, nr_cols] = size(im(:,:,1));

%Get the size of the pearls and convert circles to CIELab
f = circles{1};
[r, c] = size(f(:,:,1));

%crop image
restRow = mod(nr_rows,r);
restCol = mod(nr_cols,r);

im = cropIm(im, r, restRow, restCol, nr_rows, nr_cols);
[nr_rows, nr_cols] = size(im(:,:,1));

%imshow(img)
% 
nr_colors = length(circles);
circles_lab = circles;
for i=1:nr_colors
    circles_lab{i} = rgb2lab(circles{i});
end

new_im= im;
in = 1;
%One row at a time, replace the areas.
for i = 1:r:nr_rows
    for j = 1:c:nr_cols
        area = im( i:i+(c-1), j:j+(c-1), :);
        d = calColorDistance(area, circles_lab);
        new_im(i:i+(c-1), j:j+(c-1),:) = circles{d};
        %subplot(10,10, in),imshow(d);
        in = in +1;
    end
end
figure
imshow(new_im)





