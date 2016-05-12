function compressionratio=calculatecompression2(originalimage,dctcell,quantsteps,refstepsize)
    h = evalin('base', 'h');
    newentropy=0;
    dctcell=quantisealldct(dctcell,quantsteps);
    [M,N]=size(dctcell);
    for i=1:M
        for i=1:N
        [m,n]=size(dctcell{i});
        newentropy=newentropy+m*n*bpp(dctcell{i});
        end
    end
    %Calculate original entropy
    [m1,n1]=size(originalimage);
    originalentropy = m1*n1*bpp(quantise(originalimage,refstepsize));
    compressionratio=originalentropy/newentropy;
end