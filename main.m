%% TNM097 project
clear
thres = 0.2;

% Load image
img = im2double(imread('images/blackorange.png'));
[row, col] = size(img(:,:,1));

% Size of area to be replaced
s = 20;

restRow = mod(row,s);
restCol = mod(col,s);

% Crop image
resultIm = cropIm(img,s,restRow,restCol,row,col);
imshow(resultIm)
for j = 0:s:row-s
    for i = 0:s:col-s
        % Calculate mean for chosen area in each channel
        meanr =  mean(mean(img(j+1:(j+s), i+1:(i+s),1)));
        meang =  mean(mean(img(j+1:(j+s), i+1:(i+s),2)));
        meanb =  mean(mean(img(j+1:(j+s), i+1:(i+s),3)));
        
        % Replace each corresponding area with calculated mean value
        resultIm(j+1:(j+s), i+1:(i+s), 1) = meanr;
        resultIm(j+1:(j+s), i+1:(i+s), 2) = meang;
        resultIm(j+1:(j+s), i+1:(i+s), 3) = meanb;
        
    end
end

checkArea = 4; % How far forward to check value. (=4 om 5 pixlar fram)
thres = 0.2;

for i = 0:s:row-s
    for j = 0:s:col-s
        
        firstr = resultIm(i + (s/2),j + (s/2),1);
        firstg = resultIm(i + (s/2),j + (s/2),2);
        firstb = resultIm(i + (s/2),j + (s/2),3);
        
        thisPix = [firstr firstg firstb];
        
        % check if column exist...
        if(((j + (s/2) + s*checkArea) < (col-s)) && (i + (s/2) < (row-s)))
            rval = resultIm(i + (s/2),j + (s/2) + s*checkArea, 1);
            gval = resultIm(i + (s/2),j + (s/2) + s*checkArea, 2);
            bval = resultIm(i + (s/2),j + (s/2) + s*checkArea, 3);
        end
        
        nextPix = [rval gval bval];
        
        diff = DiffPixles(thisPix,nextPix);
        
        if(diff > thres)
            
            newr = resultIm(i + (s/2),j + (s/2) + 2*s*checkArea, 1);
            newg = resultIm(i + (s/2),j + (s/2) + 2*s*checkArea, 2);
            newb = resultIm(i + (s/2),j + (s/2) + 2*s*checkArea, 3);
            
            next_next = [newr newg newb];
            next_diff = DiffPixles(nextPix,next_next);
            
            thisArea = correctShape(diff,next_diff,thres)
        else
            thisArea = 'Same as previous...'
        end
    end
end

imshow(resultIm);
