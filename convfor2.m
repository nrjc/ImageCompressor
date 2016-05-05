function Xf = convfor2(imageinput)
[m,n]=size(imageinput);
cosvec=halfcos(3);
Xf2=[];
Xf2 = conv2se(cosvec,1,imageinput);
Xf=conv2se(1,cosvec,Xf2);
return;
