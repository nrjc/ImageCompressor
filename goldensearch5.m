function [x1,f_x1]=goldensearch5(originalimage,dwtstep,refstepsize)
% x1=goldensearch(imagein,pylevel,h). Function performs a golden search to
% minimize the MSE between the reconstructed image at step 17 and the
% pyramidal image. 
a=100;                            % start of interval
b=10000;                            % end of interval
epsilon=0.000001;               % accuracy value
iter= 1000;                       % maximum number of iterations
tau=double((sqrt(5)-1)/2);      % golden proportion coefficient, around 0.618
k=0;                            % number of iterations


x1=a+(1-tau)*(b-a);             % computing x values
x2=a+tau*(b-a);

f_x1=calculatedeltarmserror4(originalimage,dwtstep*x1,refstepsize);                     % computing values in x points
f_x2=calculatedeltarmserror4(originalimage,dwtstep*x2,refstepsize);  


while ((abs(b-a)>epsilon) && (k<iter))
    k=k+1;
    if(f_x1<f_x2)
        b=x2;
        x2=x1;
        x1=a+(1-tau)*(b-a);
        
        f_x1=calculatedeltarmserror4(originalimage,dwtstep*x1,refstepsize);                     % computing values in x points
        f_x2=calculatedeltarmserror4(originalimage,dwtstep*x2,refstepsize);  
        
    else
        a=x1;
        x1=x2;
        x2=a+tau*(b-a);
        
        f_x1=calculatedeltarmserror4(originalimage,dwtstep*x1,refstepsize);                     % computing values in x points
        f_x2=calculatedeltarmserror4(originalimage,dwtstep*x2,refstepsize);  
        
    end
    
    k=k+1;
end
end

