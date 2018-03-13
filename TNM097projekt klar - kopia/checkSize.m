function outIm = checkSize(inIm)

[r,c,i] = size(inIm);
TooLarge = 1000;
TooSmall = 100;
Allowed = 500;

if((r >= c) && (r > TooLarge))
    scaleFac = TooLarge/r;
    outIm = imresize(inIm,scaleFac);
elseif((c >= r) && (c > TooLarge))
    scaleFac = TooLarge/c;
    outIm = imresize(inIm,scaleFac);
elseif((c >= r) && (c > TooSmall))
    %scaleFac = TooSmall/c;
    scaleFac = Allowed/c;
    outIm = imresize(inIm,scaleFac);
elseif((r >= c) && (r > TooSmall))
    %scaleFac = TooSmall/r;
    scaleFac = Allowed/r;
    outIm = imresize(inIm,scaleFac);
else
    outIm = inIm;
end

end

