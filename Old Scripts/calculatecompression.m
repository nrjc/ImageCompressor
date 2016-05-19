function compressionratio=calculatecompression(originalimage,pyenccell,quantsteps,refstepsize)
    h = evalin('base', 'h');
    newentropy=0;
    pyenccell=quantiseall(pyenccell,quantsteps);
    for i=1:length(pyenccell)
        [m,n]=size(pyenccell{i});
        newentropy=newentropy+m*n*bpp(pyenccell{i});
    end
    %Calculate original entropy
    [m1,n1]=size(originalimage);
    originalentropy = m1*n1*bpp(quantise(originalimage,refstepsize));
    compressionratio=originalentropy/newentropy;
end