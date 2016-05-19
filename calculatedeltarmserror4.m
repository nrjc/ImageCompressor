function rmserror=calculatedeltarmserror4(originalimage,dwtstep,refstepsize,rise)
    [m n]=size(dwtstep);
    [reconstimage,entropy]=quantdwt(originalimage,dwtstep,rise);
    reconstimage = nlevidwt(reconstimage,n);
    rmserror1=std(originalimage(:)-reconstimage(:));
    reconstimage2=quantise(originalimage,refstepsize);
    rmserror2=std(originalimage(:)-reconstimage2(:));
    rmserror =(rmserror1-rmserror2)^2;
end