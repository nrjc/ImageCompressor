function rmserror=calculatedeltarmserror(originalimage,pyenccell,refstepsize)
    h = evalin('base', 'h');
    reconstimage=pydec(pyenccell,h);
    reconstimage=reconstimage{length(reconstimage)};
    rmserror1=std(originalimage(:)-reconstimage(:));
    reconstimage2=quantise(originalimage,refstepsize);
    rmserror2=std(originalimage(:)-reconstimage2(:));
    rmserror =(rmserror1-rmserror2)^2;
end