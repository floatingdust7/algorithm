function w=multipreception()
X(1,:)=[1 0];
X(2,:)=[0 1];
X(3,:)=[1 1];
k=3;
for i=1:k
    w(i,:)=[0 0 0];
end
c=1;%校正系数
[m n]=size(X);
for i=1:k
    X(i,n+1)=1;
end
%算法核心部分
temp=[];
while(~isequal(temp,w))
    temp=w;
    for i=1:k
        for j=1:k
            d(j)=w(j,:)*X(i,:)';
        end
        if(~ismax(d(i),d))
            p=setdiff([1 2 3],i);
            if(d(i)<=d(p(1)))
                w(p(1),:)=w(p(1),:)-c*X(i,:);
            end
            if(d(i)>=d(p(2)))
                w(p(2),:)=w(p(2),:)-c*X(i,:);
            end
            w(i,:)=w(i,:)+c*X(i,:);
        end
    end
end
w

function y=ismax(m,d)
sum=0;
[row col]=size(d);
for i=1:col
    if(m<=d(i))
        sum=sum+1;
    end
end
if(sum==1)
    y=1;
else
    y=0;
end
