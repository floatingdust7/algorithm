function y=pattern_dis(pattern1,pattern2,distype)   %求各模式间的距离
%其中pattern1和pattern2为两个不同的模式，要求具有相同的维数,distype为距离类型
if nargin<3
    distype='euclidean';
end
switch distype
    case 'euclidean'
        y=f(pattern1,pattern2,distype);
    case 'seuclidean'
        y=f(pattern1,pattern2,distype);
    case 'cityblock'
        y=f(pattern1,pattern2,distype);
    case 'mahalanobis'
        y=f(pattern1,pattern2,distype);
    case 'minkowski'
        y=f(pattern1,pattern2,distype);
    case 'hamming'  
        y=f(pattern1,pattern2,distype);
    case  'chebychev'
        y=f(pattern1,pattern2,distype);
    case'cosine'
         y=f(pattern1,pattern2,distype);
end
 
function d=f(x,y,distype)
  r1=size(x,1);r2=size(y,1);
  for i=1:r1
     for j=1:r2
       d(i,j)=pdist([x(i,:);y(j,:)],distype);
     end
  end
  
   