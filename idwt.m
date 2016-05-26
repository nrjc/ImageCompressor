function Y = idwt(X,g1,g2)

% IDWT Inverse Discrete Wavelet Transform
%  Y = IDWT(X, G1, G2) returns a 1-level 2-D inverse discrete
%  wavelet transform on X.
%
%  If filters G1 and G2 are given, then they are used,
%  otherwise the LeGall filter pair are used.

if nargin < 3,
%   g1=[1 2 1]/2;
%   g2=[-1 -2 6 -2 -1]/4;
  %     g1=1/4*[-1 -2 6 -2 -1]; For Inv-Legall
%     g2=1/2*[1 2 1];
g1=[-0.091271763114	-0.057543526229	0.5912717631	1.11508705	0.5912717631	-0.057543526229	-0.091271763114];
g2=[0.0267487574	0.0168641184	-0.078223266529	-0.266864118443	0.6029490182	-0.266864118443	-0.078223266529	0.0168641184	0.0267487574]; %9-7 CDF Wavelet

end

[m,n] = size(X);

m2 = m/2;
t = 1:m2;
Y=rowint(X(t,:)',g1)' + rowint2(X(t+m2,:)',g2)';

n2 = n/2;
t = 1:n2;
Y=rowint(Y(:,t),g1) + rowint2(Y(:,t+n2),g2);
