
clc
clear
%% PSO De�erleri
N=100;  %surudeki parcacik sayisi
c1=2;c2=2;
inertiaMax=0.9; %ilk iterasyondaki inertia de�eri
inertiaMin=0.4; %son iterasyondaki inertia de�eri

%% �al��ma Kriterleri
maxIterasyon=100;
ust=10; %arama uzay�n�n �st s�n�r�d�r
alt=-10; %arama uzay�n�n alt s�n�r�d�r

D=2;

%% 
%Par�ac�kalr�n baslangic konumlarini rasgele uretme

partical = rand(N,D)*(ust-alt)+alt %rand 0-1 aras�nda rasgele say� �retir bunlar� ust ve alt aras�nda yapar
                   %rand(N,D) ise 0-1 aras�nda N sat�r D s�tunluk rasgele
                   %matris �retir N burda par�ac�k say�s�n�n tamam�n�, D
                   %ise boyut
                   
v = zeros(N,D); % n sat�r d sutunluk biramtries 0 yazar ayn�s�n�n ones (1) i var

plot(partical(:,1),partical(:,2),'ro') %r k�rm�z�, o yuvarlak olsundemek


for i=1:N % i de�erini 1 den ba�la N e kadar git , i=1:2 :N  i ba�la n e kadar 2 �er art�ararak git
ObjVal(i)=(partical(i,1)+7.91)^2+(partical(i,2)-3.24)^2+5; %ama� fonksiyonu(Objectiv Value) olu�turuyoruz bu de�erleri hoca belirledi
end
%strcat stringleri conrataing eder, stringeri birle�tirir


%local bestleri atama
lbest_pos=partical;%her par�ac���n en iyi de�eri ba�lang�� de�eri atad� 
lbest_obj=ObjVal; %ama� fonksiyonu de�erlerinin bestinide bura atad�k


%global best de�eri atama locak bestleirn minumum de�eridir
[gbest_obj,indis]=min(ObjVal); % burda minumum de�eri d�nd�r� [a,b]=min(ObjVal) dersek de�ere sahip indisi b olarka d�nd�r�
% burda [a,b ]yerine[gbest_obj,indis] dedik

gbest_pos=partical(indis,:); %indisdeki sat�r�n tamam�n� gbestpos yapt�k


%% iterasyonlar ba�liyor

iter=1;

while iter<=maxIterasyon
    inertia = inertiaMax-((inertiaMax-inertiaMin)/maxIterasyon)*iter; %ba�ta 0,9 ile ba�lar , 0,4 e �ekilir
    
    for i=1:N
        v(i,:)=inertia*v(i,:)+c1*rand(1,D).*(lbest_pos(i,:)-partical(i,:))+c2*rand(1,D).*(gbest_pos-partical(i,:)); 
                               %ilk iterasyonda 0 ��kmaz%ilk iterde0 ��kar  .* ile matrisler �arp�l�r
                           
      v(i,:)= min(v(i,:),ust); % arama uzay�ndan ��kmamamk i�in v �st ge�erse onu direk ust de�eri olarak al�cak
      v(i,:)= max(v(i,:),alt); % arama uzay�ndan ��kmamamk i�in v alt ge�erse onu direk alt de�eri olarak al�cak
      
      partical(i,:) = partical(i,:) + v(i,:);

      partical(i,:)=min(partical(i,:),ust) ;
      partical(i,:)=max(partical(i,:),alt);
      
      ObjVal(i)=(partical(i,1)+7.91)^2+(partical(i,2)-3.24)^2+5; % yeni de�erlerimiz ile ama� fonksiyonunu tekrar hesaplad�k
      
      %yeni ama� ile l best de�i�cekmi kontrol edip i�lem yap�yoruz
      if ObjVal(i)<lbest_obj(i) %e�er hafzadakinden daha k���k bir ama� de�eri bulursak yeni de�er o oluyor
          lbest_pos(i,:)=partical (i,:);
          lbest_obj(i) = ObjVal(i);
      end
      
    end %N d�ng�s� sonu
    
    %Global best de�erini g�ncelle
    
    [obj,indis]=min(ObjVal);
    if gbest_obj>obj
        gbest_pos=partical(indis,:)
        gbest_obj=obj;
    end
    
    display(['iterasyon:' num2str(iter),'Obj:' num2str(gbest_obj)]); %print gibi bir �ey
    plot(partical(:,1),partical(:,2),'ro') %r k�rm�z�, o yuvarlak olsundemek 
    xlabel('1.Karar De�i�keni x');ylabel('2.Karar De�i�keni x');%tabloya x-y isimleri atad�k
    title(strcat('Iterasyon',int2str(iter),'  GlobalMin:',num2str(gbest_obj)));% ��kan sonucun tablosunun �st�nde g�z�kcek
    pause(0.5);%ekranda g�stermek i�in kodu yava�latt�k
    iter=iter+1;
end

%%



                   

