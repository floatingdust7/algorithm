function y=clus_perceptron(varargin)  %��֪�����෨
%�����ʽΪy=clus_perceptron(x1,x2,sample)
r1=length(varargin)-1;   %�����
test=[varargin{end} ones(size(varargin{end},1),1)];   %��������
c=size(varargin{1},2);  %����������ά��
for i=1:r1
   r(i)=size(varargin{i},1);
   varargin{i}=[varargin{i} ones(r(i),1)];%Ϊ���Լ���߼�����ֵȫΪ1��һ��
end
w=zeros(c+1,r1);k1=0;num=0;
while  k1<sum(r)&&num<1000
  num=num+1;
  for i=1:r1
    for j=1:r(i)
      d=w'*varargin{i}(j,:)';  %ÿ����Ʒÿ����ĺ���ֵ
      [a,b]=max(d);
      if length(find(a==d))>1   %����ֵ�����
          for k=1:r1
            if k==i
                 w(:,k)=w(:,k)+varargin{i}(j,:)';  %�������
            else 
                w(:,k)=w(:,k)-varargin{i}(j,:)';
            end
          end
          k1=0;
      elseif b~=i
           for k=1:r1
             if k==i
               w(:,k)=w(:,k)+varargin{i}(j,:)';
             else 
               w(:,k)=w(:,k)-varargin{i}(j,:)';
             end
           end
           k1=0;
      else
          k1=k1+1;                 %������ȷ
      end
    end
  end 
end

for i=1:size(test,1)
   d=w'*test(i,:)'
   [a,y(i)]=max(d)
end

     
            