function diff = DiffPixles(prevPix,thisPix)
% Difference between two pixel

    diff = zeros(size(prevPix));

    for i = 1:3
        diff(i) = abs(prevPix(i) - thisPix(i));
    end
    
    diff = sum(diff);
   
end

