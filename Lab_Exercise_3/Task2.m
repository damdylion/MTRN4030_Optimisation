% Task 2

clc;
close all;
syms x y Lam;
% This is the contraint
A = 2;
% Lagrangian Equation
L = 2*x*y+x^2+Lam*(x^2+y^2-2);
dLx = diff(L,x);
dLy = diff(L,y);
dLlam = diff(L,Lam);
% sol = solve(dLx==0)
% sol = solve(dLy==0)
% sol = solve(dLlam==0)
% sol  = solve(dLx == 0,dLy==0,dLlam == 0)
sol = solve([dLx==0,dLy==0,dLlam==0])
disp("ass")
sol=[eval(sol.x) eval(sol.y) eval(sol.Lam)]
for i=1:2
  if sol(i,1)>0 && sol(i,2)>0
    sx1=sol(i,1)
    sx2=sol(i,2)
    sLam=sol(i,3)
  end
end