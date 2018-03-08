clear all
clc

checkArea = 4; % How far forward to check value.
%thres = 0.2;
thres = 0.13; % Threshold for pixel values

%Threshold for optimization
similarity_threshold = 0.1;

img = im2double(imread('images/jag.jpg'));
img = checkSize(img);
[row, col] = size(img(:,:,1));

p = 40; % Antal p?rlor i x-led
s = round(row/p);

resultIm = cropIm(img,s);

[r_cropped, c_cropped] = size(resultIm(:,:,1));

%% Calculate average color for each area size s
% and pick out all the unique colors
avgIm = resultIm;
c_ind = 0;
%resultIm(:,:,:) = 0.5;

for i = 1:s:r_cropped
    for j = 1:s:c_cropped
        c_ind = c_ind+1;
        area = mean(mean(img( i:i+(s-1), j:j+(s-1), :)));
        
        avgIm( i:i+(s-1), j:j+(s-1), 1) = area(1,1,1);
        avgIm( i:i+(s-1), j:j+(s-1), 2) = area(1,1,2);
        avgIm( i:i+(s-1), j:j+(s-1), 3) = area(1,1,3);

    end
end
imshow(avgIm)


rgb_columns = reshape(avgIm, [], 3);
size(rgb_columns);

[unique_colors, m, n] = unique(rgb_columns, 'rows');

fprintf('There are %d unique colors in the image.\n',size(unique_colors, 1))

%Sort based on hue
C = rgb2hsv(unique_colors);
e = sortrows(C, [-1 -2 2]);
e = hsv2rgb(e);

%pick out the optimal number of color given threshold
da = OptimizeColors(e, similarity_threshold);
showRGB(da);

%% Create pearls with the optimized colors 
blabshape = imread('shapes/shape6.png');
blibshape = imread('shapes/shape4.png');
blobshape = imread('shapes/shape1.png');

blabs  = GenPearls(blabshape,da);
blibs = GenPearls(blibshape,da);
blobs = GenPearls(blobshape,da);

r_blabs = GenPearls(imrotate(blabshape,90),da);
r_blibs = GenPearls(imrotate(blibshape,90),da);

%%

circles = blobs;
circles_lab = circles;

f = circles{1};
[r, c] = size(f(:,:,1));

scaleBlb = s/r;

[nr_colors e] = size(da);
for i=1:nr_colors
    circles{i} = imresize(circles{i},scaleBlb);
    circles_lab{i} = rgb2lab(circles{i});
end


inx = 1;
for i = 1:s:r_cropped
    for j = 1:s:c_cropped
        area = rgb2lab(resultIm( i:i+(s-1), j:j+(s-1), :));
        d = calColorDistance(area, circles_lab);
        resultIm(i:i+(s-1), j:j+(s-1),:) = circles{d};
        
        indices(inx) = d;
        inx = inx + 1;
    end
end
imshow(resultIm);

checkArea = 3; % How far forward to check value.
%thres = 0.2;
thres = 0.6;

ind = 0;
next_shape = 'blib';
for i = 1:s:r_cropped
    for j = 1:s:c_cropped
        ind = ind+1;
        firstr = resultIm(i + round(s/2),j + round(s/2),1);
        firstg = resultIm(i + round(s/2),j + round(s/2),2);
        firstb = resultIm(i + round(s/2),j + round(s/2),3);
        
        thisPix = [firstr firstg firstb];
        
        % check if column exist...
        if(((j + (s/2) + s*checkArea) < c_cropped) && (i + (s/2) < r_cropped))
            rval = resultIm(i + round(s/2),j + round(s/2) + s*checkArea, 1);
            gval = resultIm(i + round(s/2),j + round(s/2) + s*checkArea, 2);
            bval = resultIm(i + round(s/2),j + round(s/2) + s*checkArea, 3);
        end
        
        nextPix = [rval gval bval];
        
        diff = DiffPixles(thisPix,nextPix);
        
        if((diff > thres) && (i + (s/2) < r_cropped) && (j + (s/2) + 2*s*checkArea < c_cropped))
            
            newr = resultIm(i + round(s/2),j + round(s/2) + 2*s*checkArea, 1);
            newg = resultIm(i + round(s/2),j + round(s/2) + 2*s*checkArea, 2);
            newb = resultIm(i + round(s/2),j + round(s/2) + 2*s*checkArea, 3);
            
            next_next = [newr newg newb];
            next_diff = DiffPixles(nextPix,next_next);
            
            thisArea = correctShape(diff,next_diff,thres);
        else
            thisArea = 'Same as previous...';
        end
        
        if(strcmp(thisArea ,'Change Angle!'))
            if(ind <= length(indices))
                d = indices(ind);
                
                if(strcmp(next_shape,'blib'))
                    resultIm(i:i+(s-1), j:j+(s-1),:) = imresize(blibs{d},scaleBlb);
                    next_shape = 'blab';
                    
                elseif(strcmp(next_shape,'blab'))
                    resultIm(i:i+(s-1), j:j+(s-1),:) = imresize(blabs{d},scaleBlb);
                    next_shape = 'r_blib';
                elseif(strcmp(next_shape,'r_blib'))
                    resultIm(i:i+(s-1), j:j+(s-1),:) = imresize(r_blibs{d},scaleBlb);
                    next_shape = 'r_blab';
                elseif(strcmp(next_shape,'r_blab'))
                    resultIm(i:i+(s-1), j:j+(s-1),:) = imresize(r_blabs{d},scaleBlb);
                    next_shape = 'blib';   
                end
                
            end
            
        end
        
    end
end
imshow(resultIm)
figure
imshow(img)

%% Check the quality with s-cielab

% To xyz
imgXYZ = rgb2xyz(cropIm(img,s));
resultXYZ = rgb2xyz(resultIm);

% s-Cielab function
sampPerDeg = round(72 / ((180/pi)*atan(1/18))); % correct? change this later
whiteD65 = [95.05, 100, 108.9];

result_quality = scielab(sampPerDeg, imgXYZ, resultXYZ, whiteD65, 'xyz');

mean_quality = mean(mean(result_quality));

%Show the quality difference
figure
subplot(1,3,1), imshow(img);
subplot(1,3,2), imshow(resultIm);
subplot(1,3,3), imshow(result_quality);




