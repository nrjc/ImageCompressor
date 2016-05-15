function imageout=nlevidwt(imagein,levels)
    [m n]=size(imagein);
    m = m/(2^(levels-1));
    imageout=imagein;
    for i=1:levels
        t=1:m;
        imageout(t,t)=idwt(imageout(t,t));
        m=m*2;
    end
end