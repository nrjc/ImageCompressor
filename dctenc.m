function DCTcell=dctenc(X,C)
    [M,N]=size(C);
    filtered=colxfm(colxfm(X,C)',C)';
    Yr=regroup(filtered,N);
    [m,n]=size(Yr);
    for i=0:(N-1)
        xstart=1+(i*m/N);
        xend=((i+1)*m/N);
        for j=0:(N-1)
            ystart=1+(j*n/N);
            yend=((j+1)*n/N);
            DCTcell{i+1,j+1}=Yr(xstart:xend,ystart:yend);
        end
    end
end