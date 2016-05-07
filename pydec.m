function pyout=pydec(C,h)
%X=pyenc[imageinput,levels,h]
%Takes C as an input a cell: Y0,Y1,...,Yn,X(n+1), returns the set of low pass
%images Z as a cell in the following format:(Zn,...,Z0)
    [m,n]=size(C);
    pyout{1}=C{n-1}+interpolate(C{n},h);
    for i=2:(n-1)
        pyout{i}=C{n-i}+interpolate(pyout{i-1},h);
    end
end
function X=interpolate(image,h)
    X=image;
    inter=rowint(X,2*h);
    inter=rowint(inter',2*h);
    X=inter';
end