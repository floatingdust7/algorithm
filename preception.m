function y=preception(W1,W2,w,c)
%感知器算法，对两类线性可分问题求线性判别函数
%W1=[0 0;1 -1];
%W2=[2 0;1 1];
%w=[1 1 1];
%c=1;
[m,n]=size(W1);
%增广样本
for i=1:m
    W1(:,n+1)=1;
end
for i=1:m
    W2(:,n+1)=1;
end
W2=-W2;
%将增广向量转换成元组
M=ones(1,m);
w1=mat2cell(W1,M,n+1);
w2=mat2cell(W2,M,n+1);
X=cat(1,w1,w2);
%算法核心部分
[m,n]=size(X);
temp1={};temp2=2;%随意赋初值
while(~isequal(temp1,temp2))
   temp2=temp1;
   for i=1:m
       temp1{i,1}=w;
       if(w*X{i}'<=0)
           w=w+c*X{i};
       end
   end
end
w