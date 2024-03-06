function class=max_min(sample,centroid,thi)
%最大最小距离聚类方法，即各类间中心距离最大，同一类中各样本距离最小
%参数
%sample=[1 2;3 7;3 2;2 1;5 4;4 7;6 4;5 5];
%centroid=1;
%thi=1/2;
Z(1,:)=sample(centroid,:);
[m n]=size(sample);
for i=1:m
    D(i)=dist(Z(1,:),sample(i,:)');%计算距离
end
[u I]=max(D);
T=thi*u;
Z=cat(1,Z,sample(I,:));
[k n1]=size(Z);
%按最大距离寻找聚类中心
while(u>T)
    for j=1:m
        for i=1:k
            temp(i)=dist(Z(i,:),sample(j,:)');
        end
        D(j)=min(temp);
    end
    [u I]=max(D);
    if(u>T)
        Z=cat(1,Z,sample(I,:));
    end
    [k n1]=size(Z);
end
Z
%按每个样本离聚类中心最小距离聚类
[num n]=size(Z);
class=cell(num,1);
for i=1:m
    for j=1:num
        temp(j)=dist(sample(i,:),Z(j,:)');
    end
    [v I]=min(temp);
    class{I}=cat(1,class{I},i);

end
celldisp(class);