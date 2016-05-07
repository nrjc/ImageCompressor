function [error,reconstructed]=quantcountent2(imagein,quantsteps,pylevel,h)
%function [error,reconstructed]=quantcountent(imagein,quantsteps,pylevel,h)
%Takes in an imput image, the number of quantization steps,
%quantsteps, and the number of levels in the laplacian pyramid, pylevel, as
%well as the convolution vector h. It returns a vector of reconstructed
%errors, and a cell consisting of the reconstructed images. They are output
%in the order from 1-pylevel.
% The difference between quantcontent and quantcountent2 is the fact that
% quantsteps is a vector. 
imagevec=pyenc(imagein,pylevel,h);
entout=imagevec';
quantimage={};
for i=1:(pylevel+1)
    quantimage{i} = quantise(entout{i,1},quantsteps(i));
    entout{i,2}=bpp(quantimage{i});    
    entout{i,3}=bpp(entout{i,1});
    [m,n]=size(entout{i,1});
    entout{i,4}=m*n;
    entout{i,5}=entout{i,4}*entout{i,2};
    entout{i,6}=entout{i,4}*entout{i,3};
end
out=pydec(quantimage,h);
reconstructed=out{pylevel};
error=std(imagein(:)-reconstructed(:));

end

