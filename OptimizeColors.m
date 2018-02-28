function [accepted] = OptimizeColors(org_colors, possible_colors, threshold)
%OPTIMIZECOLORS Summary of this function goes here
%   Detailed explanation goes here
[step1 e] = size(org_colors);
[step2 e] = size(possible_colors);

poss_lab = possible_colors;
for i=1:step2
    poss_lab(1,:) = rgb2lab(possible_colors(i,:));
end

accepted = zeros([1 3]);

for i = 1:step1
    
    org_lab = rgb2lab(org_colors(i,:));
    
    L1 = org_lab(1,1);
    a1 = org_lab(1,2);
    b1 = org_lab(1,3);
    
    for j = 1:step2

        L2 = poss_lab(j,1);
        a2 = poss_lab(j,2);
        b2 = poss_lab(j,3);

       dist(j) = sqrt( (L2 - L1)^2 + (a2 - a1)^2 + (b2 - b1)^2 );
        
%        if(dist < threshold)
%            accepted = [accepted; possible_colors(j,:)];
%        end    
    end
end

%Remove duplicate rows
accepted
accepted = unique(accepted, 'rows')

