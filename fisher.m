function [Y1 Y2]=fisher(w1,w2)
%w1=[0 0 0;1 0 0;1 0 1;1 1 0];
%w2=[0 0 1;0 1 1;0 1 0;1 1 1];
[n1,n]=size(w1);
[n2,n]=size(w2);
X1=w1;X2=w2;
m1=mean(X1);m2=mean(X2);
s1=cov(X1)*(n1-1);s2=cov(X2)*(n2-1);
S=s1+s2;
W=inv(S)*(m1'-m2');
yt=W'*(m1'+m2')/2
Y1=W'*X1'
Y2=W'*X2'
