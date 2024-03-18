function X=K_L(x)
%x=[1 2;2 3;2 4;-3 -3;-2 -3;-4 -3];
[N,n]=size(x);
R=zeros(n,n);
for i=1:N
    R=R+x(i,:)'*x(i,:);
end
R=R/N;
[u,b]=eig(R);
t=ones(1,n)*b;
[M,index]=max(t);
A=u(:,index)'/sqrt(u(1,index)^2+u(2,index)^2);
X=[];
for i=1:N
    X=cat(1,X,A*x(i,:)');
end
X