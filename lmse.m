function y=lmse(w1,w2,B,c)
%最小均方误差
%w1=[0 0;1 -1];
%w2=[2 0;1 1];
x1=w1;
[m,n]=size(x1);
for i=1:m
    x1(:,n+1)=1;
end
x2=w2;
[m,n]=size(x2);
for i=1:m
    x2(:,n+1)=1;
end
x2=-x2;
X=cat(1,x1,x2);
%算法核心部分
[m,n]=size(X);
B=ones(1,m)';
c=2;
X_sharp=inv((X'*X))*X';
W=X_sharp*B;
err=X*W-B;
while(~all((err+abs(err))==0))
    %err的分量不全为0或负，否则，若err全为0或负，err+|err|为0矩阵
    W=W+c*X_sharp*abs(err);
    B=B+c*(err+abs(err));
    err=X*W-B;
end
if(isClassification(err)==1)
    y=1;
    disp('模式样本线性可分！权向量解W：');
    W
else
    y=0;
    disp('模式样本线性不可分');
end

function z=isClassification(err)
z=1;
if(all(err)<0)
    z=0;
end