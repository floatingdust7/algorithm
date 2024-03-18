function y=fuzzy_Kmeans(X,K,m,U,e)
K=2;
X=[0 0;0 1;3 1;3 2];
U0=[0.9 0.8 0.7 0.1;0.1 0.2 0.3 0.9];
m=2;
e=0.0001;
UL=membership(U,X,m);
err=abs(UL-U);
while(max(err(1,:))>e)
    temp=UL;
    UL=membership(UL,X,m);
    err=abs(UL-temp);
end
UL
class=cell(K,1);
for j=1:size(X,1)
    [MAX,index]=max(UL(:,j));
    class{index}=cat(1,class{index},j);
end
celldisp(class);

%子函数部分
function y=membership(U0,X,m)
classNum=size(U0,1);
for i=1:classNum
    U0(i,:)=U0(i,:).^m;
end
Z=zeros(classNum,size(X,2));
for i=1:classNum
    for j=1:size(X,1)
        Z(i,:)=Z(i,:)+U0(i,j)*X(j,:);
    end
    Z(i,:)=Z(i,:)/sum(U0(i,:));
end
for j=1:size(X,1)
    for i=1:size(Z,1)
        d(i,j)=dist(X(j,:),Z(i,:)')^(2/(m-1));
    end
end
[K,N]=size(d);
u=zeros(K,N);
for i=1:K
    for j=1:N
        for p=1:K
            u(i,j)=u(i,j)+d(i,j)/d(p,j);
        end
        u(i,j)=1/u(i,j);
    end
end
y=u;