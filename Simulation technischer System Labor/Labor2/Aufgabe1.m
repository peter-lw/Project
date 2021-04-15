%2.Labor 

clc
clear all
close all

f = 1000 %Hz
A = 3 % volt
As = A/5 % volt
N0=50 % punkte
P = 3 % periode
S=9/10*A %volt
S1=S%volt
S2=S-0.5%volt

T= 1/f %sekunde
dt= T/N0 %schrittweite
t1=(0:dt:(T/2-dt))
y1t=(2*A*t1/T)
stem(t1,y1t)
plot(t1,y1t,'r')
xlabel('{\itt}/s')
ylabel('{\ity_1(t)}')
grid on 

t2=(T/2:dt:(T-dt))
y2t=(A-(2*A/T*(t2-(T/2))))
stem(t2,y2t)

yPt=[y1t y2t]
tP=[t1 t2]
stem(tP,yPt)

yt=repmat(yPt,1,P)
t=(0:dt:P*T-dt)
%stem (t,yt) 
plot(t,yt)
hold on

v1=yt>S % S=9/10A, if yt>S dann ergibt '1' 
rt=v1.*A % alle '1' wird mit A=3 multipliziert
plot(t,rt)
Kt=S*ones(1,length(t))
plot(t,Kt,'k')
legend('{\ity(t)}','{\itr(t)}','Komparator-Schwelle')
%stem(t,v1,'g')
axis([0 max(t) -0.1,A+0.1])

st1=rand(1,length(yt)) % wertebereich<0,1>
stn=2*(st1-0.5)
st=As*stn
plot(t,st)

yst=yt+st
rst=A*(yst>Kt)
figure(2)
plot(t,yt,t,st,t,yst,t,rst,t,Kt,t,rt)
axis([0 max(t) -0.1,A+0.1])
grid on
legend('{\ity(t)}','\its(t)','\ity_s(t)','{\itrs(t)}','Komparator-Schwelle''\itr(t)')

figure(3)
    subplot(2, 2, 1)
    stem(t, yt)
    title('Dreieck-Signal')
    xlabel('\itt/s')
    ylabel('\ity(t)')
    subplot(2, 2, 2)
    plot(t, yst, 'red')
    title('gestoertes Dreieck-Signal')
    xlabel('\itt/s')
    ylabel('\ity_s(t)')
    subplot(2, 2, 3)
    plot(t, yt, 'blue', t, rt, 'red', t, Kt, 'black')
    title('Rechteck-Impulssignal')
    xlabel('\itt/s')
    ylabel('\ity(t),r(t)')
    subplot(2, 2, 4)
    plot(t, yst, 'blue', t, rst, 'red', t, Kt, 'black')
    title('Rechteck-Impulssignal')
    xlabel('\itt/s')
    ylabel('\ity_s(t),r_s(t)')


















