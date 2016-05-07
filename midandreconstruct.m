function energyatend=midandreconstruct(Cellsin,numtoreconstruct)
h = evalin('base', 'h');
impulsesize=100;
[m,n]=size(Cellsin{numtoreconstruct+1});
Cellsin{numtoreconstruct+1}(m/2,n/2)=impulsesize;
outputcells=pydec(Cellsin,h);
[m1,n1]=size(outputcells);
energyatend=sum(outputcells{n1}(:).^2);
end