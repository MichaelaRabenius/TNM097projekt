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
      
    end
end

checkArea = 5; % How far forward to check value.

for j = 0:row-s
    
%     counter = 1;
%     firstr = resultIm((s/2),i*(s/2)+(s/2),1);
%     firstg = resultIm((s/2),i*(s/2),2);
%     firstb = resultIm((s/2),i*(s/2),3);
% 
%     thisPix = [firstr firstg firstb];
%     nextPix = [0 0 0];
%     
%     for i = 1:col-s
%            
%         rval = resultIm(j*s+(s/2)-s, i*s+(s/2)-1, 1);
%         gval = resultIm(j*s+(s/2)-s, i*s+(s/2)-1, 2);
%         bval = resultIm(j*s+(s/2)-s, i*s+(s/2)-1, 3);
%         
%         nextPix = [rval gval bval];
%         
%         if(mod(counter,checkArea) == 0 || counter == 1)
%             diff = DiffPixles(thisPix,nextPix);
%             correctShape = correctShape(diff)
%             thisPix = nextPix;
%         end
%         
%         counter = counter + 1;
%         
%     end
end

imshow(resultIm);
