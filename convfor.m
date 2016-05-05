function Xf = convfor(imageinput)
[m,n]=size(imageinput);
cosvec=halfcos(15);
Xf2=[];
Xf2 = conv2se(1,cosvec,imageinput);
Xf=conv2se(cosvec,1,Xf2);

return;
