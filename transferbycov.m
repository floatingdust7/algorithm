function X=transferbycov(x)
x=[1 1;2 4;3 5;6 10];
[m,n]=size(x);
C=cov(x);
[a,b]=eig(C);
t=ones(1,n)*b;
[M,index]=min(t);
u=a(:,index);
A=u';
for i=1:m
    X(i)=A*x(i,:)';
end
X