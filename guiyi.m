function y=guiyi(x)
[r,c]=size(x);
if ~iscell(x)
   a1=mean(x);stdr=std(x);
   y=(x-a1(ones(r,1),:))./stdr(ones(r,1),:);
else
   a1=mean(cell2mat(x));stdr=std(cell2mat(x));
   for i=1:r
     for j=1:c
        y(i,j)={(cell2mat(x(i,j))-a1(j))/stdr(j)};
     end
   end
end
