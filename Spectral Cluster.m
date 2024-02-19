close all; 
clear;

rng('default') % For reproducibility

% Parameters for data generation
N = 300;  % Size of each cluster
r1 = 2;   % Radius of first circle
r2 = 4;   % Radius of second circle
theta = linspace(0,2*pi,N)';

X1 = r1*[cos(theta),sin(theta)] + rand(N,2); 
X2 = r2*[cos(theta),sin(theta)] + rand(N,2);
X = [X1; X2]; % Noisy 2-D circular data set

% Find two clusters in the data by using spectral clustering.
idx = spectralcluster(X, 2);

% Visualize the result of clustering.
figure
gscatter(X(:,1), X(:,2), idx);

rng('default') % For reproducibility
N = 500;
X = [mvnrnd([0 0], eye(2), N); ...
    mvnrnd(5*[1 -1], eye(2), N); ...
    mvnrnd(5*[1 1], eye(2), N)];
idx = spectralcluster(X, 3, 'SimilarityGraph', 'epsilon', 'Radius', 2);
figure
gscatter(X(:,1), X(:,2), idx);
