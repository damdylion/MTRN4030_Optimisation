% Task 1: Simplex Method

%% North West Corner Method and Simplex Method

n =3;
m = 2;
d = [1500,2000,1000];
s = [2000,2500];
% Simplex Method
f = [8,6,10,10,4,9]; 
Aeq = [1,1,1,0,0,0;0,0,0,1,1,1;1,0,0,1,0,0;0,1,0,0,1,0;0,0,1,0,0,1];
Beq = [2000,2500,1500,2000,1000];
A = [];
B = [];
LB = [0,0,0,0,0,0];
UB = [];

NorthWestCorner = NorthWestCornerMethod(s,d,m,n)
X1 = linprog(f,A,B,Aeq,Beq,LB,UB);
Simplex = [X1(1),X1(2),X1(3);X1(4),X1(5),X1(6)]

disp('Cost of Simplex is:')
disp(8*Simplex(1)+6*Simplex(3)+10*Simplex(5)+10*Simplex(2)+4*Simplex(4)+9*Simplex(6))
disp('Cost of NorthWest is:')
disp(8*NorthWestCorner(1)+6*NorthWestCorner(3)+10*NorthWestCorner(5)+10*NorthWestCorner(2)+4*NorthWestCorner(4)+9*NorthWestCorner(6))

%% Functions

function [ x ] = NorthWestCornerMethod(s,d,m,n )
% n= number of destination (input scalar)
% m= number of plant (input scalar)
% s= vector of supply ( input vector )
% d=vector of demand  (input vector )
% x = occuplied matrix ( output matrix)

for i=1:m;
    supply(i)=s(i);
end;
for j=1:n;
    demand(j)=d(j);
end;
for j=1:n;
  while demand(j)>0;
    for i=1:m;
%        See if we've reached the end of the loop
           if supply(i)>0 &&  demand(j)>0; 
               iall=i;
               jall=j;
               break;
           end;
      end;
%   If Demand is larger than supply
    if demand(jall)>supply(iall);
       demand(jall)=demand(jall)-supply(iall);
       x(iall,jall)=supply(iall);
       supply(iall)=0;
%   If Demand is less than supply   
    elseif demand(jall)<supply(iall);
        supply(iall)=supply(iall)-demand(jall);
        x(iall,jall)=demand(jall);
        demand(jall)=0;
%   If Demand is equal to supply
    elseif demand(jall)==supply(iall); 
         x(iall,jall)=demand(jall);
        demand(jall)=0;
        supply(iall)=0;
       
    end;
   end;
 end;
end


