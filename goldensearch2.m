function [x1,f_x1]=goldensearch2(imagein,quantsteps,pylevel,h)
% x1=goldensearch(imagein,pylevel,h). Function performs a golden search to
% minimize the MSE between the reconstructed image at step 17 and the
% pyramidal image. 
a=1;                            % start of interval
b=3000;                            % end of interval
epsilon=0.000001;               % accuracy value
iter= 1000;                       % maximum number of iterations
tau=double((sqrt(5)-1)/2);      % golden proportion coefficient, around 0.618
k=0;                            % number of iterations


x1=a+(1-tau)*(b-a);             % computing x values
x2=a+tau*(b-a);

f_x1=f(imagein,x1*quantsteps,pylevel,h);                     % computing values in x points
f_x2=f(imagein,x2*quantsteps,pylevel,h);


while ((abs(b-a)>epsilon) && (k<iter))
    k=k+1;
    if(f_x1<f_x2)
        b=x2;
        x2=x1;
        x1=a+(1-tau)*(b-a);
        
        f_x1=f(imagein,x1*quantsteps,pylevel,h); 
        f_x2=f(imagein,x2*quantsteps,pylevel,h);
        
    else
        a=x1;
        x1=x2;
        x2=a+tau*(b-a);
        
        f_x1=f(imagein,x1*quantsteps,pylevel,h); 
        f_x2=f(imagein,x2*quantsteps,pylevel,h);
        
    end
    
    k=k+1;
end
end

function error=f(imagein,quantsteps,pylevel,h)
    [error,reconstructed]=quantcountent2(imagein,quantsteps,pylevel,h);
    image=quantise(imagein,17);
    errorimage=std(imagein(:)-image(:));
    error=(error-errorimage)^2;
end