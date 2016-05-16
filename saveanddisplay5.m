function saveanddisplay5(imagein,refstepsize)
map = evalin('base', 'map');
% ensure we have the right input parameters
[mini,nin]=size(imagein);
ein = bpp(quantise(imagein,refstepsize))*mini*nin;
%Generate constant step size scheme
i=1;
for step=2:7
%    dwtstepm=ones(3,step);
    dwtstepm=generatedwtstep(step);
    [optsize(i),errorval(i)]=goldensearch5(imagein,dwtstepm,refstepsize);
    [quantisedimage2,dwtentk]=quantdwt(imagein,optsize(i)*dwtstepm);
    quantisedimage = nlevidwt(quantisedimage2,step);
    compressionratio(i)=ein/sum(dwtentk(:));
    num=step-1;
    imwrite((quantisedimage-128*round(min(quantisedimage(:))/128)),map,['stepsize' num2str(step) '.png']);
  i=i+1;
end
plot(1:6,errorval);


end
 