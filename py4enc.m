function [Y1,Y2,Y3,Y4,X5]=py4enc(imageinput,h)
%  py4enc converts an image input into  high pass images and a tiny lowpass
%  image.
%
%  [Y0,Y1,Y2,Y3,X4]=py4enc(imageinput,h)
% Where h is the filter
% and Y0 - Y4 are the high pass images, and X4 is the tiny lowpass image. 
X{1}=imageinput;
for i=1:4
    inter=rowdec(X{i},h);
    inter=rowdec(inter',h);
    X{i+1}=inter';
end
for j=0:3
   inter=rowint(X{j+2},2*h);
   inter=rowint(inter',2*h);
   Z{j+1}=inter';
end
for k=1:4
    Y{k}=X{k}-Z{k};    
end
Y1=Y{1};
Y2=Y{2};
Y3=Y{3};
Y4=Y{4};
X5=X{5};
return;
