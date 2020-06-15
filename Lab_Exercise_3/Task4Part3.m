% Task 4 Part C

syms a b c d

q = 5;
A = [0,1;0,0];
B = [0;1];
C = [];
D = [];
SYS = ss(A,B,C,D);
Qx = [q^2,0;0,0];
Qu = 1;
P = [a,b;c,d];
sol = solve(P*A-P*B*inv(Qu)*B'*P+Qx+A'*P==0) 
solP = [eval(sol.a),eval(sol.b),eval(sol.c),eval(sol.d)]

for i=1:size(solP,1)
   
    if(isreal(solP(i,1))~= 1||isreal(solP(i,2))~= 1||isreal(solP(i,3))~= 1||isreal(solP(i,4))~= 1)
    
        solP(i,:) = NaN;
        
    end
    
end
% For q = 1;
P = [solP(3,1),solP(3,2);solP(3,3),solP(3,4)]
% For q = 2;
% P = [solP(2,1),solP(2,2);solP(2,3),solP(2,4)]

% P = -Qx*inv(A+A'-B*inv(Qu)*B')
K1 = inv(Qu)*B'*P



[K,S,E] = lqr(SYS,Qx,Qu);