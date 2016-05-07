load lighthouse;
colormap(map);
X=X-128;
h=0.25*[1 2 1];
XY=pyenc(X,4,h);
Z=pydec(XY,h);
