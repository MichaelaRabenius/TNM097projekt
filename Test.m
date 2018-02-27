% % %% GenPearl testdots
im = imread('oval_a.png');
swatches = imread('swatches2.png');
dots = GenPearls(im,swatches, 592);

for i =1:592
    subplot(37,16,i), imshow(dots{i}); 
end

%%
load circles.mat

c = im2double(circles{1});
c2 = im2double(imread('db1/blob_1.png'));

imshow(c);
figure
imshow(c2);

clab = rgb2lab(c);



%% Inserting pearls in an image of favourable proportions
% clear all
% load circles.mat;
% load blobs.mat;
% circles = blobs;

% load blibs.mat;
% circles = blibs;
load dots.mat
circles = dots;

im = imread('images/wave.jpg');
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





