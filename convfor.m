function convfor(imageinput,map)
map = evalin('base', 'map');
% ensure we have the right input parameters
if (nargin==1)
  map = [0:255]'*ones(1,3)*(1/255);
end
[m,n]=size(imageinput);
for i=3:2:23
cosvec=halfcos(i);
Xf=[];
Xf = conv2se(cosvec,cosvec,imageinput);
imwrite(Xf-128*round(min(Xf(:))/128),map,['lowpass-' num2str(i) '.png']);
E=sum(Xf(:).^2);
S=sprintf('Energy content of low pass %d is %e',i,E);
disp(S)
Xfnew=Xf-imageinput;
imwrite(Xfnew-128*round(min(Xfnew(:))/128),map,['highpass-' num2str(i) '.png']);
E=sum(Xfnew(:).^2);
S=sprintf('Energy content of high pass %d is %e',i,E);
disp(S)

end
return;
