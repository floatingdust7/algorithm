function y=syscluster(x,t,type,distype)  %系统聚类法，t为阈值,type为聚类类型
if nargin<4
    distype='euclidean';
end
r=size(x,1)
patternum=r
for i=1:r
   patter(i).num=[i x(i,:)]
end
switch type
 case 'single' %最小距离法
  while true
      mindis=inf;
      for i=1:patternum-1
          for j=i+1:patternum
            d(i,j)=min(min(pattern_dis(patter(i).num(1:end,2:end),patter(j).num(1:end,2:end),distype)));
            if d(i,j)<mindis
               mindis=d(i,j)
               idex_i=i
               idex_j=j
            end
          end
      end
      if mindis<=t
         if idex_i>idex_j
            patter(idex_j).num=[patter(idex_j).num;patter(idex_i).num];
            patter(idex_i).num=[];
            patternum=patternum-1;
         else
            patter(idex_i).num=[patter(idex_i).num;patter(idex_j).num];
            patter(idex_j).num=[];
            patternum=patternum-1;
         end
         for i=1:r  %重新编号
            if i>patternum
               patter(i).num=[];
               break
            elseif isempty(patter(i).num)
               patter(i).num=patter(i+1).num;
               patter(i+1).num=[];
            end
         end
      else
          break
      end
  end
 case 'complete'  %最长距离法
   while true
      mindis=inf;
      for i=1:patternum-1
          for j=i+1:patternum
            d(i,j)=max(max(pattern_dis(patter(i).num(1:end,2:end),patter(j).num(1:end,2:end),distype)));
            if d(i,j)<mindis
               mindis=d(i,j);idex_i=i;idex_j=j;
            end
          end
       end
       if mindis<=t
         if idex_i>idex_j
           patter(idex_j).num=[patter(idex_j).num;patter(idex_i).num];
           patter(idex_i).num=[];patternum=patternum-1;
         else
           patter(idex_i).num=[patter(idex_i).num;patter(idex_j).num];
           patter(idex_j).num=[];patternum=patternum-1;
         end
         for i=1:r  %重新编号
            if i>patternum
               patter(i).num=[];
               break
            elseif isempty(patter(i).num)
               patter(i).num=patter(i+1).num;
               patter(i+1).num=[];
            end
         end
       else
          break
       end
   end
 case  'cen'   %重心距离法
    d=squareform(pdist(x,distype));
    while true
      mindis=inf;
       for i=1:patternum-1
           for j=i+1:patternum
            if d(i,j)<mindis
               mindis=d(i,j);idex_i=i;idex_j=j;
            end
          end
       end
       i_num=0;j_num=0;
       if mindis<=t
            if idex_i>idex_j
              patter(idex_j).num=[patter(idex_j).num;patter(idex_i).num];
              patter(idex_i).num=[];patternum=patternum-1;
              j_num=j_num+1; 
            else
              patter(idex_i).num=[patter(idex_i).num;patter(idex_j).num];
              patter(idex_j).num=[];patternum=patternum-1;
              i_num=i_num+1;
            end
            for i=1:r  %重新编号
              if i>patternum
                 patter(i).num=[];
                 break
              elseif isempty(patter(i).num)
                 patter(i).num=patter(i+1).num;
                 patter(i+1).num=[];
              end
            end
         temp_dis=d;
         
         for i=1:patternum-1
             for j=i+1:patternum
                if (i<idex_i)
                    if (j==idex_i)
                        temp_dis(i,j)=sqrt((d(i,idex_i)^2*i_num+d(i,idex_j)^2*...
                            j_num-d(idex_i,idex_j)^2*i_num*j_num)/(i_num+j_num));
                    elseif j>=idex_j
                        temp_dis(i,j)=d(i,j+1);
                    else
                        temp_dis(i,j)=d(i,j);
                    end
                elseif i==idex_i
                    if j<idex_j
                       temp_dis(i,j)=sqrt((d(idex_i,j)^2*i_num+d(idex_j,j)^2*...
                                     j_num-d(idex_i,idex_j)^2*i_num*j_num)/(i_num+j_num));
                    else
                        temp_dis(i,j)=sqrt((d(idex_i,j+1)^2*i_num+d(idex_j,j+1)^2*...
                                      j_num-d(idex_i,idex_j)^2*i_num*j_num)/(i_num+j_num));
                    end
                elseif i>idex_i&&i<idex_j
                    if j<idex_j
                        temp_dis(i,j)=d(i,j);
                    else
                        temp_dis(i,j)=d(i,j+1);
                    end
                else
                    temp_dis(i,j)=d(i+1,j+1);
                end
             end
         end
         d=temp_dis;
       else
           break
       end
    end
end
for i=1:patternum   %输出结果
   r1=size(patter(i).num,1)
   for k=1:r1
     y(patter(i).num(k,1))=i
   end
end
   
    