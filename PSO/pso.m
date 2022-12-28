
clear
clc
iter = 40;
inertia = 1.0;
c = 2.0;
suruler = 400;

suru=zeros(400,7);
step = 1;

for i = 1 : 400
suru(step, 1:7) = i;
step = step + 1;
end

suru(:, 7) = 1000;       
suru(:, 5) = 0;         
suru(:, 6) = 0;          

for iter = 1 : iter
    
    for i = 1 : suruler
        suru(i, 1) = suru(i, 1) + suru(i, 5)/1.2  ;  
        suru(i, 2) = suru(i, 2) + suru(i, 6)/1.2 ;   
        u = suru(i, 1);
        v = suru(i, 2);
        
        value = (u - 20)^2 + (v - 10)^2;          
        
        if value < suru(i, 7)           
            suru(i, 3) = suru(i, 1);   
            suru(i, 4) = suru(i, 2);    
            suru(i, 7) = value;         
        end
    end
    
    [temp, gbest] = min(suru(:, 7));        
    
    
    for i = 1 : suruler
        suru(i, 5) = rand*inertia*suru(i, 5) + c*rand*(suru(i, 3)...
            - suru(i, 1)) + c*rand*(suru(gbest, 3) - suru(i, 1));  
        suru(i, 6) = rand*inertia*suru(i, 6) + c*rand*(suru(i, 4)...
            - suru(i, 2)) + c*rand*(suru(gbest, 4) - suru(i, 2));   
    end
    

    clf    
    plot(suru(:, 1), suru(:, 2), 'ro')   
    axis([-1000 400 -1000 400])
pause(.1)
end