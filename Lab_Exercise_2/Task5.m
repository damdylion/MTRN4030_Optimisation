% Task 5
clear,clc,close all;

xRange = linspace(2,14,1000);
yRange = linspace(0.2,0.8,1000);
xRange = xRange(2)-xRange(1);
yRange = yRange(2)-yRange(1);

% General plot
x = 2:xRange:14;
y = 0.2:yRange:0.8;
[X,Y] = meshgrid(x,y);
F = 9.82.*X.*Y+2.*X;
figure(1)
mesh(X,Y,F)
zlabel("f")
xlabel("x_1");
ylabel("x_2");
hold on;

sigI = SigIStress(X,Y);
sigB = SigBStress(X,Y);

index = find(sigI > 0 | sigB > 0);
[fR,fC] = ind2sub([size(F,1),size(F,2)],index);
X(index) = NaN;
Y(index) = NaN;
F(index) = NaN;
figure(2);
mesh(X,Y,F)
hold on
small = min(F);
smallest = min(small);
index = find(F == smallest);
[row,col] = ind2sub([size(F,1),size(F,2)],index);
d = X(row,col)
t = Y(row,col)
f = F(row,col)
plot3(d,t,f,'rO','MarkerSize',10);
zlabel("f")
xlabel("x_1");
ylabel("x_2");
format = "d = %.2f, t = %.2f, f = %.2f";
str = sprintf(format,d,t,f);
text(d,t,f,str);

function sigI = SigIStress(x,y)

    sigI = (2500./(pi.*x.*y))-500;

end

function sigB = SigBStress(x,y)


    sigB = (2500./(pi.*x.*y))-(pi^2.*(0.85*10^6).*(x.^2+y.^2))./(8*250^2);

end

function f = ObjectiveFunction(x,y)
    
    f = 9.82*x.*y+2*x;

end