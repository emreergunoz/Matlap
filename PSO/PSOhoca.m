% PSO KODU

%% PSO'ya ait degerler
N = 100; % surudeki parcacik sayisi
c1 = 2; c2 = 2;
inertiaMax = 0.9; % ilk iterasyondaki inertia degeri
inertiaMin = 0.4; % son iterasyondaki inertia degeri
%%
%% Calisma Kriterleri
maxIterasyon = 100;
ust = 10; % Arama uzayinin ust siniridir.
alt = -10; % Arama uzayinin alt siniridir.
D = 2; % problem boyutu
%%

% Parcaciklarin baslangic konumlarini rastgele uret
particle = rand(N,2)*(ust-alt)+alt;
v = zeros(N,D);

plot(particle(:,1), particle(:,2),'ro'); % parcaciklarin konumlarini goster

for i=1:N
% amac fonksiyonunu (Objective Value (ObjVal) hesapla)
ObjVal(i) = (particle(i,1) +7.91)^2 + (particle(i,2) - 3.24)^2 + 5; 
end

%Lokal bestleri atama
lbest_pos = particle; % local best pozisyonu
lbest_obj = ObjVal;

% Global Best degeri atama
[gbest_obj, indis] = min(ObjVal);
gbest_pos = particle(indis,:);

%% Iterasyonlar Basliyor

iter = 1;

while iter <= maxIterasyon
    inertia = inertiaMax - ((inertiaMax-inertiaMin)/maxIterasyon)*iter;
    
    for i=1:N
        v(i,:) = inertia*v(i,:) + c1*rand(1,D).*(lbest_pos(i,:)-particle(i,:)) + ...
                                  c2*rand(1,D).*(gbest_pos - particle(i,:));
                              
        v(i,:)= min(v(i,:), ust); % ust sinir kontrolu yapiliyor
        v(i,:)= max(v(i,:), alt); % alt sinir kontrolu yapiliyor
        
        particle(i,:) = particle(i,:) + v(i,:);
        
        particle(i,:) = min(particle(i,:), ust);% ust sinir kontrolu yapiliyor
        particle(i,:) = max(particle(i,:), alt);% alt sinir kontrolu yapiliyor
        
        ObjVal(i) = (particle(i,1) +7.91)^2 + (particle(i,2) - 3.24)^2 + 5;
        
        % LBest Guncelleme
        if ObjVal(i) < lbest_obj(i)
            lbest_pos(i,:) = particle(i,:);
            lbest_obj(i) = ObjVal(i);
        end    
        
    end % N dongusu
    
    % GBest degeri guncelleme
    [obj, indis] = min(ObjVal);
    if gbest_obj > obj
        gbest_pos = particle(indis,:);
        gbest_obj = obj;
    end
    
    display(['iterasyon:' num2str(iter), ' Obj:' num2str(gbest_obj)]);    
    
    plot(particle(:,1), particle(:,2),'ro'); % parcaciklarin konumlarini goster
    xlabel('1.karar degiskeni x'); ylabel('2.karar degiskeni y');
    title(strcat('Iterasyon:', int2str(iter), '        GlobalMin: ', num2str(gbest_obj)));
    pause(0.5);
    iter = iter +1;
end









