function imageout=nlevdwt(imagein,levels)
%     h1 = 1/4*[-1 2 -1]; For Inv-Legall
%     h2 = 1/8*[-1 2  6 2 -1];
% h2 = (1/14)*[-1 -5 12 -5 -1]; For 5-7 tap?
% h1=(1/69.4896)*[-6/8 -15/4 73/4 85/2 73/4 -15/4 -6/8];
    [m n]=size(imagein);
    imageout=imagein;
    for i=1:levels
       t=1:m;
       imageout(t,t)=dwt(imageout(t,t));
       m=m/2;
    end

end