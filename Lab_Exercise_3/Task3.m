% Task 3 KKT

clc;
clear;
close all;

syms x1 x2 lam1 lam2 lam3 lam4

f = (x1-1)^2+(x2-2)^2;
g = x2-x1-1;
% h1 = -x1;
% h2 = -x2;
h3 = x1+x2-2;

% KKT = f+lam1*g+lam2*h1+lam3*h2+lam4*h3;
KKT = f+lam1*g+lam2*h3;
dKKT = jacobian(KKT);
dKKT = dKKT(3:4);
% Constraints:
% lam1*g = 0
% lam2*h3 = 0
% 
% Cases that arise are either lam 1 = 0 or g = 0 or lam 2 = 0 or h3 = 0;

solution = [];

% Case 1: lam1 = 0
dKKTx1C1 = subs(dKKT(1),lam1,0);
dKKTx2C1 = subs(dKKT(2),lam1,0);
sol = solve(dKKTx1C1==0,dKKTx2C1==0,lam2*h3==0);
sol = [eval(sol.x1),eval(sol.x2),eval(sol.lam2)];
sol = [sol(1,1:2),0,sol(1,3);sol(2,1:2),0,sol(2,3)];
solution = [sol]
% Case 2: g = 0
dKKTx1C2 = subs(dKKT(1),x2,x1+1);
dKKTx2C2 = subs(dKKT(2),x2,x1+1);
sol = solve(dKKTx1C2==0,dKKTx2C2==0,lam2*h3==0,x2==x1+1);
sol = [eval(sol.x1),eval(sol.x2),eval(sol.lam1)];
sol = [subs(sol,lam2,0),0];
solution = [solution;sol];

% Case 3: lam2 = 0
dKKTx1C3 = subs(dKKT(1),lam2,0);
dKKTx2C3 = subs(dKKT(2),lam2,0);
sol = solve(dKKTx1C3==0,dKKTx2C3==0,lam1*g==0);
sol = [eval(sol.x1),eval(sol.x2),eval(sol.lam1),0];
solution = [solution;sol];

% Case 4: h3  = 0
dKKTx1C4 = subs(dKKT(1),x1,2-x2);
dKKTx2C4 = subs(dKKT(1),x1,2-x2);
sol = solve(dKKTx1C4==0,dKKTx2C4==0,lam1*g==0,x1==2-x2);
sol = [eval(sol.x1),eval(sol.x2),eval(sol.lam1)];
sol = subs(sol,lam2,0);
sol = [sol(1,1:3),0;sol(2,1:3),0];
solution = [solution;sol];

%  Check the constraints
for i=1:length(solution)

% Checks for x1 and x2 >=0
   if(solution(i,1) <0 || solution(i,2) < 0 )
       solution(i,:) = NaN;
   end

   if(solution(i,1)+solution(i,2) > 2 || solution(i,2)-solution(i,1) ~= 1 || solution(i,3)<0 || solution(i,4)<0)
      solution(i,:) = NaN;
       
   end
   
end

temp = solution(2,3:4);
solution(2,3) = temp(1,2);
solution(2,4) = temp(1,1);
solution