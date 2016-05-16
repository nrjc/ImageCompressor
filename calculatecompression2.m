function compressionratio=calculatecompression2(originalimage,dctcell,quantsteps,refstepsize)
    newentropy=0;
    dctcell=quantisealldct(dctcell,quantsteps);
    [M,N]=size(dctcell);
    for i=1:M
        for j=1:N
        [m,n]=size(dctcell{i,j});
        newentropy=newentropy+m*n*bpp(dctcell{i,j});
        end
    end
    %Calculate original entropy
    [m1,n1]=size(originalimage);
    originalentropy = m1*n1*bpp(quantise(originalimage,refstepsize));
    compressionratio=originalentropy/newentropy;
end