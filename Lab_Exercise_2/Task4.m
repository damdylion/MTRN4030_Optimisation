% Part 2 Mechanical Systems
% Task 4
clc,clear,close all;

global tau;
tau = 0.01;
ROI = Bracketing;
[fibIt,fibLam] = Fibonacci(ROI);
[BisIt,BisLam] = Bisection(ROI);
disp("Bracket:")
disp(ROI)
disp("Fibonacci's Iteration:")
disp(fibIt);
disp("Fibonacci's Lambda:")
disp(fibLam);
disp("Bisection's Iteration:")
disp(BisIt);
disp("Bisection's Lambda:")
disp(BisLam);

function z = Bracketing()

    clear,clc;
    global tau
    lambda = linspace(0.01,1.5,10000);
    f = ObjectiveFunction(lambda);
    figure(1);
    plot(lambda,f);
    grid on;
    hold on;
%     rho = [1 1.1 1.21];
    z = lambda(1:3);
    Iteration = 0;
    g = ObjectiveFunction(z);
    Checker = 1;
    while(Checker == 1)
       if(g(1)<g(2) && g(2)>g(3)) 
        z = [z(1) z(3)];
%         Range = z(3)-z(1)
        Checker = 0;
       elseif g(1)>g(2) && g(2)>g(3)
            z(2:3) = z(1:2);
            g(2:3) = g(1:2);
            z(1) = z(1)-0.5;
            g(1) = ObjectiveFunction(z(1));
       else
           z(1:2) = z(2:3);
           g(1:2) = g(2:3);
           z(3) = z(3)*2;
           g(3) = ObjectiveFunction(z(3));
%            Range = z(3)-z(1)
       end
       Iteration = Iteration+1;
       plot(z(end),g(end),'*');
       title("Bracketing Method");
       ylabel("f");
       xlabel("lambda");
%        disp("Lambda is:")
%        disp(z);
%        disp("G is:")
%        disp(g);
%        disp("No. of Iterations")
%        disp(Iteration)
    end
end

function [Iteration,x] = Fibonacci(ROI)

    global tau;
%     clc, clear;
    points=linspace(0,2,500);
    f=ObjectiveFunction(points);
    figure(2);
    plot(points,f);
    hold on;
    xL = ROI(1);
    xH = ROI(2);
    xRange = xH-xL;
    Iteration = 0;
    F(1) = 0;
    F(2) = 1;
    while(1/F(end)>tau)
       F(end+1)=F(end)+F(end-1);        
    end
    F(1:2) = [];
    disp(F)
    N = size(F,2)-1;
    for k=1:N
        rho(k) = 1-F(N-k+1)/F(N-k+2);
    end
    rho(end) = rho(end)-tau;
    disp(rho)
    x(1) = xL+rho(Iteration+1)*xRange;
    g(1) = ObjectiveFunction(x(1));
    x(2) = xH-rho(Iteration+1)*xRange;
    g(2) = ObjectiveFunction(x(2));
    Iteration = Iteration+1;
%     disp([Iteration g]);
    plot(x,g,'*');
    while Iteration<N
       if g(1)<g(2)
           xL = x(1);
           xRange = xH-xL;
           g(1) = g(2);
           x(1) = x(2);
           x(2) = xH-rho(Iteration+1)*xRange;
           g(2) = ObjectiveFunction(x(2));
       elseif g(1)>g(2)
           xH = x(2);
           xRange = xH-xL;
           g(2) = g(1);
           x(2) = x(1);
           x(1) = xL+rho(Iteration+1)*xRange;
           g(1) = ObjectiveFunction(x(1));
       elseif g(1) == g(2)
           disp("Broke")
           x = mean(x(1:2));
           break;
       end
       Iteration = Iteration+1;
       plot(x,g,'*');
       title("Fibonacci Method");
       ylabel("f");
       xlabel("lambda");
%        disp("No. of Iteration:")
%        disp(Iteration)
%        disp("Lambda:")
       disp(rho);
    end
end

function [Iteration,x] = Bisection(ROI)
    
    global tau;
%     clc,clear;
    points=linspace(0,2,500);
    f=ObjectiveFunction(points);
    figure(3);
    plot(points,f);
    hold on;
    rho = 0.5;
    xL = ROI(1);
    xH = ROI(2);
    Iteration = 0;
    x = (xL+xH)/2;
    g = ObjectiveFunction(x);
    df = dObjectiveFunction(x);
    Iteration = Iteration+1;
    plot(x,g,'*');
%     disp("No. of Iteration:")
%     disp(Iteration)
%     disp("Lambda:")
%     disp(x);
    while abs(df) > tau
        if df < 0
            xH = x;
        elseif df > 0
            xL = x;
        end
        x = rho*(xL+xH);
        g = ObjectiveFunction(x);
        df = dObjectiveFunction(x);
       Iteration = Iteration+1;
       plot(x,g,'*');
       title("Bisection Method");
       ylabel("f");
       xlabel("lambda");
%        disp("No. of Iteration:")
%        disp(Iteration)
%        disp("Lambda:")
%        disp(x);
    end
    
end
    
function [f] = ObjectiveFunction(lambda)

    f = (0.75./(1+lambda.^2))+(0.65*lambda.*atan(1./lambda))-0.65;
    

end

function [df] = dObjectiveFunction(lambda)

% syms lambda
% f = (0.75./(1+lambda.^2))+(0.65*lambda.*atan(1./lambda))-0.65;
% df = diff(f,lambda)

    df = (13*atan(1./lambda))/20 - (3*lambda)/(2*(lambda.^2 + 1)^2) - 13/(20*lambda*(1./lambda.^2 + 1));
end
