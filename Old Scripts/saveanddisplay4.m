function saveanddisplay4(imagein,refstepsize)
map = evalin('base', 'map');
% ensure we have the right input parameters
if (nargin==1)
  map = [0:255]'*ones(1,3)*(1/255);
end
i=1;
for n=[4 8 16]
    C=dct_ii(n);
    [x1(i),f1(i)]=goldensearch4(imagein,sqrt(2),7, refstepsize);
    [M N]=size(C);
    cell=LBT(imagein,N,sqrt(2));
    cell=dctenc(cell,C);
    dctcell=quantisealldct(cell,x1(i));
    level2decode=dctdec(dctcell,C);
    level1decode=ILBT(level2decode,N,sqrt(2));
    imwrite(level1decode-128*round(min(level1decode(:))/128),map,['length-' num2str(n) '.png']);
    comp(i)=calculatecompression2(imagein,cell,x1(i),16,refstepsize);
    i=i+1;
end
plot([4 8 16],f1);


end
 