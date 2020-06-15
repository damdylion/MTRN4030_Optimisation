clear
clc
close all

Tol=0.1; % tolerance
Tspan=0.72; % integration limit
X0=[0.09 0.09]; % initial system state
R = [0,0.5];
u = 0;
% PSO Parameters
PSO.Gen = 50;
PSO.N = 50;
PSO.weight = 0.6;
PSO.r1 = 1.5;
PSO.r2 = 1.5;
% PSO.Velocity = zeros(PSO.N,221);
PSO.Velocity = zeros(PSO.N,1);
PSO.GbestHistory = [];
PSO.currGbest = realmax;
PSO.PbestHistory = [];
PSO.currPBest = ones(PSO.N,1)*realmax;
FitHistory = [];
fitP = [];
% Generating Particles
for n = 1:PSO.N
%     Generating the current Positions of Particles
%    for i=1:221
%         PSO.X(n,i) = R(1)+rand(1)*(R(2)-R(1));
%    end
    PSO.X(n,1) = NewParticle(R);
end

for n=1:PSO.Gen
    for z=1:PSO.N
        Options=odeset("RelTol",Tol); % option sets for integration
        [T,X]=ode45(@(t,x) intgrl(t,x,PSO.X(z,:)),[0 Tspan],X0,Options);
        Fit=sum(sum(X.^2,2)+0.1*sum(PSO.X(z,:).^2));
        fitP(z,:) = Fit;
%         if Fit < PSO.currGbest
        if fitP(z,:) < PSO.currGbest
           PSO.currGbest = fitP(z,:);
           PSO.GbestHistory = PSO.X(z,:);
        end
%         if PSO.X(z,:) < PSO.currPBest(z)
        if fitP(z,:) < PSO.currPBest(z)
           PSO.PbestHistory(z,:) = PSO.X(z,:);
           PSO.currPBest(z,:) = fitP(z,:);
        end
    end
    FitHistory = [FitHistory,PSO.currGbest];
%     PSO Update
    PSO.Velocity = PSO.weight*PSO.Velocity+PSO.r1*rand(PSO.N,1).*(repmat(PSO.GbestHistory,PSO.N,1)-PSO.X)+PSO.r2*rand(PSO.N,1).*(PSO.PbestHistory-PSO.X);
    PSO.X=PSO.X+PSO.Velocity;
    for m = 1:PSO.N
       mi = min(PSO.X(m,1));
       mx = max(PSO.X(m,1));
       if(mi<R(1) || mx > R(2))
           PSO.X(m,:)=NewParticle(R);
       end
    end
%     disp(PSO.X(1))
%     disp(fitP(1))
    format = "Current Optimal Control Signal: %.10f";
    str = sprintf(format,PSO.GbestHistory);
    disp(str);
end
%     Debugging Section
%     disp(PSO.Velocity)

    fig = figure;
%     iterations = linspace(1,PSO.Gen,PSO.Gen);
%     plot(iterations,FitHistory);
    stairs(FitHistory)
    hold on;
    xlabel("Generation")
    ylabel("Fitness")
    title("PSO for Optimal Control")
    
%     disp(PSO.GbestHistory)
    
function dx = intgrl(t,x,u)
    dx=zeros(2,1);
    dx(1)=-(2+u).*(x(1)+0.25)+(x(2)+0.5).*exp(25*x(1)./(x(1)+2));
    dx(2)=0.5-x(2)-(x(2)+0.5).*exp(25*x(1)./(x(1)+2));
end

function [X]=NewParticle(R)
    X=rand(1);% uniform random value
    X(1,:)=(X(1,:)-R(1))*R(2);% align within ranges
end