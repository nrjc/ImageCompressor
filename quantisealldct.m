function DCTquantisedcells=quantisealldct(DCTcellinput,stepsize,rise)
    [m,n]=size(DCTcellinput);
    for i=1:m
        for j=1:n
            DCTquantisedcells{i,j}=quantise(DCTcellinput{i,j},stepsize,rise);
        end
    end

end
