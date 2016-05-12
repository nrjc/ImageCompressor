function totalbits=dctbpp(Yr)
    [M,N]=size(Yr);
    
    totalbits=0;
    for i=1:M
        for j=1:N
            [m,n]=size(Yr{i,j});
            totalbits=totalbits+bpp(Yr{i,j})*m*n;
%           Ys{k}=Yr(xstart:xend,ystart:yend);
        end
    end

end