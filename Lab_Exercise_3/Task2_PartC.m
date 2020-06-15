% Task 2 Attempt 2

clc;
close all;
syms x y z Lam ;
% This is the contraint
A = 2;
% Lagrangian Equation
f = 8*x*y*z^2-200*(x+y+z)+Lam*(x+y+z-100);
% f = x*y*(2+x)+Lam*(x^2+y^2-2);
dl = jacobian(f);
sol = solve(dl(1)==0,dl(2)==0,dl(3)==0,dl(4)==0);
sol = [eval(sol.x),eval(sol.y),eval(sol.z),eval(sol.Lam)]
sol = double(sol);

% for i = 1:length(sol)
%     if(isreal(sol(i,1))~=1 || isreal(sol(i,2))~=1 || isreal(sol(i,3))~=1 || isreal(sol(i,4))~=1)      
%         sol(i,1:4) = NaN;       
%     end 
% end

output = [];
for i=1:size(sol,1)
    
    val = 8*sol(i,1)*sol(i,2)*sol(i,3)-200*sum(sol(i,1:3));
    output = [output,val];
    
end
highest = max(output);
lowest = min(output);

disp("Max is: ")
index = find(output == highest);
disp(sol(index,1:2));
big=[sol(index,1:2),highest];

% disp("Min is: ")
% index = find(output == lowest);
% disp(sol(index,1:2));
% small=[sol(index,1:2),lowest];

%% Plotting stuff
offset = 5;
x = -4:0.1:4;
y = x;
[X,Y] = meshgrid(x,y);
F= X.*Y.*(2+X);
% F = 2*X.*Y+X.^2.*Y;
mesh(x,y,F);
hold on;
xlabel("X")
ylabel("Y")
zlabel("f")
title("f = XY(2+X), constrained @ X^2+Y^2=2")
circle(0,0,sqrt(2));
plot3(big(1),big(2),big(3),'r*','MarkerSize',20);
format = "x = %.2f, y = %.2f, f = %.2f";
str1 = sprintf(format,big(1),big(2),big(3));
text(big(1),big(2),big(3)+offset,str1);
plot3(small(1),small(2),small(3),'b*','MarkerSize',20);
str2 = sprintf(format,small(1),small(2),small(3));
text(small(1),small(2),small(3)+offset,str2);

function h = circle(x,y,r)
hold on
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h = plot(xunit, yunit,'r-',"MarkerSize", 20);
end



    