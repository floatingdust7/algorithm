function [pattern,Z,classNum]=nearest_clustering(sample)
[N,m]=size (sample);
for i=1:N
    pattern(i).feature=sample(i,:);
    pattern(i).classno=0;
end
s=ceil(rand*N);
Z(1).feature=pattern(s).feature;
Z(1).id=1;
Z(1).patternNum=1;
pattern(s).classno=1;
classNum=0;
T=input('Input threshold:');
for i=1:N
    mindis=inf;
    index=1;
    for j=1:classNum
        dis=dist(pattern(i).feature,Z(j).feature');
        if dis<mindis
            mindis=dis;
            index=j;
        end
    end
    if mindis<T
        pattern(i).classno=Z(index).id;
        n=Z(index).patternNum;
        Z(index).patternNum=n+1;
        tempmean=Z(index).feature;
        Z(index).feature=(n*tempmean+pattern(i).feature)/(n+1);
    else
        classNum=classNum+1;
        pattern(i).classno=classNum;
        Z(classNum).feature=pattern(i).feature;
        Z(classNum).id=classNum;
        Z(classNum).patternNum=1;
    end
end
disp('显示聚类中心:')
for i=1:classNum
    fprintf('center %d:',Z(i).id)
    Z(i).feature
    Z(i).patternNum
end
disp('显示样本的类别')
for i=1:N
    fprintf('pattern %d classno: %d',i,pattern(i).classno)
    pattern(i).feature
end