% Task 4 Attempt 2
clc
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
NumChromo = 500;
pCross = 0.95;
pMut = 0.05;
bestDistance = 0;
history = [];

% First generation
Generation = zeros(NumChromo,T);
GenCost = [];
for i=1:NumChromo   
    num = randperm(T,H);
    Generation(i,num) = 1;
end

for z =1:Gen

    GenCost = [];
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
        bestLocal = min(GenCost);
    end
    if z == 1
        bestDistance = bestLocal;
        history = bestDistance;
        bestGene = find(bestLocal == GenCost);
%         updateBestOption(z,Gen,Generation(bestGene,:),hdLb,Dis,Town);
    end 
    if z > 1
        if bestLocal < bestDistance
            history = [history;bestLocal];
            bestDistance = bestLocal;
            bestGene = find(bestLocal == GenCost);
%             updateBestOption(z,Gen,Generation(bestGene,:),hdLb,Dis,Town);
        else
            history = [history;bestDistance];
                
        end
            
   end
        fitness = [];
%     Fitness Value for Selection
    for i=1:NumChromo
       fitness(i) = 1-(GenCost(i))/sum(GenCost);
       
    end
    fitness = fitness/sum(fitness);
    cf = cumsum(fitness);
    ix = linspace(0,1-0.5/NumChromo,NumChromo);
    Selection = [];
    for i = 1:NumChromo
        re(i)=min(find(cf>ix(i)));
        Selection(i,:) = Generation(re(i),:);
    end
    nextGen = [];
    while size(nextGen,1) ~= NumChromo
        ii = floor(NumChromo*rand)+1;
        jj = floor(NumChromo*rand)+1;
%         CrossOver
        if rand < pCross
            coRatio = randi([1,T-1],1);
            kid1 = [Selection(ii,1:coRatio),Selection(jj,coRatio+1:T)];
            kid2 = [Selection(jj,1:coRatio),Selection(ii,coRatio+1:T)];
        end
%         Mutation
        if rand < pMut
            mutRatio = randi([1,T],1);
            if size(kid1,1)==0
               break; 
            end
            if kid1(mutRatio) == 1
                kid1(mutRatio) = 0;
            else
               kid1(mutRatio) = 1; 
            end
            if kid2(mutRatio) == 1
                kid2(mutRatio) = 0;
            else
               kid2(mutRatio) = 1; 
            end
        end
        nextGen = [nextGen;kid1;kid2];
    end
%     Cancer Killer - Need to get rid of Chromosomes that have > H hubs
    for i=1:NumChromo
       cancerIndex = find(nextGen(i,:)==1);
       if size(cancerIndex,2) < H
           flop = randi([1,T],H-size(cancerIndex,2),1);
           while sum(flop == cancerIndex)~= 0
                flop = randi([1,T],H-size(cancerIndex,2),1);
           end
%               How many numbers need to be flopped to 1
           for a=1:size(flop,2)
              nextGen(i,flop(a)) = 1; 
           end
       end
       
       if size(cancerIndex,2) > H
           flop = randi([1,T],size(cancerIndex,2)-H,1);
%            disp("yeeT2")
           while sum(flop == cancerIndex)~= 0
%                disp("same2")
                flop = randi([1,T],size(cancerIndex,2)-H,1);
           end
%               How many numbers need to be flopped to 1
           for a=1:size(flop,2)
              nextGen(i,cancerIndex(a)) = 0; 
           end
           
       end
    end
    format = 'Generation: %d Cost: $%.2f';
    str =sprintf(format,GenCount,bestDistance);
    disp(str)
    Selection = [];
    re = [];
    GenCount = GenCount+1;
    Generation = nextGen;
end
updateBestOption(z,Gen,Generation(bestGene,:),hdLb,Dis,Town);
fig = figure ;
stairs(history)
hold on;
xlabel('Generations')
ylabel('Fitness')
title('Routing Problem Genetic Algorithm')
% Functions

function  updateBestOption(genCounter,GenNo,gene,blue,dis,town)
%     disp(sum(gene))
%     disp("Generation")
%     disp(genCounter)
    hubLocation = find(gene == 1);
    townLocation = find(gene == 0);
    hub2hubV = dis(hubLocation,hubLocation);
    blueOrder = [];
    prev = 0;
    for i=1:size(hub2hubV,1)*size(hub2hubV,2)
       if(hub2hubV(i) == 0)
           hub2hubV(i) = realmax;
       end
    end
    completed = false;
%         Get first point
    blueOrder = [town(1,hubLocation(1)),town(2,hubLocation(1))];
    hub2hubV(1,:) = realmax;
    i = 1;
    while completed ~= true
       small = find(min(hub2hubV(:,i))==hub2hubV(:,i));
       blueOrder = [blueOrder;[town(1,hubLocation(small)),town(2,hubLocation(small))]];
       hub2hubV(small,:) = realmax;
       i = small;
       if size(blueOrder,1) == size(hubLocation,2)
           completed = true;
       end
        
    end
    blueOrder = [blueOrder;blueOrder(1,:)];
    set(blue,'xdata',blueOrder(:,1),'ydata',blueOrder(:,2),'LineWidth',3);

    hub2TownV = dis(townLocation,hubLocation);
    
    for i =1:size(hub2TownV,1)
        small = find(min(hub2TownV(i,:))==hub2TownV(i,:));
        currHub = [town(1,hubLocation(small)),town(2,hubLocation(small))];
        currTown = [town(1,townLocation(i)),town(2,townLocation(i))];
        temp = [currHub;currTown];
%         set(red,'xdata',temp(:,1),'ydata',temp(:,2));
        ax(i) = plot(temp(:,1),temp(:,2),'r');
        hold on;
    end
    drawnow;
    if genCounter ~= GenNo
        delete(ax);
    end
    
end

