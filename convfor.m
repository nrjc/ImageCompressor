function convfor(imageinput,map)
[m,n]=size(imageinput);
for i=3:2:23
cosvec=halfcos(i);
Xf=[];
Xf = conv2se(cosvec,cosvec,imageinput);
imwrite(Xf,map,['lowpass-' num2str(i) '.png']);
E=sum(Xf(:).^2);
S=sprintf('Energy content of low pass %d is %e',i,E);
disp(S)
Xfnew=Xf-imageinput;
imwrite((Xfnew),map,['highpass-' num2str(i) '.png']);
E=sum(Xfnew(:).^2);
S=sprintf('Energy content of high pass %d is %e',i,E);
disp(S)

end
return;
