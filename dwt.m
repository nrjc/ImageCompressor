function Y = dwt(X,h1,h2)

%DWT Discrete Wavelet Transform
%  Y = DWT(X, H1, H2) returns a 1-level 2-D discrete wavelet
%  transform of X.
%
%  If filters H1 and H2 are given, then they are used,
%  otherwise the LeGall filter pair are used.

if nargin < 3,
    %     h1 = 1/4*[-1 2 -1]; For Inv-Legall
%     h2 = 1/8*[-1 2  6 2 -1];
  h1=[-1 2 6 2 -1]/8;
  h2=[-1 2 -1]/4;
% h1=[0.0267487574	-0.016864118443	-0.078223266529	0.2668641184	0.6029490182	0.2668641184	-0.078223266529	-0.016864118443	0.0267487574];
% h2=[0.0912717631	-0.057543526229	-0.591271763114	1.11508705	-0.591271763114	-0.057543526229	0.0912717631];% 9-7 CDF Wavwelet

% h1=evalin('base','h1');
% h2=evalin('base','h2');
end

[m,n] = size(X);
Y = zeros(m,n);

n2 = n/2;
t = 1:n2;
Y(:,t) = rowdec(X,h1);
Y(:,t+n2) = rowdec2(X,h2);

X = Y';
m2 = m/2;
t = 1:m2;
Y(t,:) = rowdec(X,h1)';
Y(t+m2,:) = rowdec2(X,h2)';

