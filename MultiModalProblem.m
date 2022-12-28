clear all;
clc;
i = 1;
while (i<=10)
%    F(i) = -i^5-1000*i^4-i^3+i^2+i-3; 
%    F(i) = i^2 -0.3*cos(3*pi*i)+0.7;
    F(i) = sin(i) + sin((10/3)*i);
%     i = i+0.1;
    i = i+1;
end