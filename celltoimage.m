function reconimage=celltoimage(dctcell)
    [M,N]=size(dctcell);
    [m,n]=size(dctcell{1,1});
    reconimage =zeros(m*M,n*N) ;
    for i1=1:M
        for j1=1:N
            for i=1:m
                for j=1:n
                    reconimage(i+(i1-1)*m,j+(j1-1)*n)=dctcell{i1,j1}(i,j);
                end
            end
        end
    end
end