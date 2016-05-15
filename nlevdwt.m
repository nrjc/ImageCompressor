function imageout=nlevdwt(imagein,levels)
    [m n]=size(imagein);
    imageout=imagein;
    for i=1:levels
       t=1:m;
       imageout(t,t)=dwt(imageout(t,t));
       m=m/2;
    end

end