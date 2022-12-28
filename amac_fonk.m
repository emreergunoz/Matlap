i = 1;
for x=-5:1:5
    for y=-5:1:5
        amac_uzayi(i,1) = (x-3)^2 + (y-1)^2 + 4;
        arama_uzayi(i,:) = [x, y];
        i = i+1;
    end    
end
figure;
plot(arama_uzayi(:,1), arama_uzayi(:,2), 'ro');
title('Arama Uzayi');
xlabel('x');
ylabel('y');


figure;
plot(amac_uzayi, 'bo');
title('Amaç Uzayi');
xlabel('i.durum');
ylabel('Amac Fonksiyonu');