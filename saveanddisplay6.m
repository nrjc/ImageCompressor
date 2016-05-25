function saveanddisplay6(imagein)
map = evalin('base', 'map');
% ensure we have the right input parameters
[mini,nin]=size(imagein);
ein = bpp(quantise(imagein,17))*mini*nin;
%Generate constant step size scheme
%imwrite((quantisedimage-128*round(min(quantisedimage(:))/128)),map,['stepsize' num2str(step) '.png']);
i=1;
%INVESTIGATE THE LBT
%Plot CR for different ratios, while keeping RMS constant. 
% for ratio=0.1:0.1:3
%     fun1=@(x)calculateerrorLBT(imagein,sqrt(2),x,17,x*ratio);
%     [step f]=fminbnd(fun1,0,50);
%     Xp = LBT(imagein,8,sqrt(2));
%     dctcell = dctenc(Xp,dct_ii(8));
%     compressionratio(i)=calculatecompression2(imagein,dctcell,step,16,17,step*ratio);
%     i=i+1;
% end
%These results are a little suspicious, as they do not agree with the
%original results
i=1;

%INVESTIGATE THE DWT
%Golden Search to find the ideal rise size.
    dwtstepm=generatedwtstep(4);
    fun2=@(x)calculatedeltarmserror4(imagein,x*dwtstepm,17,1);
    [idealstepdwt(i) f(i)]=fminbnd(fun2,1,100000);
    [quantisedimage2,dwtentk]=quantdwt(imagein,idealstepdwt(i)*dwtstepm,1);
    imageout = nlevidwt(quantisedimage2,5);
    compressionratio(i)=ein/sum(dwtentk(:));


end
 