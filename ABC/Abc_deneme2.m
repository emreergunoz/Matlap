clc;
clear;
close all;
CostFunction=@(x) obj(x);
nVar=2;
VarSize=[1 nVar];
VarMin=-3;
VarMax= 3;
MaxIt=100;
nPop=100;
nOnlooker=nPop;
L=round (0.6*nVar*nPop);
a=1;

for it=1:MaxIt
    for i=1:nPop
        K=[1:1-1 i+1:nPop];
        k=K(randi([1 numel(K)]));
        phi=a*unifrnd (-1, +1, VarSize);
        newbee.Position=pop(i).Position+phi.*(pop(i).Position-pop(k).Position);
        newbee.Cost=CostFunction (newbee. Position);
        if newbee.Cost<=pop(i).Cost
            pop(i)=newbee;
        else
            C(i)=C(i)+1;
        end
    end
    
    F=zeros (nPop,1);
    MeanCost = mean ([Ipop.Cost]);
    for i=1:nPop
        F(1) = exp(-pop (1). Cost/MeanCost);
        
    end
    PF=sum (F);
    
    for m=1:nonlooker
        i=RouletteWheelSelection (P);
        K=[1:1-1 i+1:n Pop];
        k=K(randi ([1 numel (K) 1]));
        phi=a*unifrnd (-1, +1, VarSize);
        newbee.Position= pop(i).Position+phi.*(pop(i).Position-pop (k). Position);
        newbee.Cost=CostFunction (newbee. Position);
        if newbee.Cost<=pop (1).Cost
            pop (i)=newbee;
        else
            C(i)=C(1)+1;
        end
    end
    for i=1:nPop
        if C(i) >=L 
            pop(i).Position=unifrnd (Varlin, VarMax, VarSize);
            pop(i).Cost=CostFunction (pop (1).Position);
            C(i)=0;
        end
    end
    for i=1:nPop
        if pop(i).Cost<=Bests01.cost
            BestSol=pop (i);
        end
    end
    BestCost(it)=BestSol.Cost;
    
    disp(['Iteration' num2str(it,20) ': Best Cost = ' num2str(BestCost(it),20)]);
end
figure;
semilogy (BestCost, 'LineWidth', 2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;

empty_bee. Position=[];
empty_bee.Cost=[];

pop=repmat (empty_bee, nPop, 1);

BestSol. Cost=inf;

for i=1:nPop
    pop (i). Position=unifrnd (VarMin, VarMax, VarSize);
    pop (1).Cost=CostFunction (pop (1).Position);
    if pop (1).Cost<=BestSol. Cost
        BestSol=pop (i);
    end
end
C=zeros (npop, 1);

BestCost=zeros (MaxIt,1);