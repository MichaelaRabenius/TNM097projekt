function cropResult = cropIm(inIm,s,restRow,restCol,row,col)
% Function that crops image so it adds up correct with s

    if(restRow ~= 0 && restCol == 0)
        while(restRow ~= 0)

            newrow = row-1;

            cropResult = zeros([newrow col 3]);
            cropResult = inIm(1:newrow,1:col,:);

            restRow = mod(newrow,s);
            row = newrow;

        end
    
    
    elseif(restCol ~= 0 && restRow == 0)
        while(restCol ~= 0)

            newcol = col-1;

            cropResult = zeros([row newcol 3]);
            cropResult = inIm(1:row,1:newcol,:);

            restCol = mod(newcol,s);
            col = newcol;

        end
 
    
    elseif(restCol ~= 0 && restRow ~= 0)
        
        while(restRow ~= 0)

            newrow = row-1;

            cropResult = zeros([newrow col 3]);
            cropResult = inIm(1:newrow,1:col,:);

            restRow = mod(newrow,s);
            row = newrow;

        end
        
        while(restCol ~= 0)

            newcol = col-1;

            cropResult = zeros([row newcol 3]);
            cropResult = cropResult(1:row,1:newcol,:);

            restCol = mod(newcol,s);
            col = newcol;

        end
    else
          cropResult = inIm;  
    end
end

