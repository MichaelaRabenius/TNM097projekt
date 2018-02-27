%% load colored shapes
clear all
clc

load blobs.mat;
load blibs.mat;
load blabs.mat;

%Resize the pearls
f = blobs{1};
[pearlsize e] = size(f(:,1,1)); %s för annie

%Transform the colored shapes to CIELab
nr_colors = length(blobs);

blobs_lab = blobs;
blibs_lab = blibs;
blabs_lab = blabs;

for i=1:nr_colors
    blobs_lab{i} = rgb2lab(blobs{i});
    blibs_lab{i} = rgb2lab(blibs{i});
    blabs_lab{i} = rgb2lab(blabs{i});
end

%% Preprocess image (scaling and cropping)
originalIm = im2double(imread('images/wave.jpg'));

%Crop image to be evenly divided by the size of the pearls
croppedIm = cropIm(originalIm, 20);

%Get the size of the cropped image for future use.
[rows, cols] = size(croppedIm(:,:,1));

%% Start replacing areas in the image with pearls

checkArea = 4; % How far forward to check value.
%thres = 0.2;
thres = 0.13; % Threshold for pixel values

resultIm = croppedIm;

disp('start the loop');
for i = 1:pearlsize:rows
    for j = 1:pearlsize:cols
        
        %croppedIm( i:i+(pearlsize-1), j:j+(pearlsize-1)) = mean(mean(croppedIm( i:i+(pearlsize-1), j:j+(pearlsize-1))));
        
        %Select the middle pixel of the area
        firstr = croppedIm(i + (pearlsize/2),j + (pearlsize/2),1);
        firstg = croppedIm(i + (pearlsize/2),j + (pearlsize/2),2);
        firstb = croppedIm(i + (pearlsize/2),j + (pearlsize/2),3);
        
        thisPix = [firstr firstg firstb];
        
        % check if column exist...
        if(((j + (pearlsize/2) + pearlsize*checkArea) < cols) && (i + (pearlsize/2) < rows))
            rval = croppedIm(i + (pearlsize/2),j + (pearlsize/2) + pearlsize*checkArea, 1);
            gval = croppedIm(i + (pearlsize/2),j + (pearlsize/2) + pearlsize*checkArea, 2);
            bval = croppedIm(i + (pearlsize/2),j + (pearlsize/2) + pearlsize*checkArea, 3);
        end
        
        nextPix = [rval gval bval];
        
        diff = DiffPixles(thisPix,nextPix);
        
        if((diff > thres) && (i + (pearlsize/2) < rows) && (j + (pearlsize/2) + 2*pearlsize*checkArea < cols))
            
            newr = croppedIm(i + (pearlsize/2),j + (pearlsize/2) + 2*pearlsize*checkArea, 1);
            newg = croppedIm(i + (pearlsize/2),j + (pearlsize/2) + 2*pearlsize*checkArea, 2);
            newb = croppedIm(i + (pearlsize/2),j + (pearlsize/2) + 2*pearlsize*checkArea, 3);
            
            next_next = [newr newg newb];
            next_diff = DiffPixles(nextPix,next_next);
            
            AreaShape = correctShape(diff,next_diff,thres);
        else
            AreaShape = 'Same as previous...';
        end
        
        %start inserting pearls
        %One area at the time
        area = rgb2lab(croppedIm( i:i+(pearlsize-1), j:j+(pearlsize-1), :));
          
        if(strcmp(AreaShape ,'Change Angle!'))
            d = calColorDistance(area, blobs_lab);
            resultIm(i:i+(pearlsize-1), j:j+(pearlsize-1),:) = blobs{d};
        elseif(strcmp(AreaShape ,'Blob!'))
            d = calColorDistance(area, blibs_lab);
            resultIm(i:i+(pearlsize-1), j:j+(pearlsize-1),:) = blibs{d};
        else
            d = calColorDistance(area, blabs_lab);
            resultIm(i:i+(pearlsize-1), j:j+(pearlsize-1),:) = blabs{d};
        end
    end
end

imshow(resultIm);







