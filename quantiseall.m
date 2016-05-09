function imageout=quantiseall(imagein,step)
    for i=1:length(imagein)
       imageout{i}=quantise(imagein{i},step); 
    end
end