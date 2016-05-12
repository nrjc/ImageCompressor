function image=LBT(imagein,DCTsize,s)
[Pf Pr]=pot_ii(DCTsize,s);
[M N]=size(imagein);
t=[(1+DCTsize/2):(N-DCTsize/2)];
Xp = imagein;
Xp(t,:)=colxfm(Xp(t,:),Pf);
Xp(:,t)=colxfm(Xp(:,t)',Pf)';
image=Xp;

end