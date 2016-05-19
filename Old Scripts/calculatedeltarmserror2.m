function rmserror=calculatedeltarmserror2(originalimage,dctcell,refstepsize,C)
    reconstimage=dctdec(dctcell,C);
    rmserror1=std(originalimage(:)-reconstimage(:));
    reconstimage2=quantise(originalimage,refstepsize);
    rmserror2=std(originalimage(:)-reconstimage2(:));
    rmserror =(rmserror1-rmserror2)^2;
end