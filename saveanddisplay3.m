function saveanddisplay3(imagein,refstepsize,C)
map = evalin('base', 'map');
% ensure we have the right input parameters
if (nargin==1)
  map = [0:255]'*ones(1,3)*(1/255);
end
i=1;
for slevel=[1:0.1:2 sqrt(2)]
    [x1(i),f1(i)]=goldensearch4(imagein,slevel,7, refstepsize);
    [M N]=size(C);
    cell=LBT(imagein,N,slevel);
    cell=dctenc(cell,C);
    dctcell=quantisealldct(cell,x1(i));
    level2decode=dctdec(dctcell,C);
    level1decode=ILBT(level2decode,N,slevel);
%   imwrite(level1decode-128*round(min(level1decode(:))/128),map,['slevel-' num2str(slevel) '.png']);
    comp(i)=calculatecompression2(imagein,cell,x1(i),refstepsize);
    i=i+1;
end
plot([1:0.1:2 sqrt(2)],f1);


end
 