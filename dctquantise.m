function qimage=dctquantise(X,qstep)
    Qtable=(1/10)*[16 11 10 16 24 40 51 61; 12 12 14 19 26 58 60 55; 14 13 16 24 40 57 69 56;
        14 17 22 29 51 87 80 62; 18 22 37 56 68 109 103 77; 24 35 55 64 81 104 113 92;49 64 78 87 103 121 120 101;72 92 95 98 112 100 103 99];
    [m,n]=size(X);
    qimage=zeros(m,n);
    for j = 1:(m/8)
       for i=1:(n/8)
           qimage(((j-1)*8+1):j*8,((i-1)*8+1):i*8)=indvq(X(((j-1)*8+1):j*8,((i-1)*8+1):i*8),Qtable);
       end        
    end
end

function image=indvq(X,Qtable)
    [M,N]=size(X);
    image=zeros(M,N);
    for i=1:M
        for j=1:N
            image(i,j)=quant1(X(i,j),Qtable(i,j),Qtable(i,j));
        end
    end
end