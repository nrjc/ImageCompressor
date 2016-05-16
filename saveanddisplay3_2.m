function saveanddisplay3_2()
map = evalin('base', 'map');
% ensure we have the right input parameters
if (nargin==1)
  map = [0:255]'*ones(1,3)*(1/255);
end
i=1;

for s=1:0.1:2
    [Pf Pr]=pot_ii(8,s);
    bases = [zeros(1,8);Pf';zeros(1,8)];
    output=(255*bases(:)*bases(:)');
    %imwrite(output-128*round(min(output(:))/128),map,['s' num2str(s) 'bases.png']);
    i=i+1;
end


end
 