function [quantisedimage,dwtentk]=quantdwt(imagein,dwtstep,rise)
[m n]=size(imagein);
[M N]=size(dwtstep);
imagein = nlevdwt(imagein,N);
for i=1:(N-1)
    quantisedimage(1:m/2,(n/2+1):n)=quantise(imagein(1:m/2,(n/2+1):n),dwtstep(1,i),rise);
    dwtentk(1,i)=bpp(quantisedimage(1:m/2,(n/2+1):n))*m*n/4;
    quantisedimage((m/2+1):m,1:n/2)=quantise(imagein((m/2+1):m,1:n/2),dwtstep(2,i),rise);
    dwtentk(2,i)=bpp(quantisedimage((m/2+1):m,1:n/2))*m*n/4;
    quantisedimage((m/2+1):m,(n/2+1):n)=quantise(imagein((m/2+1):m,(n/2+1):n),dwtstep(3,i),rise);
    dwtentk(3,i)=bpp(quantisedimage((m/2+1):m,(n/2+1):n))*m*n/4;
    m=m/2;
    n=n/2;
end
quantisedimage(1:m,1:n)=quantise(imagein(1:m,1:n),dwtstep(1,N),rise);
dwtentk(1,N)=bpp(quantisedimage(1:m,1:n))*m*n;
end