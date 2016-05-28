function error=nonuniforlbt(imagein,step)
LBTim = LBT(imagein,8,sqrt(2));
C8=dct_ii(8);
Y=colxfm(colxfm(LBTim,C8)',C8)'; 
Yq=dctquantise(Y,step);
Zi=dctquantise2(Yq,step);
Zo=colxfm(colxfm(Zi',C8')',C8');
Z=ILBT(Zo,8,sqrt(2));
error=deltaerror(Z);

end