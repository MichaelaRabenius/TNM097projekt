function shape = correctShape(diff,next_diff,thres)

angleMessage = 'Change Angle!';
blobMessage = 'Blob!';
sameMessage = 'Same as previous...';

if((diff > thres) && (next_diff > thres))
    shape = angleMessage;
elseif((next_diff > thres) && (diff < thres))
    shape = sameMessage;
else
    shape = blobMessage;
end

end

