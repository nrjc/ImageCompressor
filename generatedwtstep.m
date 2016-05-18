function dwtstep=generatedwtstep(levels)
    impulsesize=100;
    m=256;n=256;
    empty = zeros(m,n);
    temp=empty;
    for i=1:(levels)
        temp(1*m/4,3*n/4)=impulsesize;
        recon=nlevidwt(temp,i);
        dwtstep(1,i)=1/sqrt(sum(recon(:).^2));
        temp=empty;
        temp(3*m/4,1*n/4)=impulsesize;
        recon=nlevidwt(temp,i);
        dwtstep(2,i)=1/sqrt(sum(recon(:).^2));
        temp=empty;
        temp(3*m/4,3*n/4)=impulsesize;
        recon=nlevidwt(temp,i);
        dwtstep(3,i)=1/sqrt(sum(recon(:).^2));
        temp=empty;
        m=m/2;
        n=n/2;
    end
    temp(m/2,n/2)=impulsesize;
    recon=nlevidwt(temp,levels);
    dwtstep(1,levels+1)=1/sqrt(sum(recon(:).^2));
end