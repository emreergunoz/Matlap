clc; clear all; 

alt = -100; % alt sinir
ust = 150; % ust sinir
D = 4; % boyut sayisi

N = 50; % Surudeki kus (parcacik) sayisi
maxIterasyon = 200;

%% PSO_function.m dosyasindaki fonksiyon cagiriliyor
% Fonksiyon en iyi cozumun konumunu ve amac fonk degerini donduruyor
[gbest_pos, gbest_obj] = PSO_function(N, maxIterasyon, alt, ust, D);
