clc;
clear all;
close all;
data = [5  1.4  6  3  5  7
  9  2  30  7  5  9
  8  1.8  11  5  7  5
  12  2.5  18  7  5  5];
data1 = zscore(data);%数据标准化
r = corrcoef(data1) %计算相关系数矩阵
d = pdist(data1','correlation'); %计算相关系数导出的距离
z = linkage(d,'average');%按平均法聚类
h = dendrogram(z);%画聚类图
set(h,'color','b','linewidth',1.3);%修改聚类图的属性
T = cluster(z,'maxclust',2);%把变量划分成2类
for i = 1:2
    tm = find(T ==i);%求第i类的对象
    tm = reshape(tm,1,length(tm));%变成行向量
    fprintf('第%d类的有%s\n',i,int2str(tm));%显示分类的结果
end