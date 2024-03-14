function y=potentialfun(w1,w2,K_0)
% w1=[0 0;1 1]
% w2=[1 0;0 1]
% K_0=0;
w1=num2cell(w1,2);
w2=num2cell(w2,2);
X=cat(1,w1,w2);
[m,n]=size(X);
K_X=K_0;
temp=-1;
while(temp~=K_X)
    for i=1:m
        temp=K_X;
        if((i<=m/2)&&K_value(K_X,X{i})<=0)
            K_X=K_X+K_0+K(X{i},1);  
        elseif((i>m/2)&&K_value(K_X,X{i})>0)
            K_X=K_X+K_0-K(X{i},1);
        end
    end
end
y=K_X;
ezplot(K_X);

%子函数部分
function y=K(X,alpha)
syms x1 x2;
y=exp(-((x1-X(1))^2+(x2-X(2))^2));

function y=K_value(K_X,X)
y=subs(K_X,'x1',X(1));
y=subs(y,'x2',X(2));

