function totalbits=dctbpp2(Yr,N)
    [m,n]=size(Yr);
    totalbits=0;
    for i=0:(N-1)
        xstart=1+(i*m/N);
        xend=((i+1)*m/N);
        for j=0:(N-1)
            ystart=1+(j*n/N);
            yend=((j+1)*n/N);
            totalbits=totalbits+bpp(Yr(xstart:xend,ystart:yend))*(xend-xstart)*(yend-ystart);
        end
    end
end