function rmserror=calculatedeltarmserror3(originalimage,s,quantstep,refstepsize)
     C = evalin('base', 'C');
     [M N]=size(C);
     Xp = LBT(originalimage,N,s);
     decoded = dctenc(Xp,C);
     quantised = quantisealldct(decoded,quantstep);
     reconst=dctdec(quantised,C);
     reconstimage=ILBT(reconst,N,s);
     rmserror1=std(originalimage(:)-reconstimage(:));
    reconstimage2=quantise(originalimage,refstepsize);
    rmserror2=std(originalimage(:)-reconstimage2(:));
    rmserror =(rmserror1-rmserror2)^2;
end