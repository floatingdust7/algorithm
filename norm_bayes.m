function d=norm_bayes(w1,w2,P_w1,P_w2)
%两类的先验概率
% P_w1=1/2;
% P_w2=1/2;
% w1=[1 0 1;1 0 0;0 0 0;1 1 0];
% w2=[0 0 1;0 1 1;1 1 1;0 1 0];
M1=mean(w1)';
M2=mean(w2)';
C1=cov(w1);
C2=cov(w2);
C1_inv=inv(C1);
C2_inv=inv(C2);
syms x1 x2 x3 d;
X=[x1;x2;x3];
X1=[x1 x2 x3];
d1=log(P_w1)-1/2*log(det(C1))-1/2*((X1-M1')*C1_inv*(X-M1))
d2=log(P_w2)-1/2*log(det(C2))-1/2*((X1-M2')*C1_inv*(X-M2))
d=simplify(d1-d2)
