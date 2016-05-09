function imageout=quantiseall(imagein,stepvector)
newlength=length(imagein);
    for i=1:newlength
       imageout{i}=quantise(imagein{i},stepvector(i)); 
    end
end