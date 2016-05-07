function pyout=pyenc(imageinput,levels,h)
%X=pyenc[imageinput,levels,h]
%Takes an image input, returns the Laplacian in X as a cell, in this format: Y0,Y1,...,Yn,X(n+1) 
X{1}=imageinput;
for i=1:levels
    inter=rowdec(X{i},h);
    inter=rowdec(inter',h);
    X{i+1}=inter';
end
for j=0:(levels-1)
   inter=rowint(X{j+2},2*h);
   inter=rowint(inter',2*h);
   Z{j+1}=inter';
end
for k=1:levels
    pyout{k}=X{k}-Z{k};    
end
pyout{levels+1}=X{levels+1};
end