function [new_colors] = OptimizeColors(org_colors, threshold)
%OPTIMIZECOLORS Summary of this function goes here
%   Detailed explanation goes here


[step1 e] = size(org_colors);


org_lab = org_colors;
for i=1:step1
    org_lab(1,:) = rgb2lab(org_colors(i,:));
end

%first color


g =1;

m = 's';
for i = 1:step1
     [s e] = size(org_lab);
    if(i < s)
        
        L1 = org_lab(i,1);
    a1 = org_lab(i,2);
    b1 = org_lab(i,3);
    for j = i+1:step1
        L2 = org_lab(j,1);
        a2 = org_lab(j,2);
        b2 = org_lab(j,3);
        
        dist = sqrt( (L2 - L1)^2 + (a2 - a1)^2 + (b2 - b1)^2 );
        
        if(dist < threshold)
            indices(g) = j;
            g = g+1;
            m = 'remove';
            
        end
    end
    %remove colors that are visually indistinguishable to first color;
    if(strcmp(m, 'remove'))
        
        org_lab(indices(:),:) = [];
        [step1 e] = size(org_lab);
        m = 's';
        indices = [];
        g = 1;
    end
        
        
        
        
    end
   
    
end

new_colors = org_lab;
for i=1:step1
    new_colors(1,:) = lab2rgb(org_lab(i,:));
end





% [step1 e] = size(org_colors);
% [step2 e] = size(possible_colors);
% 
% poss_lab = possible_colors;
% for i=1:step2
%     poss_lab(1,:) = rgb2lab(possible_colors(i,:));
% end
% 
% accepted = zeros([1 3]);
% 
% for i = 1:step1
%     
%     org_lab = rgb2lab(org_colors(i,:));
%     
%     L1 = org_lab(1,1);
%     a1 = org_lab(1,2);
%     b1 = org_lab(1,3);
%     
%     %showRGB(org_colors(i,:));
%     
%     for j = 1:step2
%          
%        % showRGB(possible_colors(j,:));
%         L2 = poss_lab(j,1);
%         a2 = poss_lab(j,2);
%         b2 = poss_lab(j,3);
% 
%        dist(j) = sqrt( (L2 - L1)^2 + (a2 - a1)^2 + (b2 - b1)^2 );
%         
%        if(dist(j) < threshold)
%            accepted = [accepted; possible_colors(j,:)];
%        end    
%     end
% end
% 
% %Remove duplicate rows
% accepted
% accepted = unique(accepted, 'rows')
