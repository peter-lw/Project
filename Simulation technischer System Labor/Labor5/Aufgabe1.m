clear all; clc; close all
A=3
f0=10
t=0:5e-4:0.5
[xt]=genRechteck(A,f0,t)

figure(1)
plot(t,xt)
title('Ideales Rechteck-Signal A=3, f=10Hz')
ylim([-A-0.1 A+0.1])
xlabel('{\itt}/s')
ylabel('\itx_{ideal}(t)')

figure(2)
[x2t]= FourierRechteck(t,f0,A,2)
[x5t]= FourierRechteck(t,f0,A,5)
[x20t]= FourierRechteck(t,f0,A,20)
[x50t]= FourierRechteck(t,f0,A,50)

subplot(221)
plot(t,xt,'b',t,x2t,'r')
ylabel('{\itx_2(t)}')
xlim([0 max(t)])

subplot(222)
plot(t,xt,'b',t,x5t,'r')
ylabel('{\itx_5(t)}')
xlim([0 max(t)])

subplot(223)
plot(t,xt,'b',t,x20t,'r')
ylabel('{\itx_20(t)}')
xlabel('{\itt/s}')
xlim([0 max(t)])

subplot(224)
plot(t,xt,'b',t,x50t,'r')
ylabel('{\itx_50(t)}')
xlabel('{\itt/s}')
xlim([0 max(t)])

N_max=100
fmax=((2*N_max)+1)*f0
dt=1/(10*fmax)
t=(0:dt:0.5)
en=1
N=0
[xt]=genRechteck(A,f0,t)


while ((en>=0.02) && (N<=N_max))
    [xNt]= FourierRechteck(t,f0,A,N);
    e=((xt-xNt).^2);
    en=sum(e);
    en=en/length(xNt);
    N=N+1;
end

figure(3)
plot(t,xNt)
text1=(['Approximation mit N=' num2str(N) ' Oberwellen und Fehlerwert e=' num2str(en)]);
title(text1)
xlabel('{\itt/s}')


figure
for (a=0:100)
    [xNt]= FourierRechteck(t,f0,A,a)
    en(a+1)=sum((xt-xNt).^2)/length(xNt);
end

plot([0:a],en,'x-')
xlabel('Anzahl Oberwellen \itN')
ylabel('{\ite(N)}')









