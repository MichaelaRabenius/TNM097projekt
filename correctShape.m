function shape = correctShape(diff)

angleMessage = 'Change angle!';
blobMessage = 'Blob time!';
noChange = 'No.';

thres = 0.2;

if(diff > thres)
    shape = angleMessage;
else
    shape = blobMessage;
end

end

