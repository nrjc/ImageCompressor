function [x1,f_x1]=goldensearch3(originalimage,dctcell,quantsteps,refstepsize,C)
% x1=goldensearch(imagein,pylevel,h). Function performs a golden search to
% minimize the MSE between the reconstructed image at step 17 and the
% pyramidal image. 
a=20;                            % start of interval
b=30;                            % end of interval
epsilon=0.001;               % accuracy value
iter= 1000;                       % maximum number of iterations
tau=double((sqrt(5)-1)/2);      % golden proportion coefficient, around 0.618
k=0;                            % number of iterations


x1=a+(1-tau)*(b-a);             % computing x values
x2=a+tau*(b-a);

f_x1=calculatedeltarmserror2(originalimage,quantisealldct(dctcell,x1),refstepsize,C);                     % computing values in x points
f_x2=calculatedeltarmserror2(originalimage,quantisealldct(dctcell,x2),refstepsize,C);


while ((abs(b-a)>epsilon) && (k<iter))
    k=k+1;
    if(f_x1<f_x2)
        b=x2;
        x2=x1;
        x1=a+(1-tau)*(b-a);
        
        f_x1=calculatedeltarmserror2(originalimage,quantisealldct(dctcell,x1),refstepsize,C);                     % computing values in x points
        f_x2=calculatedeltarmserror2(originalimage,quantisealldct(dctcell,x2),refstepsize,C);
        
    else
        a=x1;
        x1=x2;
        x2=a+tau*(b-a);
        
        f_x1=calculatedeltarmserror2(originalimage,quantisealldct(dctcell,x1),refstepsize,C);                     % computing values in x points
        f_x2=calculatedeltarmserror2(originalimage,quantisealldct(dctcell,x2),refstepsize,C);
        
    end
    
    k=k+1;
end
end

