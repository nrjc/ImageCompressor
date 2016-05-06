function [Z3,Z2,Z1,Z0]=py4dec(X4,Y3,Y2,Y1,Y0,h)
%  py4enc converts an image input into  low pass images
%
% function [Z3,Z2,Z1,Z0]=py4dec(X4,Y3,Y2,Y1,Y0)
% Where X4 is the small image, Y are the high-pass images
% and Z0 - Z3 are the low pass images 
    Z3=Y3+interpolate(X4,h);
    Z2=Y2+interpolate(Z3,h);
    Z1=Y1+interpolate(Z2,h);
    Z0=Y0+interpolate(Z1,h);
end
function X=interpolate(image,h)
    X=image;
    inter=rowint(X,2*h);
    inter=rowint(inter',2*h);
    X=inter';
end