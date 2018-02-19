%% TNM097 projekt :)
clear
img = im2double(imread('birds.jpg'));

[row, col] = size(img(:,:,1));

img1 = img;

s = 15;
[columnsInImage rowsInImage] = meshgrid(1:100, 1:100);
mask = zeros([100, 100]);
circle = (columnsInImage-50).^2+(rowsInImage-50).^2 <=50.^2;
mask(circle) = 1;

for j = 1:s:row-s
for i = 1:s:col-s
    meanr =  mean(mean(img(j:(j+s), i:(i+s),1)));
    meang =  mean(mean(img(j:(j+s), i:(i+s),2)));
    meanb =  mean(mean(img(j:(j+s), i:(i+s),3)));
   img1(j:(j+s), i:(i+s), 1) = meanr;
   img1(j:(j+s), i:(i+s), 2) = meang;
   img1(j:(j+s), i:(i+s), 3) = meanb;
   %img1(j:(j+s), i:(i+s), :) = img1(j:(j+s), i:(i+s), :).*mask;
end
end

imshow(img1);
