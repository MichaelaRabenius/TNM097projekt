function cropResult = cropIm(inIm,s)
% Function that crops image so it adds up correct with s
[row, col] = size(inIm(:,:,1));
restRow = mod(row,s);
restCol = mod(col,s);


    if(restRow ~= 0 && restCol == 0)
        while(restRow ~= 0)

            newrow = row-1;

            %cropResult = zeros([newrow col 3]);
            cropResult = inIm(1:newrow,1:col,:);

            restRow = mod(newrow,s);
            row = newrow;

        end
    
    
    elseif(restCol ~= 0 && restRow == 0)
        while(restCol ~= 0)

            newcol = col-1;

            %cropResult = zeros([row newcol 3]);
            cropResult = inIm(1:row,1:newcol,:);

            restCol = mod(newcol,s);
            col = newcol;

        end
 
    
    elseif(restCol ~= 0 && restRow ~= 0)
        
        while(restRow ~= 0)

            newrow = row-1;

            %cropResult = zeros([newrow col 3]);
            cropResult = inIm(1:newrow,1:col,:);

            restRow = mod(newrow,s);
            row = newrow;

        end
        
        while(restCol ~= 0)

            newcol = col-1;

            %cropResult = zeros([row newcol 3]);
            cropResult = inIm(1:row,1:newcol,:);

            restCol = mod(newcol,s);
            col = newcol;

        end
    else
          cropResult = inIm;  
    end
    
end

