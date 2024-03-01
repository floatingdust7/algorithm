function result=fisher(varargin)%fish两类分类函数，
r1=length(varargin)-1;   %求类别
test=varargin{end};
num=nchoosek(1:r1,2); %两两配对
Training={varargin{1:end-1}};
y=cell(size(num,1),1);
for kk=1:size(test,1)
  for i=1:size(num,1)
    y=f(Training{num(i,1)},Training{num(i,2)},test(kk,:));  %每类的分类结果
    temp(i)=num(i,1).*~y+num(i,2).*y %每个分类器的分类结果
  end
   result(kk)=mode(temp,2)       %依据每个数字出现的次数，决定总的分类结果
end

function y=f(x1,x2,sample)
%x1,x2,sample分别为训练样本和待分类样本，有r行和c列（特征）
r1=size(x1,1);r2=size(x2,1);
r3=size(sample,1);
a1=mean(x1)';
a2=mean(x2)';
s1=cov(x1)*(r1-1);
s2=cov(x2)*(r2-1);
sw=s1+s2;
w=inv(sw)*(a1-a2)*(r1+r2-2);
y1=mean(w'*a1);
y2=mean(w'*a2);
y0=(r1*y1+r2*y2)/(r1+r2)
for i=1:r3
  y(i)=w'*sample(i,:)'
   if y(i)>y0
      y(i)=0
   else
      y(i)=1
   end
end

%%
%测试用例
% x=[2.79 7.80 13.85 49.60
% 4.67 12.31 22.31 47.80
% 4.63 16.81 28.82 62.15
% 3.54 7.58 15.29 43.20
% 4.90 16.12 28.29 58.70
% 1.06 1.22 2.18 20.60
% 0.80 4.06 3.85 27.10
% 0.00 3.50 11.40 0.00
% 2.42 2.14 3.66 15.00
% 0.00 5.68 12.10 0.00
% 2.40 14.30 7.90 33.20
% 5.10 4.43 22.40 54.60];
% y=fisher(x(1:5,:),x(6:10,:),x(11:12,:));