function [error,reconstructed]=quantcountent(imagein,quantsteps,pylevel,h)
%
imagevec=pyenc(imagein,pylevel,h);
entout=imagevec';
quantimage={};
for i=1:(pylevel+1)
    quantimage{i} = quantise(entout{i,1},quantsteps);
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

