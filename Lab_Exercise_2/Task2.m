% Task 2 for Lab Exercise 2
% By Dylan Dam z5115759
% MTRN4030 19T3

tau = 0.1;

% Plotting the objective Function
[X,Y] = meshgrid(-5:0.1:5);
Z = 10*(X-2).^2+X.*Y+10*(Y-1).^2;
mesh(X,Y,Z);
zlabel("f")
xlabel("x");
ylabel("y");
hold on;

% Golden section method
rho = (3-sqrt(5))/2;
xL = -5;
yL = -5;
xH = 5;
yH = 5;
xRange = xH-xL;
yRange = yH-yL;
T = 0;

xSearch(1) = xL+rho*xRange;
ySearch(1) = yL+rho*yRange;
xSearch(2) = xH-rho*xRange;
ySearch(2) = yH-rho*yRange;
[g(1)] = ObjFunc(xSearch(1),ySearch(1));
[g(2)] = ObjFunc(xSearch(1),ySearch(2));
[g(3)] = ObjFunc(xSearch(2),ySearch(1));
[g(4)] = ObjFunc(xSearch(2),ySearch(2));
T = T+1; disp([T,[xSearch(1:2),ySearch(1:2)]]);
plot3(xSearch(1),ySearch(1),g(1),"r*",'MarkerSize',6);
plot3(xSearch(1),ySearch(2),g(2),"r*",'MarkerSize',6);
plot3(xSearch(2),ySearch(1),g(3),"r*",'MarkerSize',6);
plot3(xSearch(2),ySearch(2),g(4),"r*",'MarkerSize',6);

while xRange > tau || yRange > tau
    
    small = min(g);
    index = find(small == g);
    if index == 1
        xH = xSearch(2);
        yH = ySearch(2);
        xRange = xH-xL;
        yRange = yH-yL;
        xSearch(1) = xL+rho*xRange;
        xSearch(2) = xH-rho*xRange;
        ySearch(2) = yH-rho*yRange;
        ySearch(1) = yL+rho*yRange;
        [g(1)] = ObjFunc(xSearch(1),ySearch(1));
        [g(2)] = ObjFunc(xSearch(1),ySearch(2));
        [g(3)] = ObjFunc(xSearch(2),ySearch(1));
        [g(4)] = ObjFunc(xSearch(2),ySearch(2));
        plot3(xSearch(1),ySearch(1),g(1),"r*",'MarkerSize',6);
        plot3(xSearch(1),ySearch(2),g(2),"r*",'MarkerSize',6);
        plot3(xSearch(2),ySearch(1),g(3),"r*",'MarkerSize',6);
        plot3(xSearch(2),ySearch(2),g(4),"r*",'MarkerSize',6);
        
    elseif index == 2
        xH = xSearch(2);
        yL = ySearch(1);
        xRange = xH-xL;
        yRange = yH-yL;
        xSearch(1) = xL+rho*xRange;
        xSearch(2) = xH-rho*xRange;
        ySearch(2) = yH-rho*yRange;
        ySearch(1) = yL+rho*yRange;
        [g(1)] = ObjFunc(xSearch(1),ySearch(1));
        [g(2)] = ObjFunc(xSearch(1),ySearch(2));
        [g(3)] = ObjFunc(xSearch(2),ySearch(1));
        [g(4)] = ObjFunc(xSearch(2),ySearch(2));
        plot3(xSearch(1),ySearch(1),g(1),"r*",'MarkerSize',6);
        plot3(xSearch(1),ySearch(2),g(2),"r*",'MarkerSize',6);
        plot3(xSearch(2),ySearch(1),g(3),"r*",'MarkerSize',6);
        plot3(xSearch(2),ySearch(2),g(4),"r*",'MarkerSize',6);
        
    elseif index == 3
        xL = xSearch(1);
        yH = ySearch(2);
        xRange = xH-xL;
        yRange = yH-yL;
        xSearch(1) = xL+rho*xRange;
        xSearch(2) = xH-rho*xRange;
        ySearch(2) = yH-rho*yRange;
        ySearch(1) = yL+rho*yRange;
        [g(1)] = ObjFunc(xSearch(1),ySearch(1));
        [g(2)] = ObjFunc(xSearch(1),ySearch(2));
        [g(3)] = ObjFunc(xSearch(2),ySearch(1));
        [g(4)] = ObjFunc(xSearch(2),ySearch(2));
        plot3(xSearch(1),ySearch(1),g(1),"r*",'MarkerSize',6);
        plot3(xSearch(1),ySearch(2),g(2),"r*",'MarkerSize',6);
        plot3(xSearch(2),ySearch(1),g(3),"r*",'MarkerSize',6);
        plot3(xSearch(2),ySearch(2),g(4),"r*",'MarkerSize',6);
        
    elseif index == 4
        xL = xSearch(1);
        yL = ySearch(1);
        xRange = xH-xL;
        yRange = yH-yL;
        xSearch(1) = xL+rho*xRange;
        ySearch(1) = yL+rho*yRange;
        xSearch(2) = xH-rho*xRange;
        ySearch(2) = yH-rho*yRange;
        [g(1)] = ObjFunc(xSearch(1),ySearch(1));
        [g(2)] = ObjFunc(xSearch(1),ySearch(2));
        [g(3)] = ObjFunc(xSearch(2),ySearch(1));
        [g(4)] = ObjFunc(xSearch(2),ySearch(2));
        plot3(xSearch(1),ySearch(1),g(1),"r*",'MarkerSize',6);
        plot3(xSearch(1),ySearch(2),g(2),"r*",'MarkerSize',6);
        plot3(xSearch(2),ySearch(1),g(3),"r*",'MarkerSize',6);
        plot3(xSearch(2),ySearch(2),g(4),"r*",'MarkerSize',6);
        
    else
       break; 
    end
        disp(rho)
        T = T+1;
end

disp("Average for x and y is:")
disp(mean(xSearch(1:2)))
disp(mean(ySearch(1:2)))
disp("No. of iterations:")
disp(T)
disp("F:")
disp(ObjFunc(mean(xSearch(1:2)),mean(ySearch(1:2))))
function [z] = ObjFunc(x,y)
    z = 10*(x-2).^2+x.*y+10*(y-1).^2;

end
