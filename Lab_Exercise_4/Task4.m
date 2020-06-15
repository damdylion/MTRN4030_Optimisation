clear 
close all
R=100; T=50;H=4;% range of aera, number of towns
Town=rand(2,T)*R;% locations of towns
fig=figure; plot(Town(1,:),Town(2,:),'b.');
hold on; grid on; axis([0 R 0 R]); drawnow;
for t=1:T,% label each town
  text(Town(1,t),Town(2,t),sprintf(' %d',t));
end; 
drawnow; hdLr=plot(0,0,'r-'); hdLb=plot(0,0,'b-'); % path handle
% distances between towns
for j=1:T,% each departing town
  for k=1:T,% each arriving town
    dx=Town(1,j)-Town(1,k);
    dy=Town(2,j)-Town(2,k);
    if j~=k,
      Dis(j,k)=sqrt(dx^2+dy^2);% distance between towns
      iDis(j,k)=1/(Dis(j,k)+eps);% inverse distance
    else
      iDis(j,k)=0;
    end;
  end;
end; 
iDis=iDis/sum(iDis(:));% normalize
% find starting point distance, target point distance
for t=1:T,
  S(t)=Town(1,t)^2+Town(2,t)^2;
end;
% [mi,ix]=min(S); Start.Town=Town(:,ix); Start.ix=ix;
% plot(Start.Town(1),Start.Town(2),'go','markerfacecolor','g');
% [mi,ix]=max(S); Target.Town=Town(:,ix); Target.ix=ix;
% plot(Target.Town(1),Target.Town(2),'ro','markerfacecolor','r');

Gen = 100;
GenCount = 1;
NumChromo = 30;
pCross = 0.95;
pMut = 0.05;

% First generation
Generation = zeros(NumChromo,T);
GenCost = [];
for i=1:NumChromo   
    num = randperm(T,H);
    Generation(i,num) = 1;
end

for z =1:Gen

    for i =1:NumChromo    
        index1 = find(Generation(i,:) == 1);
        index0 = find(Generation(i,:)==0);
%       newDis contains the distances to each town from the hubs.
        hub2Town = Dis(index0,index1);
        hub2TownDis = 0;
        for a =1:size(hub2Town,1)
            hub2TownDis = hub2TownDis+min(hub2Town(a,:))*2;
        end
        hub2hub = Dis(index1,index1);
        hub2hubDis = sum(unique(hub2hub));
        GenCost = [GenCost;hub2hubDis+hub2TownDis];
    end
    fitness = [];
%     Fitness Value for Selection
    fitness(z,:) = -GenCost;
    mi = min(fitness(z,:));
    mx = max(fitness(z,:));
    fitness(z,:) = (fitness(z,:)-mi)/(mx-mi);
    fitness(z,:) = fitness(z,:)/sum(fitness);
    cf = cumsum(fitness);
    ix = linspace(0,1-0.5/NumChromo,NumChromo);
    Selection = [];
    for i = 1:NumChromo
        re(i)=min(find(cf>=ix(i)));
        Selection(i,:) = Generation(re(i),:)
    end
    for i=1:NumChromo
        ii = floor(NumChromo*rand)+1;
        jj = floor(NumChromo*rand)+1;
        if rand < pCross
            
        end
        
       i 
    end
        
        
        
end
%     for n = 1:NumChromo
%        if(cf(n) >= ix(n))
%           newGen = [newGen;Gen(n,:)]; 
%        end
%         
%     end
% %   Cross Over
%     kid = [];
%     for n=1:2:NumChromo
%         if rand < pCross 
% %             Where Crossover is expected to occur;
%             coRatio = randi([1,T-1],1); 
%             temp = [newGen(n,1:coRatio),newGen(n+1,coRatio+1:T)];
%             kid = [temp];
%             temp = [newGen(n+1,1:coRatio),newGen(n,coRatio+1:T)];
%             kid = [kid;temp];
%             newGen = [newGen;kid];
%             if(n == size(newGen,1))
%                n = 1; 
%             end
%         end
%     end
% %   Mutation
%     for n=1:NumChromo
%         if rand < pMut
%            mutChro = randi([1,T],1);
%            if(newGen(n,mutChro) == 1)
%                newGen(n,mutChro) = 0;
%            else
%                newGen(n,mutChro)= 1;
%            end
%         end       
%     end
% %   Fix Cancer - Chromosomes that have more hubs than allowed.
%     for n = 1:NumChromo
%        cancerPoint = find(newGen(n,:)==1);
%        numOfHubs = size(cancerPoint,2);
%        numOfCancer = numOfHubs-H;
%           for m = i:numOfCancer
%                temp = randi([1,numOfCancer],1);
%                newGen(n,cancerPoint(temp)) = 0;
%           end
%         
%     end
%    Generation = newGen;
%    GenCount = GenCount+1
% end
% Connect the hubs together
% Generate cost of min distance to each hub
% Compute cost

%% BUGS

% Cross over is fucked
