% STS, Fb. EIT, Hochschule Darmstadt 
% Übung 1
% Stand 13.9.12
% Aufgabe 1
% a
clear all;close all;clc
mMatrix=[7 3.14 j;-2.6 2-4j -1;45 9 -j]
%%
% b
x=pi
%%
% c 
svVektor=[3;4.5;9+j;-4]
%%
% d
zvVektor=[7 2.4 8j];
%%
% e
zvBig=(1:4:200);
%%
% f
mBig=[mMatrix mMatrix;mMatrix mMatrix]
%%
% g
mMatrix=[mMatrix;zvVektor];
mMatrix=[mMatrix svVektor];
mMatrix=[mMatrix;[3 7.5 -4 2+3j]]
%%
% h
mMatrix(3,:)=[];
mMatrix(:,4)=[]
%%
% i
mMatrix(2,2)=pi;
%%
%j
x=(-3:0.5:500);
%%
%k)
idx=(2:4:length(x));
y=x(idx);
%%
% Aufgabe 2
% a
x=[1 2 0.5 -3 -1];
y=[2 0 -3 1/3 2];
xdotym=x*y'
xdotyf=sum(x.*y)
%%
% b
mA=[-3 3.5 10;8 -3.4 -11;2 1 1];
mB=[3 -2 -7;-1.5 -2.4 9;1 0 2];
mC=mA*mB
%%
% c
mE=eye(3);
mD=mA.*mE
%%
% d
mADiv=[2 2;1 0];
vBDiv=[2;1];
mF=mADiv\vBDiv
mF=inv(mADiv)*vBDiv
% mF1=vBDiv/mADiv
% führt zu Fehler, da vBDiv Spaltenvektor ist, die Inverse von mADiv 
% jedoch eine 2x2-Matrix 
% Die Multiplikation 2x[1 * 2]x2 führt zu einer Ungleichheit
% der inneren Matrix-Dimensionen
% 
%%
% e
K=[2 3 -5;-9 7 4;3 -6 4];
y=[-30;-19;44]
x=K\y
ykont=K*x
%%
% Aufgabe 3
mA=[-3 3.5 10;8 -3.4 -11; 2 1 1]
mMask= mA<-3 | mA>3
mB=mA.*mMask
%%
% Aufgabe 4
% a
a=(1:1000);
%%
% b
b=1000*ones(1,1000);
%%
% c
c=(1000:-50:0);
%%
% d 
d=zeros(1000,1);
%%
% e
e=[a b c d'];
%%
% f
f=[e e e e e];
plot(f)
%%
% Aufgabe 5
% a
t=(0:0.25:1);
%%
% b
st= sin(2*pi*5*t);
plot(t,st)
%%
% c
% die Schrittweite in t ist größer als die Periodendauer 
% von s(t) (T=200ms)
% dadurch entsteht in der Darstellung ein Signal der Frequenz 
% f=1Hz statt f=5Hz, wie es in der Gleichung angegeben ist. 
% um das Problem zu lösen, darf die Schrittweite in t maximal
% 100ms gewählt werden (fs>=2f lt. Abtastgesetz). Sie sollte jedoch 
% kleiner gewählt werden, um die Kurvenform des Sinus erkennbar 
% darzustellen
%%
% d
t1=(0:0.01:1);
st1= sin(2*pi*5*t1);
%%
% e
plot(t,st,t1,st1)
