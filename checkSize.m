function outIm = checkSize(inIm)

[r,c] = size(inIm);

if(r > 800)
    outIm = imresize(inIm,0.2);
elseif(r < 500)
    outIm = imresize(inIm,1.2);
else
    outIm = inIm;
end

end

