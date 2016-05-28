function rmserror=deltaerror(imagein)
    X=evalin('base','X');
    rmserror1=std(imagein(:)-X(:));
    reconstimage2=quantise(X,17);
    rmserror2=std(X(:)-reconstimage2(:));
    rmserror =(rmserror1-rmserror2)^2;
end