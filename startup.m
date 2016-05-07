load lighthouse;
colormap(map);
X=X-128;
h=0.25*[1 2 1];
[Y0,Y1,Y2,Y3,X4]=py4enc(X,h);
[Z3,Z2,Z1,Z0]=py4dec(X4,Y3,Y2,Y1,Y0,h);
