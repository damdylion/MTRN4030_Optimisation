% Task 3 Part 2

clc;
clear;
close all;
syms x1 x2 lam

f = 3*x1+sqrt(3)*x2;
g = 18/x1+6*sqrt(3)/x2-3;

KKT = f+lam*g;
dKKT = jacobian(KKT);
dKKT = dKKT(2:3);

% Case 1: lam = 0
dKKTx1C1 = subs(dKKT(1),lam,0);
dKKTx2C1 = subs(dKKT(2),lam,0);
% Volation as ~= 0

% Case 2: g = 0
dKKTx1C2 = subs(dKKT(1),x1,((18*x2)/(3*x2-6*sqrt(3))));
dKKTx2C2 = subs(dKKT(2),x1,18*x2/(3*x2-6*sqrt(3)));
sol = solve(dKKTx1C2==0,dKKTx2C2==0,g==0);
sol = [eval(sol.x1),eval(sol.x2),eval(sol.x2).^2/6];

for i=1:size(sol,1)
    
    if( sol(i,1)<5.73 ||sol(i,2)<7.17)
        sol(i,:) = NaN;
    end
    
end
output =[];
for i=1:size(sol,1)
    
    if(isnan(sol(i,1)))
       
        output(i,1) = NaN;
        
    end
    output(i,1)= 3*sol(i,1)+sqrt(3)*sol(i,2);
    
end

small = min(output);
index = find(output == small);
disp("Values are in x1,x2 and lambda are:")
disp(sol(index,:))