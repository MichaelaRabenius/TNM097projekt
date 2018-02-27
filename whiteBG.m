function [ out ] = whiteBG( in )
%WHITEBG Summary of this function goes here
%   Detailed explanation goes here
r = in(:,:,1);
g = in(:,:,2);
b = in(:,:,3);
blackPixels = r == 0 & g == 0 & b == 0;

r(blackPixels) = 1;
g(blackPixels) = 1;
b(blackPixels) = 1;
out = cat(3, r, g, b);

end

