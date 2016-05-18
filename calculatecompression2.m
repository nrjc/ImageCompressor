function compressionratio=calculatecompression2(originalimage,dctcell,quantsteps,N,refstepsize)
    newentropy=0;
    dctcell=quantisealldct(dctcell,quantsteps);
    image = celltoimage(dctcell);
    newentropy=dctbpp2(image,N);
    %Calculate original entropy
    [m1,n1]=size(originalimage);
    originalentropy = m1*n1*bpp(quantise(originalimage,refstepsize));
    compressionratio=originalentropy/newentropy;
end