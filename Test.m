% % %% GenPearl testdots
blabshape = imread('shapes/shape6.png');
blibshape = imread('shapes/shape4.png');
blobshape = imread('shapes/shape1.png');

swatches = imread('swatches.png');

nr = 171;

[blabs colors] = GenPearls(blabshape,swatches, nr);
[blibs colors] = GenPearls(blibshape,swatches, nr);
[blobs colors] = GenPearls(blobshape,swatches, nr);

[r_blabs colors] = GenPearls(imrotate(blabshape,90),swatches, nr);
[r_blibs colors] = GenPearls(imrotate(blibshape,90),swatches, nr);


% 
% for i =1:171
%     subplot(6,19,i), imshow(r_blabs{i}); 
% end

save('blabs.mat', 'blabs');
save('blibs.mat', 'blibs');
save('blobs.mat', 'blobs');
save('r_blibs.mat', 'r_blibs');
save('r_blabs.mat', 'r_blabs');
save('colors.mat', 'colors');


%%
c2 = im2double(imread('db1/blob_1.png'));

imshow(c2);

clab = rgb2lab(c);



%% Inserting pearls in an image of favourable proportions
% clear all
% load circles.mat;
% load blobs.mat;
% circles = blobs;

% load blibs.mat;
% circles = blibs;

circles = blobs;

im = imread('images/birds.jpg');
imshow(im);
im = rgb2lab(im);
[nr_rows, nr_cols] = size(im(:,:,1));

%Get the size of the pearls and convert circles to CIELab
f = circles{1};
[r, c] = size(f(:,:,1));

%crop image
restRow = mod(nr_rows,r);
restCol = mod(nr_cols,r);

im = cropIm(im, r);
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





