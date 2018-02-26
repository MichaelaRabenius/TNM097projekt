function diff = DiffPixles(prevPix,thisPix)
% Difference between two pixels L channel

%     diff = zeros(size(prevPix));
% 
%     for i = 1:3
%         diff(i) = abs(prevPix(i) - thisPix(i));
%     end
%     
%     diff = sum(diff);

prevPix = rgb2lab(prevPix);
thisPix = rgb2lab(thisPix);

diff = abs(prevPix(1) - thisPix(1));
   
end

