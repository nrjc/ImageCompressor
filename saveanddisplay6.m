function saveanddisplay6(imagein)
map = evalin('base', 'map');
% ensure we have the right input parameters
[mini,nin]=size(imagein);
ein = bpp(quantise(imagein,17))*mini*nin;
%Generate constant step size scheme
%imwrite((quantisedimage-128*round(min(quantisedimage(:))/128)),map,['stepsize' num2str(step) '.png']);

%INVESTIGATE THE LBT
%Plot CR for different ratios, while keeping RMS constant. 
for ratio=0.1:0.1:10
    fun1=@(x)calculateerrorLBT(imagein,sqrt(2),x,17,x*ratio);
    [step f]=fminbnd(fun1,0,50);
    Xp = LBT(imagein,8,sqrt(2));
    dctcell = dctenc(Xp,dct_ii(8));
    compressionratio(i)=calculatecompression2(imagein,dctcell,step,8,17,step*ratio);
    i=i+1;
end
%These results are a little suspicious, as they do not agree with the
%original results


%INVESTIGATE THE DWT
%Golden Search to find the ideal rise size.
% dwtstepm=generatedwtstep(6);
% fun2=@(x)calculatedeltarmserror4(imagein,x*dwtstepm,17);
% [idealstepdwt f]=fminbnd(fun2,1000,10000);


end
 