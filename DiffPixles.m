function diff = DiffPixles(prevPix,thisPix)
% Difference between two pixel
angleMessage = 'Change angle!';
blobMessage = 'Blob time!';
thres = 0.2;

    diff = zeros(size(prevPix));

    for i = 1:3
        diff(i) = abs(prevPix(i) - thisPix(i));
    end
    
    diff = sum(diff);
    
    if(diff > thres)
        angleMessage;
    end
    
end

