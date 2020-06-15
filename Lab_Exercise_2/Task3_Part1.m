% Task 3_Part1
clc,clear,close all;

syms x y
tau = 0.01;
f = (y-x.^2).^2+(1-x).^2;

G = jacobian(f,[x,y]);
H = jacobian(G,[x,y]);
invH = inv(H);

%%

% Plotting the function
[X,Y] = meshgrid(-5:0.1:5);
F = (Y-X.^2).^2+(1-X).^2;
mesh(X,Y,F);
xlabel("X Points")
ylabel("Y Points")
zlabel("F Points")
title("(Y-X^2)^2+(1-X)^2")
hold on;

% Define Starting point
xP = -1;
yP = -1;
Point = [xP,yP];

% Calculate Gradient
Grad = GradientV(xP,yP);
Iteration = 1;

% Collecting Points for second plot
xValues = [xP];
yValues = [yP];
while (abs(Grad(1)) > tau || abs(Grad(2)) > tau)
    f = ObjFunc(Point(1),Point(2));
    Grad = GradientV(Point(1),Point(2))
    Hess = HessM(Point(1),Point(2));
    lastPoint = [Point(1),Point(2)];   
    Point = lastPoint-(Grad/Hess);
    xValues = [xValues,Point(1)];
    yValues = [yValues,Point(2)];
    Iteration = Iteration+1
    plot3(Point(1),Point(2),f,'r*');
%   
%   Alternatively can do inv(Hess)*Grad' but don't want to change the
%   convention. 
end

plot3(Point(1),Point(2),f,'g+','MarkerSize',10);
hold off;
time = 1:1:Iteration;
figure(2)
plot(time,xValues,'DisplayName','X Values');
xlabel("Iteration Number");
ylabel("X/Y Position");
title("Newton Method");
hold on;
plot(time,yValues,'DisplayName','Y Values');
legend


function [z] = ObjFunc(x,y)

    z = (y-x.^2).^2+(1-x).^2;

end

function Grad = GradientV(x,y)

    dx = 2*x-4*x*(-x^2+y)-2;
    dy = -2*x^2 + 2*y;
    
    Grad = [dx,dy];
    
end

function Hess = HessM(x,y)

    Hess = [12*x.^2-4.*y+2,-4*x;-4*x,2];

end