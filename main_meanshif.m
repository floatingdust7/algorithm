clc;                    %清理命令行的意思
clear;                  %清楚存储空间的变量,以免对下面的程序运行产生影响
close all;              %关闭所有图形窗口
% 生成数据
% Parameters for data generation
N = 300;  % Size of each cluster
r1 = 2;   % Radius of first circle
r2 = 4;   % Radius of second circle
theta = linspace(0,2*pi,N)';

X1 = r1*[cos(theta),sin(theta)] + rand(N,2); 
X2 = r2*[cos(theta),sin(theta)] + rand(N,2);
X = [X1; X2]; % Noisy 2-D circular data set

% 调用 MeanShift 算法
r = 0.5; % 核函数的半径
[idx, C] = meanshift(X, r);

% 绘制聚类结果的图形
% 绘制数据点
figure;
scatter(X(:,1), X(:,2), [], idx, 'filled');
hold on;
% 绘制簇中心
%scatter(C(:,1), C(:,2), 10, 'k', 'filled');
title('MeanShift 聚类结果');
xlabel('特征1');
ylabel('特征2');
legend('聚类簇', '簇中心');
hold off;

