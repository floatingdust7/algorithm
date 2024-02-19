function [idx, C] = meanshift(X, r)
% X: n-by-p matrix, each row is a data point
% r: 核函数的半径
% idx: n-by-1 向量，每个数据点的簇索引
% C: K-by-p 矩阵，每行是一个簇中心

[n, p] = size(X);
idx = zeros(n, 1);
C = [];

visited = false(n, 1);
max_iter = 3000;  % 最大迭代次数

for i = 1:n
    if visited(i)
        continue;
    end
    
    visited(i) = true;
    
    % 以当前点作为中心开始一个新的簇
    C(end+1,:) = X(i,:);
    idx(i) = size(C, 1);

    iter = 0;        % 当前迭代次数
    while iter < max_iter
        % 计算半径为 r 内所有点的核权重
        dist = sqrt(sum((X - C(end,:)).^2, 2));
        w = exp(-dist.^2 / (2*r^2));
        
        % 计算加权均值漂移向量
        ms = sum(X .* w, 1) / sum(w);
        
        % 检查收敛条件
        if norm(ms - C(end,:)) < eps
            break;
        end
        
        % 移动到新位置
        C(end+1,:) = ms;

        % 更新迭代次数
        iter = iter + 1;
    end
    
    % 将相同簇中的所有点分配到相同的簇索引
    idx(dist <= r & idx == 0) = size(C, 1);
end

end
