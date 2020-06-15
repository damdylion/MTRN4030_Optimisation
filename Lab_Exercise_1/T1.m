clc; clear
disp("Question 4")
syms x k;
f = x.^2+k*cos(x)^2
df = diff(f,x)
dff = diff(df,x)
k_val = double(1:1:5)
for i=1;i< length(k_val)
    x_value = -2:0.2:2;
    currF = subs(f,k,i);
    currDF = subs(df,k,i)
    currDFF = subs(dff,k,i)
    y = subs(currF,x,x_value)
    y = double(y);
    y_diff = subs(currDF,x,x_value);
    y_diff = double(y_diff)
    y_inf = subs(currDFF,x,x_value);
    y_inf = double(y_inf)
    mini = find(y_inf<0)
    plot(x_value,y)
    disp("HERE")
    disp(i)
end