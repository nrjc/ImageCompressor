function saveanddisplay2(imagein,quantsteps,totalpylevels,h)
map = evalin('base', 'map');
% ensure we have the right input parameters
if (nargin==1)
  map = [0:255]'*ones(1,3)*(1/255);
end
Cellsin = pyenc(zeros(256,256),7,h);
for i=1:8
     %invsqrte(i)=1;
    invsqrte(i)=(midandreconstruct(Cellsin,(i-1)))^-0.5;
end
for level=1:totalpylevels
   pycell = pyenc(imagein,level,h);
   [v(level),funcv(level)]=goldensearch2(imagein,pycell,invsqrte,17);
   compression(level)=calculatecompression(imagein,pycell,v(level)*invsqrte,17);
   reconstimage2=quantiseall(pycell,v(level)*invsqrte);
   reconstimage2=pydec(reconstimage2,h);
   reconstimage2=reconstimage2{length(reconstimage2)};
   rmserror(level)=std(imagein(:)-reconstimage2(:));
   imwrite(reconstimage2-128*round(min(reconstimage2(:))/128),map,['MSE-' num2str(level) '.png']);
end
plot(1:totalpylevels,funcv);

% 
% for i=1:totalpylevels
%     [error,reconstructed]=quantcountent(imagein,quantsteps,i,h);
%     imwrite(reconstructed-128*round(min(reconstructed(:))/128),map,['reconstructedimage-' num2str(i) '.png']);
%     errormatrix=[errormatrix;error];
% end
% levels=(1:totalpylevels)';
% T=table(levels,errormatrix);
% T.Properties.VariableNames = {'Pyramidlevels' 'StdError'};
% writetable(T,'errors.txt');
end
 
% function vector=generateandoptimizequantsteps(imagein,h,pylevels){
% 
% 
% }