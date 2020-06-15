clear all;
clc;
% number of generation
MaxGene = 5000;
% population number
N = 800;
% initial chromosome
Chromo = [0.2+4.8*rand(1,N); 0.2+4.8*rand(1,N); 0.2+4.8*rand(1,N)];
Threshold = 500;
% Objective function
Pc = 0.95;
Pm = 0.05;
It = [];
Obj = [];
for g = 1:MaxGene
    for n = 1:N
        f(g,n) = 20*Chromo(1,n).*Chromo(2,n)+10*Chromo(2,n).*Chromo(3,n)+20*Chromo(1,n).*Chromo(3,n)+100./(Chromo(1,n).*Chromo(2,n).*Chromo(3,n));
    end
% First generation
% fn the index of the value
[fmin fn] = min(f(g,:));
if fmin < Threshold
    Threshold = fmin;
    fChromo = Chromo(:,fn);

end
Iteration = g
It = [It g];
fChromo
Value = 20*fChromo(1).*fChromo(2)+10*fChromo(2).*fChromo(3)+20*fChromo(1).*fChromo(3)+100./(fChromo(1).*fChromo(2).*fChromo(3))
Obj = [Obj, Value];
f(g,:) = -f(g,:);
fmin = min(f(g,:));
fmax = max(f(g,:));
f(g,:) = (f(g,:)-fmin)/(fmax-fmin);
f(g,:) = f(g,:)/sum(f(g,:));
cumuf = cumsum(f(g,:));
Fn = linspace(0,1-0.5/N,N);
for n= 1:N
    z(n) = min(find(cumuf >= Fn(n)));
    Chromon(:,n) = Chromo(:,z(n));
end

for n = 1:2:N
    if rand < Pc
        r1 = rand;
        r2 = rand;
        Chromo(:,n)=r1*Chromon(:,n)+(1-r1)*Chromon(:,n+1);
        Chromo(:,n+1)=r2*Chromon(:,n+1)+(1-r2)*Chromon(:,n);
    else
        Chromo(:,n)=Chromon(:,n);
        Chromo(:,n+1)=Chromon(:,n+1);
    end
end

for n = 1:N
    if rand < Pm
        Chromo(:,n) = [0.2+4.8*rand(1); 0.2+4.8*rand(1); 0.2+4.8*rand(1)];
    end
end
end
stairs(It,Obj)