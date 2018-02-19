img = imread('oval_b.png');
%imshow(img);
im = rgb2gray(im2double(img));
shape = (im > 0);

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

%showRGB(colors);
palette = zeros(size(shape));

circles = {};
for i = 1:171
   palette(:,:,1) = colors(i,1);
   palette(:,:,2) = colors(i,2);
   palette(:,:,3) = colors(i,3);
   
   
   palette(:,:,1) = palette(:,:,1).*shape;
   palette(:,:,2) = palette(:,:,2).*shape;
   palette(:,:,3) = palette(:,:,3).*shape;   
   palette(palette(:,:,:) <= 0) =1;
   %circles{i} = palette;
   circles{i} = palette;

   %subplot(9,19,i), imshow(palette);
   %truesize
   
end
%save('circles.mat', 'circles')


%%

filename = 'db3/blib_';

for i =1:171
    %subplot(9,19,i), imshow(circles{i});
    
    name = strcat(filename, int2str(i));
    name = strcat(name, '.png');
    imwrite(circles{i}, name);  
end




