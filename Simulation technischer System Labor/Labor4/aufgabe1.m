clear all; clc
close all 

t=(0:10e-6:0.05)
t1=linspace(0,0.05,length(t))
xt=sin(2*pi*400*t)
yt=sin(2*pi*500*t)

zt=xt.*yt

n=-0.4+(0.4-(-0.4)).*rand(1,length(zt))

zn=zt+n

plot(t,zn)
xlim([0 0.04])
xlabel('{\itt/s}')
ylabel('Z_n{\it(t)}')

