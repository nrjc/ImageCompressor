function image=ILBT(imagein,DCTsize,s)
[Pf Pr]=pot_ii(DCTsize,s);
[M N]=size(imagein);
t=[(1+DCTsize/2):(N-DCTsize/2)];
Zp = imagein;
Zp(:,t)=colxfm(Zp(:,t)',Pr')';
Zp(t,:)=colxfm(Zp(t,:),Pr');
image=Zp;
end