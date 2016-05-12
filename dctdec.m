function decoded=dctdec(dctcell,C)
    [M,N]=size(dctcell);
    [m,n]=size(dctcell{1,1});
    reconimage =zeros(m*M,n*N) ;
    for i1=1:M
        for j1=1:N
            for i=1:m
                for j=1:n
                    reconimage((i-1)*M+i1,(j-1)*N+j1)=dctcell{i1,j1}(i,j);
                end
            end
        end
    end
    decoded=colxfm(colxfm(reconimage',C')',C');
end