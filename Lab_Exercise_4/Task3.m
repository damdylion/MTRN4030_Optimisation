clc; clear all; close all; dbstop if error;
R=100; T=50;% range of aera, number of towns
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
[mi,ix]=min(S); Start.Town=Town(:,ix); Start.ix=ix;
plot(Start.Town(1),Start.Town(2),'go','markerfacecolor','g');
[mi,ix]=max(S); Target.Town=Town(:,ix); Target.ix=ix;
plot(Target.Town(1),Target.Town(2),'ro','markerfacecolor','r');
% ACO parameters
ACO.G=100; ACO.N=200;% number of generation, ants 
% pheromone, inv distance, evaporation
ACO.a=0.995; ACO.b=(1-ACO.a); ACO.c=0.95;
ACO.Travel=realmax; ACO.Travel_=[];
ACO.Pher=ones(T,T)/T^2;% initial pheromone
Traverse = 1;
% ACO main loop
for g=1:ACO.G,% each generation
  TravelAll=0; Visit=zeros(T,T);% travel per generation
  for n=1:ACO.N,% each ant
    Travel=0; cnt=2; Pt=[];% random start
    Z=rand(2,1)*R; Zdis=sqrt(sum((Town-repmat(Z,[1,T])).^2,1));
    [mi,ix]=sort(Zdis,'ascend'); Pt=ix(1:2); 
    Travel=Dis(Pt(end-1),Pt(end));
    while Pt(end)~=Start.ix & Pt(end)~=Target.ix,% path random start
      cnt=cnt+1; if cnt>T,% loop escape
        Travel=realmax; break;
      end;
      prob=(ACO.Pher(Pt(end),:).^ACO.a).*(iDis(Pt(end),:).^ACO.b); 
      prob(Pt)=0; [mx,ix]=max(prob);% movement probability
      Pt(end+1)=ix(1);% go along max probability
      Travel(end+1)=Dis(Pt(end-1),Pt(end));% distance travelled
    end;
    if Travel<realmax,% valid travel
      set(hdLr,'xdata',Town(1,Pt),'ydata',Town(2,Pt));
      title(sprintf('G=%d N=%d',g,n)); drawnow;
      for p=1:length(Pt)-1,% lay pheromone
        Visit(Pt(p),Pt(p+1))=Visit(Pt(p),Pt(p+1))+size(Pt,2);
      end;
      Visit=Visit/max(Travel);% normalize
    end;
  end;
  ACO.Pher=size(Pt,2).*(ACO.Pher+Visit);% increase pheromone
  ACO.Pher=(ACO.Pher/sum(ACO.Pher(:)));%normalize pheromone
  ACO.Pher=ACO.Pher.*ACO.c;% evaporate pheromone
  set(hdLr,'xdata',[],'ydata',[]); Pt=Start.ix;% show path found
  while Pt~=Target.ix,% better path for all ants
    prob=(ACO.Pher(Pt(end),:).^ACO.a).*(iDis(Pt(end),:).^ACO.b);
    prob(Pt)=0; [mx,ix]=max(prob); Pt(end+1)=ix;
    TravelAll=TravelAll+Dis(Pt(end-1),Pt(end));
    Traverse = Traverse +1;
  end;
  if TravelAll<ACO.Travel,% better path across generations
    ACO.Travel=TravelAll;
    set(hdLb,'xdata',Town(1,Pt),'ydata',Town(2,Pt));
  end;
  ACO.Travel_=[ACO.Travel_ ACO.Travel];% path record
  fprintf('Generation=%03d Travel=%5.3f pt= %d \n',g,ACO.Travel,size(Pt,2));
end;
figure; plot(ACO.Travel_); grid on;
xlabel('Iterations'); ylabel('Total Travel');