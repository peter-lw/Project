clear all
clc
close all;

%% Uebung 1 

mMatrix = [7 3.14 j;-2.6 2-4j -1;45 9 -j]
svVektor =[3;4.5;9+j;-4]
zvVektor =[7 2.4 8j]
zvBig=(1:4:200)
mBig= [mMatrix mMatrix;mMatrix mMatrix]
mMatrix = [mMatrix;zvVektor]
mMatrix=[mMatrix [svVektor]]
mMatrix(3,:)=[]
mMatrix(:,4)=[]
mMatrix(2,2)=pi
xVektor=(-3:0.5:15)
idx=(2:4:37)
yVektor=xVektor(idx)

%% Uebung 2

x=[1 2 0.5 -3 -1]
y=[2 0 -3 1/3 2]'
x*y
sum(x.*y)
zva=[1 2 0.5 -3 -1 3 5 -2 0.3 -4]'
zvb=(zva>=-2 & zva<=2).*zva
zvc=zva(zva<-2 | zva>2)

%% Uebung 3
a=(1:1000);
b=1000*ones(1,1000);
bx = repelem(1000,1000)
c=(1000:-50:0)
d=zeros(1000:1)
dz = repelem(0,1000)
e=[a bx c d]
f=e;
plot(f);

%%Uebung 4 
t=[0:0.250:1]
st=sin(2*pi*5*t)
plot(t,st)
% t ist zu gross, deswegen ist die Abstand der Punkte zu gross 
t1=[0:0.01:1] 
st1=sin(2*pi*5*t1)
plot(t1,st1)


plot(t,st,t1,st1)

s2t1=exp(-10*t1).*st1.*st1
plot(t1,s2t1)






















