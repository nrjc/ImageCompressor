function saveanddisplay9(imagein)
       fun=@(x)nonuniforlbt(imagein,x);
       [step f]=fminbnd(fun,0.0001,3);
% step=0.1290;
 %%CONSTRUCTING ACTUAL IMAGE
LBTim = LBT(imagein,8,sqrt(2));
C8=dct_ii(8);
Y=colxfm(colxfm(LBTim,C8)',C8)'; 
[Yq,entropynew]=dctquantise(Y/8,step);
%%Calculating Entropy
entropyold=bpp(quantise(imagein,17))*256*256;
CR=entropyold/entropynew
%%
Zi=dctquantise2(Yq*8,step);
Zo=colxfm(colxfm(Zi',C8')',C8');
Z=ILBT(Zo,8,sqrt(2));
draw(Z);
       
end