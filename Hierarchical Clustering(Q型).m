clc;
clear all;
close all;
data = [0.0691   69.3001
    0.0546   83.2147
    0.0031   30.0374
    0.0349    6.1978
    0.0789    6.4965
    0.0695   74.3847
    0.0470   66.6318
    0.0975   20.6388];
figure;
plot(data(:,1),data(:,2),'bo','MarkerSize',5,'markerface','b');
xlabel('出生死亡率')
ylabel('平均寿命')
grid on
datan = zscore(data);%对数据进行标准化处理
Y = pdist(datan,'euclidean');%求距离
squareform(Y)%方便查看
%squareform():为了方便展示个个数据之间的距离，输出为一个矩阵，例如矩阵中的位置（1，2）
%为第1个数据和第二个数据之间的距离。
Z = linkage(Y,'single');%是用指定的方法来进行层次聚类
Z1 = linkage(Y,'Complete');%是用指定的方法来进行层次聚类
Z2 = linkage(Y,'Average');%是用指定的方法来进行层次聚类
Z3 = linkage(Y,'Centroid');%是用指定的方法来进行层次聚类
figure;
subplot(2,2,1);
dendrogram(Z);%把linkage()生成的数据画成树状图。
xlabel('样本序号')
ylabel('类间距离')
title('最短距离')
subplot(2,2,2);
dendrogram(Z1);%把linkage()生成的数据画成树状图。
xlabel('样本序号')
ylabel('类间距离')
title('最大距离')
subplot(2,2,3);
dendrogram(Z2);%把linkage()生成的数据画成树状图。
xlabel('样本序号')
ylabel('类间距离')
title('无权平均距离')
subplot(2,2,4);
dendrogram(Z3);%把linkage()生成的数据画成树状图。
xlabel('样本序号')
ylabel('类间距离')
title('重心距离')