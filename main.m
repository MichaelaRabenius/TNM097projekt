%% TNM097 project
clear

checkArea = 4; % How far forward to check value.
%thres = 0.2;
thres = 0.13; % Threshold for pixel values

% Load image

img = im2double(imread('images/jag.jpg'));
img = checkSize(img);
[row, col] = size(img(:,:,1));

% Size of area to be replaced
%s = 20;
p = 80; % Antal p?rlor i x-led
s = round(row/p);

restRow = mod(row,s);
restCol = mod(col,s);

% Crop image
resultIm = cropIm(img,s);
%imshow(resultIm)

load blabs.mat
load blobs.mat
load blibs.mat
load r_blibs.mat
load r_blabs.mat

circles = blobs;
nr_colors = length(circles);
circles_lab = circles;

f = circles{1};
[r, c] = size(f(:,:,1));

scaleBlb = s/r;

for i=1:nr_colors
    circles{i} = imresize(circles{i},scaleBlb);
    circles_lab{i} = rgb2lab(circles{i});
end

[r_cropped, c_cropped] = size(resultIm(:,:,1));
c = s;
r = s;


inx = 1;
for i = 1:r:r_cropped
    for j = 1:c:c_cropped
        area = rgb2lab(resultIm( i:i+(c-1), j:j+(c-1), :));
        d = calColorDistance(area, circles_lab);
        resultIm(i:i+(c-1), j:j+(c-1),:) = circles{d};
        
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
figure
imshow(resultIm);
figure
imshow(img);
