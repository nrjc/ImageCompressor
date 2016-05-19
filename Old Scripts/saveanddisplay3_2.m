function saveanddisplay3_2(inputimage)
map = evalin('base', 'map');
% ensure we have the right input parameters
if (nargin==1)
  map = [0:255]'*ones(1,3)*(1/255);
end
i=1;

for N=[4 8 16]
    C=dct_ii(N);
    cell=dctenc(inputimage,C);
    [x(i) f(i)]=goldensearch3(inputimage,cell,17,17,C);
    compressionratio(i) = calculatecompression2(inputimage,cell,x(i),8,17);
    %imwrite(output-128*round(min(output(:))/128),map,['s' num2str(s) 'bases.png']);
    i=i+1;
end
plot(1:3,f);

end
 