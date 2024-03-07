function pattern=layercluster(sample)
%sample=[0 0 0;0 1 1;2 1 0;3 3 3;4 3 4;6 4 1];
    [N,m]=size(sample);
    T=input('类间距离间隔:');
    for i=1:N
        pattern(i).feature=sample(i,:);
        pattern(i).classno=i;

    end
    while(true)
        minDis=inf;
        c1=0;
        c2=0;
        %寻找距离最近的两类类号，记录最小距离
        for i=1:N-1
            for j=i+1:N
                if(pattern(i).classno~=pattern(j).classno)
                    dis=dist(pattern(i).feature,pattern(j).feature');
                    if(dis<minDis)
                        minDis=dis;
                        c1=pattern(i).classno;
                        c2=pattern(j).classno;
                    end
                end
            end
        end
        if(minDis>T)
            break;
        else
            if(c1>c2)
                temp=c1;
                c1=c2;
                c2=temp;
            end
            for(i=1:N)
                if pattern(i).classno==c2
                    pattern(i).classno=c1;
                elseif pattern(i).classno>c2
                    pattern(i).classno=pattern(i).classno-1;
                end
            end
        end
    end
    %输出样本及其所属类号
    for i=1:N
        fprintf('第%d个样本及其所属类号：',i);
        pattern(i).feature
        pattern(i).classno
    end