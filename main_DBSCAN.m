clc;                    %清理命令行的意思
clear;                  %清楚存储空间的变量,以免对下面的程序运行产生影响
close all;              %关闭所有图形窗口
 
%% Load Data            %定义data.mat数据文件加载模块
 
% 生成四个不同的簇
cluster1 = [randn(100, 1)*0.5+2, randn(100, 1)*0.5+2];
cluster2 = [randn(100, 1)*0.5-2, randn(100, 1)*0.5+2];
cluster3 = [randn(100, 1)*0.5+2, randn(100, 1)*0.5-2];
cluster4 = [randn(100, 1)*0.5-2, randn(100, 1)*0.5-2];

% 合并成一个数据集
% 生成圆圈数据
theta_circle = linspace(0, 2*pi, 1000); % 角度范围
radius_circle = 5; % 圆圈半径
x_circle = radius_circle * cos(theta_circle);
y_circle = radius_circle * sin(theta_circle);

% 生成小团点数据
x_cluster = randn(100, 1) * 0.5;
y_cluster = randn(100, 1) * 0.5;

% 合并数据
data = [x_circle', y_circle'; x_cluster, y_cluster];   %数据读取
X=data;
 
 
%% Run DBSCAN Clustering Algorithm    %定义Run运行模块
 
epsilon=0.5;                          %规定两个关键参数的取值
MinPts=10;
IDX=DBSCAN(X,epsilon,MinPts);         %传入参数运行
 
 
%% Plot Results                       %定义绘图结果模块
 
PlotClusterinResult(X, IDX);          %传入参数，绘制图像
title(['DBSCAN Clustering (\epsilon = ' num2str(epsilon) ', MinPts = ' num2str(MinPts) ')']);
