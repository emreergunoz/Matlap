clear
clc

%Emre Ergün Öz-19410051002-
%Makine Öðrenmesi k means ödevi
%Kodun sonunda sorulan soru cevaplanmadan kodun çalýþmasý durmaz ancak figure basýlýr.
%Yeni baþladýðým için her þeyi tanýmlayarak ilerledim.
%Veriyi temsil eden kümeler ve hata oranlarý hem sonda consolda gözükmekte
%hemde workspace içindeki matrislerde gözükmektedir. Kodun son sorusuna
%cevap verilmezse waorkspace deki matrisler gözükmemektedir.

%xlss yerine xlsx e dönüþtürdüðüm data seti kullandým

%Ýyi günler

[num txt raw]=xlsread('Iris_dataset.xlsx');
tacu=num(:,3);
tacg=num(:,4);
canaku=num(:,1); 
canakg=num(:,2);
merkez1o=[min(tacu),min(tacg),min(canaku),min(canakg)];
merkez2o=[mean(tacu),mean(tacg),mean(canaku),mean(canakg)];
merkez3o=[max(tacu),max(tacg),max(canaku),max(canakg)];
n=0;
den=0.01;
while n==0
    for i=1:size(tacu,1)
        uzaklik(1,i)=sqrt((tacu(i)-merkez1o(1))^2+(tacg(i)-merkez1o(2))^2+((canaku(i)-merkez1o(3))^2+(canakg(i)-merkez1o(4))^2)*den);
        uzaklik(2,i)=sqrt((tacu(i)-merkez2o(1))^2+(tacg(i)-merkez2o(2))^2+((canaku(i)-merkez2o(3))^2+(canakg(i)-merkez2o(4))^2)*den);
        uzaklik(3,i)=sqrt((tacu(i)-merkez3o(1))^2+(tacg(i)-merkez3o(2))^2+((canaku(i)-merkez3o(3))^2+(canakg(i)-merkez3o(4))^2)*den);
    end
    for i=1:size(uzaklik,2)
        if uzaklik(1,i)<uzaklik(2,i)
            if uzaklik(1,i)<uzaklik(3,i)
                uzaklik_kont(1,i)=1;uzaklik_kont(2,i)=0;uzaklik_kont(3,i)=0;
            else
                uzaklik_kont(1,i)=0;uzaklik_kont(2,i)=0;uzaklik_kont(3,i)=1;
            end
        else
            if uzaklik(2,i)<uzaklik(3,i)
                uzaklik_kont(1,i)=0;uzaklik_kont(2,i)=1;uzaklik_kont(3,i)=0;
            else
                uzaklik_kont(1,i)=0;uzaklik_kont(2,i)=0;uzaklik_kont(3,i)=1;
            end
        end
    end
    [a b]=find(uzaklik_kont(1,:)==1);
    if size(a,2)~=0
        tacuort=0;
        tacgort=0;
        canakuort=0;
        canakgort=0;
        for i=1:size(b,2)
            tacuort=tacuort+tacu(b(i));
            tacgort=tacgort+tacg(b(i));
            canakuort=canakuort+canaku(b(i));
            canakgort=canakgort+canakg(b(i));
        end
        merkez1n=[tacuort/size(b,2) tacgort/size(b,2) canakuort/size(b,2) canakgort/size(b,2)];
    end
    [a b]=find(uzaklik_kont(2,:)==1);
    if size(a,2)~=0
        tacuort=0;
        tacgort=0;
        canakuort=0;
        canakgort=0;
        for i=1:size(b,2)
            tacuort=tacuort+tacu(b(i));
            tacgort=tacgort+tacg(b(i));
            canakuort=canakuort+canaku(b(i));
            canakgort=canakgort+canakg(b(i));
        end
        merkez2n=[tacuort/size(b,2) tacgort/size(b,2) canakuort/size(b,2) canakgort/size(b,2)];
    end
    [a b]=find(uzaklik_kont(3,:)==1);
    if size(a,2)~=0
        tacuort=0;
        tacgort=0;
        canakuort=0;
        canakgort=0;
        for i=1:size(b,2)
            tacuort=tacuort+tacu(b(i));
            tacgort=tacgort+tacg(b(i));
            canakuort=canakuort+canaku(b(i));
            canakgort=canakgort+canakg(b(i));
        end
        merkez3n=[tacuort/size(b,2) tacgort/size(b,2) canakuort/size(b,2) canakgort/size(b,2)];
    end
    if merkez1n(1)==merkez1o(1) && merkez1n(2)==merkez1o(2) && merkez1n(3)==merkez1o(3) && merkez1n(4)==merkez1o(4)&&...
            merkez2n(1)==merkez2o(1) && merkez2n(2)==merkez2o(2) && merkez2n(3)==merkez2o(3) && merkez2n(4)==merkez2o(4)&&...
            merkez3n(1)==merkez3o(1) && merkez3n(2)==merkez3o(2) && merkez3n(3)==merkez3o(3) && merkez3n(4)==merkez3o(4)
        n=1;
    end
    merkez1o=merkez1n;
    merkez2o=merkez2n;
    merkez3o=merkez3n;
end
for i=1:size(tacu,1)
    kont=find(uzaklik_kont(:,i)==1);
    if kont==1
        s1=scatter(tacu(i),tacg(i),'b','filled');
        grid on
        hold on
    elseif kont==2
        s2=scatter(tacu(i),tacg(i),'r','filled');
        grid on
        hold on
    else
        s3=scatter(tacu(i),tacg(i),'g','filled');
        grid on
        hold on
    end
end
m1=scatter(merkez1n(1,1),merkez1n(1,2),'k','filled');
m2=scatter(merkez2n(1,1),merkez2n(1,2),'k','filled');
m3=scatter(merkez3n(1,1),merkez3n(1,2),'k','filled');
legend([s1 s2 s3 m1 m2 m3],'grup 1','grup 2','grup 3','merkez 1','merkez 2','merkez 3')
dogru1=0; hata1=0;
dogru2=0; hata2=0;
dogru3=0; hata3=0;
cicek_turleri={'Iris-setosa','Iris-versicolor','Iris-virginica'};
hatali_cicekler=0;
for i=1:size(num,1)
    test=find(uzaklik_kont(:,i)==1);
    if test==1
        if strcmp(raw(i+1,5),cicek_turleri(1))
            dogru1=dogru1+1;
        else
            if test==2
                hata2=hata2+1;
            else
                hata3=hata3+1;
            end
            if hatali_cicekler==0
                hatali_cicekler(size(hatali_cicekler,1),1)=i;
                hatali_cicekler(size(hatali_cicekler,1),2:size(num,2)+1)=num(i,:);
            else
                hatali_cicekler(size(hatali_cicekler,1)+1,1)=i;
                hatali_cicekler(size(hatali_cicekler,1),2:size(num,2)+1)=num(i,:);
            end
        end
    elseif test==2
        if strcmp(raw(i+1,5),cicek_turleri(2))
            dogru2=dogru2+1;
        else
            if test==1
                hata1=hata1+1;
            else
                hata3=hata3+1;
            end
            if hatali_cicekler==0
                hatali_cicekler(size(hatali_cicekler,1),1)=i;
                hatali_cicekler(size(hatali_cicekler,1),2:size(num,2)+1)=num(i,:);
            else
                hatali_cicekler(size(hatali_cicekler,1)+1,1)=i;
                hatali_cicekler(size(hatali_cicekler,1),2:size(num,2)+1)=num(i,:);
            end
        end
    else
        if strcmp(raw(i+1,5),cicek_turleri(3))
            dogru3=dogru3+1;
        else
            if test==1
                hata1=hata1+1;
            else
                hata2=hata2+1;
            end
            if hatali_cicekler==0
                hatali_cicekler(size(hatali_cicekler,1),1)=i;
                hatali_cicekler(size(hatali_cicekler,1),2:size(num,2)+1)=num(i,:);
            else
                hatali_cicekler(size(hatali_cicekler,1)+1,1)=i;
                hatali_cicekler(size(hatali_cicekler,1),2:size(num,2)+1)=num(i,:);
            end
        end
    end
end
fprintf('%s türüne ait hata sayýsý %g hata oraný yüzde: %g\n',cicek_turleri{1,1},hata1,hata1/(dogru1+hata1)*100)
fprintf('%s türüne ait hata sayýsý %g hata oraný yüzde: %g\n',cicek_turleri{1,2},hata2,hata2/(dogru2+hata2)*100)
fprintf('%s türüne ait hata sayýsý %g hata oraný yüzde: %g\n',cicek_turleri{1,3},hata3,hata3/(dogru3+hata3)*100)
fprintf('algoritmanýn genel hata oraný yüzde: %g\n',(hata1+hata2+hata3)/size(num,1)*100);
istek=input('1) Hatalý çiçeklerin bilgilerini göster.\n2) çýkýþ,\n');
if istek==1
    for i=1:size(hatali_cicekler,1)
        fprintf('%g. hatalý çiçeðin iris_dataset excel dosyasýndaki konumu %g. satýr\n',i,hatali_cicekler(i,1))
        fprintf('çanak yapraðý uzunluðu %g çanak yaprak geniþliði %g\ntaç yaprak uzunluðu %g taç yaprak geniþliði %g\n',hatali_cicekler(i,2),...
            hatali_cicekler(i,3),hatali_cicekler(i,4),hatali_cicekler(i,5));
        
    end
end