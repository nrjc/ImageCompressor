function saveanddisplay2(imagein,quantsteps,totalpylevels,h)
errormatrix=[];
map = evalin('base', 'map');
Cellsin = pyenc(zeros(256,256),8,h);
for i=1:8
%     invsqrte(i)=midandreconstruct(Cellsin,(i-1));
    invsqrte(i)=(midandreconstruct(Cellsin,(i-1)))^-0.5;
end
for j=1:totalpylevels
    [x1(j),error(j)]=goldensearch2(imagein,flip(invsqrte),j,h);
    %[error(j),reconstructed{j}]=quantcountent2(imagein,invsqrte*10^3,j,h);
end
plot(1:totalpylevels,error)
% ensure we have the right input parameters
% if (nargin==1)
%   map = [0:255]'*ones(1,3)*(1/255);
% end
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