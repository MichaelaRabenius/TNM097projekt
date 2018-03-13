function [ c ] = createShape( palette, shape )
%CREATESHAPE Summary of this function goes here
%   Detailed explanation goes here
c = palette;
c(:,:,1) = palette(:,:,1).*shape;
c(:,:,2) = palette(:,:,2).*shape;
c(:,:,3) = palette(:,:,3).*shape;

end

