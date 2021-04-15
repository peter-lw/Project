% STS, Fb. EIT, Hochschule Darmstadt
%Übung 4 
%Stand: 28.08.2013
%Aufgabe 3
clear all; close all; clc
M=5;
N=1e5;
for(m=1:M)
    mR(m,:)=rand(1,N);
end
%%
%b)
subplot(221); hist(mR(1,:),50);
subplot(222); hist(mR(2,:),50);
subplot(223); hist(mR(4,:),50);
subplot(224); hist(mR(5,:),50);
%c)
y=sum(mR,1); %alternativ: y=sum(mR);
%%
%d)
figure;
hist(y,50);
%%
%e)
figure;
[Habs, st]=hist(y,50);
Hrel=Habs/N;
bar(st,Hrel,1)

