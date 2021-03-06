function qimage=dctquantise2(X,qstep)
    Qtable=qstep*(1/10)*[16 11 10 16 24 40 51 61; 12 12 14 19 26 58 60 55; 14 13 16 24 40 57 69 56;
        14 17 22 29 51 87 80 62; 18 22 37 56 68 109 103 77; 24 35 55 64 81 104 113 92;49 64 78 87 103 121 120 101;72 92 95 98 112 100 103 99];
    [m,n]=size(X);
    qimage=zeros(m,n);
    for j = 1:8
       for i=1:8
           qimage(m*(j-1)/8+1:m*j/8,n*(i-1)/8+1:n*i/8)=indvq(X(m*(j-1)/8+1:m*j/8,n*(i-1)/8+1:n*i/8),Qtable(j,i));
       end        
    end
end

function image=indvq(X,Qtable)
    [M,N]=size(X);
    image=zeros(M,N);
    image=quant2(X,Qtable);
end