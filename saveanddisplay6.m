function saveanddisplay6(imagein)
map = evalin('base', 'map');
% ensure we have the right input parameters
[mini,nin]=size(imagein);
ein = bpp(quantise(imagein,17))*mini*nin;
%Generate constant step size scheme
%imwrite((quantisedimage-128*round(min(quantisedimage(:))/128)),map,['stepsize' num2str(step) '.png']);

%INVESTIGATE THE LBT
%Golden Search to find the ideal step size.
fun1=@(x)calculateerrorLBT(imagein,sqrt(2),x,17,x/2);
[idealsteplbt f]=fminbnd(fun1,0,30);
%Golden Search to maximize CR


%INVESTIGATE THE DWT
%Golden Search to find the ideal rise size.
dwtstepm=generatedwtstep(6);
fun2=@(x)calculatedeltarmserror4(imagein,x*dwtstepm,17);
[idealstepdwt f]=fminbnd(fun2,1000,10000);


end
 