function imageout = ungroup(imagein,num)
 sx = size(imagein);

% Regroup the 8 subimages at each level, starting with the largest
% subimages in Y.
  k = N/2;  % Size of blocks of pels at each level.

    tm = 1:sx(1);
    tn = 1:sx(2);
    tm2 = [reshape(tm,k,sx(1)/k); reshape(tm+sx(1),k,sx(1)/k)];
    tn2 = [reshape(tn,k,sx(2)/k); reshape(tn+sx(2),k,sx(2)/k)];

    Y(tm2(:),tn2(:)) = Y(1:(sx(1)*2),1:(sx(2)*2));
end