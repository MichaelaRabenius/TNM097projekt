%% CalColorDistance test

testimg = im2double(imread('test3.png'));

res = zeros(size(testimg));
for j = 1:90:270
   
for i = 1:90:270
    c = testimg(j:j+89,i:i+89,:);
    d = calColorDistance(c, blibs);
    res(j:j+89,i:i+89,:) = d;

end
end



%d = calColorDistance(testimg, blibs);
imshow(res);