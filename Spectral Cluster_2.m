% 清空变量
warning off             % 关闭报警信息
close all               % 关闭开启的图窗
clear                   % 清空变量
clc                     % 清空命令行


N = 500;
X = [mvnrnd([0 0], eye(2), N); ...
    mvnrnd(5*[1 -1], eye(2), N); ...
    mvnrnd(5*[1 1], eye(2), N)];
data = X;

% 计算相似度矩阵
D = pdist(data);
S = squareform(D);
sigma = median(S(:))/0.6745; % 自适应带宽，0.6745为常数
W = exp(-S.^2/(2*sigma^2)); % 高斯核函数

% 计算度矩阵
D = diag(sum(W));

% 计算拉普拉斯矩阵
L = D - W;

% 计算特征值和特征向量
[U, Lambda] = eig(L);

% 对特征向量进行归一化
for i=1:size(U, 2)
    U(:, i) = U(:, i)/norm(U(:, i));
end

% 取前k个特征向量
k = 3;
V = U(:, 1:k);

% 对特征向量进行聚类
C = kmeans(V, k);

% 可视化聚类结果
gscatter(data(:, 1), data(:, 2), C);
