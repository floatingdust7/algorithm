function out=bayes(X,Y)
file=textread('train1.txt','%s','delimiter','\n','whitespace','');
[m n]=size(file);
for i=1:m
    words=strread(file{i},'%s','delimiter',' ');
    words=words';
    X{i}=words;
end
X=X';

file=textread('predict1.txt','%s','delimiter','\n','whitespace','');
[m,n]=size(file);
for i=1:m
    words=strread(file{i},'%s','delimiter',' ');
    words=words';
    Y{i}=words;
end
Y=Y';
% 这里file里每个单元里存的是字符串，Y里每个单元存储的是含有字符串的单元数组
%训练部分
[M N]=size(X);
[m n]=size(X{1});
decision=attribute(X,n);%相当于把X数组的最后一列提取出来
Pro=probality(decision);%各类的概率
for i=1:n-1
    [post_pro{i},post_name{i}]=post_prob(attribute(X,i),decision);
end
%预测部分
uniq_decis=unique(decision);
P_X=ones(size(uniq_decis,1),1);%初始化决策属性后验概率
[M,N]=size(Y);
k=1;
for i=1:M
    for j=1:n-1
        [temp,loc]=ismember(attribute({Y{i}},j),unique(attribute(X,j)));
        P_X=post_pro{j}(:,loc).*P_X;
    end
    [MAX,I]=max(P_X);
    out{k}=uniq_decis{I};
    k=k+1;
    P_X=ones(size(uniq_decis,1),1);
end
out=out';

%以下为子函数
function y=attribute(X,n)
[M,N]=size(X);
for i=1:M
    temp{i}=X{i}{n};
end
y=temp';

function y=probality(E)
[M,N]=size(E);
class=unique(E);
[m,n]=size(class);
p=zeros(m,1);
for i=1:M
    for j=1:m
        if(isequal(E{i},class{j}))
            p(j)=p(j)+1;
        end
    end
end
y=p/M;

function[post_pro,post_name]=post_prob(E,D)
%E为目标属性，D为决策属性
%post_pro计算目标属性对应于决策属性的后验概率
%post_name为所求后验概率变量的名称
[M,N]=size(D);
decision=unique(D);
attri=unique(E);
[m1,n1]=size(decision);
[m2,n2]=size(attri);
temp=cat(2,E,D);
post_pro=zeros(m1,m2);
for i=1:M
    for j=1:m2
        for k=1:m1
            post_name{k,j}=cat(2,{attri{j}},{decision{k}});
            if(isequal(temp(i,:),post_name{k,j}))
                post_pro(k,j)=post_pro(k,j)+1;
            end
        end
    end
end
for i=1:m1
    post_pro(i,:)=post_pro(i,:)/sum(post_pro(i,:));
end

