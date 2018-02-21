%% TNM097 project
clear
thres = 0.2;

% Load image
img = im2double(imread('images/three.JPG'));
[row, col] = size(img(:,:,1));

% Size of area to be replaced
s = 20;

restRow = mod(row,s);
restCol = mod(col,s);

% Crop image
resultIm = cropIm(img,s,restRow,restCol,row,col);
prevPix = [0 0 0];
diff = [0 0 0];

for j = 0:s:row-s
    for i = 0:s:col-s
        % Calculate mean for chosen area in each channel
        meanr =  mean(mean(img(j+1:(j+s), i+1:(i+s),1)));
        meang =  mean(mean(img(j+1:(j+s), i+1:(i+s),2)));
        meanb =  mean(mean(img(j+1:(j+s), i+1:(i+s),3)));
        
        % Replace each area with calculated mean value
        resultIm(j+1:(j+s), i+1:(i+s), 1) = meanr;
        resultIm(j+1:(j+s), i+1:(i+s), 2) = meang;
        resultIm(j+1:(j+s), i+1:(i+s), 3) = meanb;
        
        thisPix = [meanr meang meanb];
        DiffPixles(prevPix,thisPix);
        prevPix = thisPix;
        
        
        
    end
end

imshow(resultIm);
