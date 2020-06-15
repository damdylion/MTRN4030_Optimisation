% Task 3
clc,clear,close all;

syms x y
tau = 0.01;
f = (x-1).^2+(y-2).^2

G = jacobian(f,[x,y])
H = jacobian(G,[x,y])
invH = inv(H);

[X,Y] = meshgrid(-5:0.1:5);
F = (X-1).^2+(Y-2).^2;
mesh(X,Y,F);
xlabel("X Points")
ylabel("Y Points")
zlabel("F Points")
title("(X-1)^2+(Y-2)^2")
hold on;

xP = -3;
yP = -3;

Point = [xP,yP];
Grad = GradientV(xP,yP);
Iteration = 1;
xValues = [xP];
yValues = [yP];
fValues = [ObjFunc(xP,yP)];
while (abs(Grad(1)) > tau || abs(Grad(2)) > tau)
    
    
    f = ObjFunc(Point(1),Point(2));
    plot3(Point(1),Point(2),f,'r*');
    Grad = GradientV(Point(1),Point(2));
    Hess = HessM(Point(1),Point(2));
    lastPoint = [Point(1),Point(2)];   
    Point = lastPoint-(Grad/Hess);
    xValues = [xValues,Point(1)];
    yValues = [yValues,Point(2)];
    fValues = [fValues,f];
    Iteration = Iteration+1;
    
    
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
figure(1)
for i = 1:length(xValues)-1
   if i+1 == length(xValues)-1
       disp("ffff")
      break; 
   else
      plot3(xValues(i:i+1),yValues(i:i+1),fValues(i,i+1),'r-'); 
   end
   
end

function [z] = ObjFunc(x,y)

    z = (x-1).^2+(y-2).^2;

end

function Grad = GradientV(x,y)

    dx = 2*x-2;
    dy = 2*y-4;
    
    Grad = [dx,dy];
    
end

function Hess = HessM(x,y)

    Hess = [2,0;0,2];

end