function []=SimplexMethod()

clc; dbstop if error;

z=[11 16 15];
A=[1 2 3/2; 2/3 2/3 1; 1/2 1/3 1/2];
b=[1200; 460; 240];
SimplexLoop(z,A,b);


z=[2 3];
A=[2 1; 1 2];
b=[4; 5];
SimplexLoop(z,A,b);

z=[5 4];
A=[6 4; 1 2; -1 1; 0 1];
b=[24; 6; 1; 2];
SimplexLoop(z,A,b);

f=[1; 0; 0; 0];
A=[1 -3 2 5; 1 1 -4 6; 1 3 1 -2; 0 1 1 1; 0 -1 -1 -1];
b=[0; 0; 0; 1; -1];
Game(f,A,b);

f=[1; 0; 0; 0];
A=[1 -3 1 3; 1 2 -4 1; 1 5 6 -2; 0 1 1 1; 0 -1 -1 -1];
b=[0; 0; 0; 1; -1];
Game(f,A,b);

function []=SimplexLoop(z,A,b) 
T=zeros(size(b,1)+1,size(z,2)+size(b,1)+1);
T(1,1:size(z,2))=-z;
T(2:end,1:size(A,2))=A;
T(2:end,size(z,2)+1:size(z,2)+size(b,1))=eye(size(b,1));
T(2:end,end)=b
basic=[];
txt={};
while (1),
  [mx,p_col]=min(T(1,1:size(z,2)));
  for r=1:size(T,1),
    T_(r,:)=T(r,:)/T(r,p_col);
    if T_(r,end)<=0,
      T_(r,end)=Inf;
    end;
  end;
  [mi,p_row]=min(T_(:,end));
  basic=[basic p_row-1];
  new_p_row=T(p_row,:)/T(p_row,p_col);
  for r=1:size(T,1),
    T(r,:)=T(r,:)-T(r,p_col)*new_p_row;
  end;
  T(p_row,:)=new_p_row
  if size(basic,2)==size(z,2),
    if all(T(1,size(z,2)+basic)>0),
      for x=1:size(z,2),
        ix=find(T(:,x)==1);
        fprintf('x%d=%6.4f\n',x,T(ix,end));
      end;
      fprintf('Z=%6.4f\n\n',T(1,end));
      break;
    end;
  end;
end;

function []=Game(f,A,b)
disp(' ');
[X,fval]=linprog(-f,A,b);
for x=1:length(X),
  if x==1,
    fprintf('Fval=%6.4f\n',X(x));
  else
    fprintf('x%d=%6.4f\n',x-1,X(x));
  end;
end;


