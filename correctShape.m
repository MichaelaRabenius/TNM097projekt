function shape = correctShape(diff,next_diff,thres)

angleMessage = 'Change Angle!';
blobMessage = 'Blob!';

if((diff > thres) && (next_diff > thres))
    shape = angleMessage;
else
    shape = blobMessage;
end

end

