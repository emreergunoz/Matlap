function plotGoster(particle, gbest_obj, iter)
    plot(particle(:,1), particle(:,2),'ro'); % parcaciklarin konumlarini goster
    xlabel('1.karar degiskeni x'); ylabel('2.karar degiskeni y');
    title(strcat('Iterasyon:', int2str(iter), '        GlobalMin: ', num2str(gbest_obj)));
    pause(0.5);

end

