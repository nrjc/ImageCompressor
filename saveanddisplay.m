function saveanddisplay(imagein,quantsteps,totalpylevels,h)
errormatrix=[];
map = evalin('base', 'map');

% ensure we have the right input parameters
if (nargin==1)
  map = [0:255]'*ones(1,3)*(1/255);
end

for i=1:totalpylevels
    [error,reconstructed]=quantcountent(imagein,quantsteps,i,h);
    imwrite(reconstructed-128*round(min(reconstructed(:))/128),map,['reconstructedimage-' num2str(i) '.png']);
    errormatrix=[errormatrix;error];
end
levels=(1:totalpylevels)';
T=table(levels,errormatrix);
T.Properties.VariableNames = {'Pyramidlevels' 'StdError'};
% writetable(T,'errors.txt');
end