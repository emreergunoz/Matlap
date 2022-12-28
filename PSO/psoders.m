
clc
clear
%% PSO Deðerleri
N=100;  %surudeki parcacik sayisi
c1=2;c2=2;
inertiaMax=0.9; %ilk iterasyondaki inertia deðeri
inertiaMin=0.4; %son iterasyondaki inertia deðeri

%% Çalýþma Kriterleri
maxIterasyon=100;
ust=10; %arama uzayýnýn üst sýnýrýdýr
alt=-10; %arama uzayýnýn alt sýnýrýdýr

D=2;

%% 
%Parçacýkalrýn baslangic konumlarini rasgele uretme

partical = rand(N,D)*(ust-alt)+alt %rand 0-1 arasýnda rasgele sayý üretir bunlarý ust ve alt arasýnda yapar
                   %rand(N,D) ise 0-1 arasýnda N satýr D sütunluk rasgele
                   %matris üretir N burda parçacýk sayýsýnýn tamamýný, D
                   %ise boyut
                   
v = zeros(N,D); % n satýr d sutunluk biramtries 0 yazar aynýsýnýn ones (1) i var

plot(partical(:,1),partical(:,2),'ro') %r kýrmýzý, o yuvarlak olsundemek


for i=1:N % i deðerini 1 den baþla N e kadar git , i=1:2 :N  i baþla n e kadar 2 þer artýararak git
ObjVal(i)=(partical(i,1)+7.91)^2+(partical(i,2)-3.24)^2+5; %amaç fonksiyonu(Objectiv Value) oluþturuyoruz bu deðerleri hoca belirledi
end
%strcat stringleri conrataing eder, stringeri birleþtirir


%local bestleri atama
lbest_pos=partical;%her parçacýðýn en iyi deðeri baþlangýç deðeri atadý 
lbest_obj=ObjVal; %amaç fonksiyonu deðerlerinin bestinide bura atadýk


%global best deðeri atama locak bestleirn minumum deðeridir
[gbest_obj,indis]=min(ObjVal); % burda minumum deðeri döndürü [a,b]=min(ObjVal) dersek deðere sahip indisi b olarka döndürü
% burda [a,b ]yerine[gbest_obj,indis] dedik

gbest_pos=partical(indis,:); %indisdeki satýrýn tamamýný gbestpos yaptýk


%% iterasyonlar baþliyor

iter=1;

while iter<=maxIterasyon
    inertia = inertiaMax-((inertiaMax-inertiaMin)/maxIterasyon)*iter; %baþta 0,9 ile baþlar , 0,4 e çekilir
    
    for i=1:N
        v(i,:)=inertia*v(i,:)+c1*rand(1,D).*(lbest_pos(i,:)-partical(i,:))+c2*rand(1,D).*(gbest_pos-partical(i,:)); 
                               %ilk iterasyonda 0 çýkmaz%ilk iterde0 çýkar  .* ile matrisler çarpýlýr
                           
      v(i,:)= min(v(i,:),ust); % arama uzayýndan çýkmamamk için v üst geçerse onu direk ust deðeri olarak alýcak
      v(i,:)= max(v(i,:),alt); % arama uzayýndan çýkmamamk için v alt geçerse onu direk alt deðeri olarak alýcak
      
      partical(i,:) = partical(i,:) + v(i,:);

      partical(i,:)=min(partical(i,:),ust) ;
      partical(i,:)=max(partical(i,:),alt);
      
      ObjVal(i)=(partical(i,1)+7.91)^2+(partical(i,2)-3.24)^2+5; % yeni deðerlerimiz ile amaç fonksiyonunu tekrar hesapladýk
      
      %yeni amaç ile l best deðiþcekmi kontrol edip iþlem yapýyoruz
      if ObjVal(i)<lbest_obj(i) %eðer hafzadakinden daha küçük bir amaç deðeri bulursak yeni deðer o oluyor
          lbest_pos(i,:)=partical (i,:);
          lbest_obj(i) = ObjVal(i);
      end
      
    end %N döngüsü sonu
    
    %Global best deðerini güncelle
    
    [obj,indis]=min(ObjVal);
    if gbest_obj>obj
        gbest_pos=partical(indis,:)
        gbest_obj=obj;
    end
    
    display(['iterasyon:' num2str(iter),'Obj:' num2str(gbest_obj)]); %print gibi bir þey
    plot(partical(:,1),partical(:,2),'ro') %r kýrmýzý, o yuvarlak olsundemek 
    xlabel('1.Karar Deðiþkeni x');ylabel('2.Karar Deðiþkeni x');%tabloya x-y isimleri atadýk
    title(strcat('Iterasyon',int2str(iter),'  GlobalMin:',num2str(gbest_obj)));% çýkan sonucun tablosunun üstünde gözükcek
    pause(0.5);%ekranda göstermek için kodu yavaþlattýk
    iter=iter+1;
end

%%



                   

