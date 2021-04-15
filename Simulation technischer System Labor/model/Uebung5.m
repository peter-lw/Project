% STS, Fb. EIT, Hochschule Darmstadt
%Übung 5 
%Stand: 29.08.2013
close all;clear all;clc
%b)
A=3;
f0=10;
dt=5e-4;        % hier für Aufgabe g kleinere Schrittweite eintragen
t=0:dt:0.5;
[xtideal]= genRechteck(A,f0,t);
%%
%c)
plot(t,xtideal)
%axis([min(t) max(t) -A-0.1 A+0.1])
ylim([-A-0.1 A+0.1])
xlabel('{\itt}/s')
ylabel('\itx_{ideal}(t)')
title(['ideales Rechteck-Signal {\itA=}' num2str(A) ', {\itf=}' num2str(f0) 'Hz'])
%%
%e)
[x2t]=FourierRechteck(t,f0,A,2);
[x5t]=FourierRechteck(t,f0,A,5);
[x20t]=FourierRechteck(t,f0,A,20);
[x50t]=FourierRechteck(t,f0,A,50);
%%
%f)
figure
subplot(221)
plot(t,xtideal,'r',t,x2t,'b')
xlim([0 max(t)])
ylabel('\itx_2(t)')
subplot(222)
plot(t,xtideal,'r',t,x5t,'b')
xlim([0 max(t)])
ylabel('\itx_5(t)')
subplot(223)
plot(t,xtideal,'r',t,x20t,'b')
xlim([0 max(t)])
xlabel('{\itt}/s')
ylabel('\itx_{20}(t)')
subplot(224)
plot(t,xtideal,'r',t,x50t,'b')
xlim([0 max(t)])
ylabel('\itx_{50}(t)')
xlabel('{\itt}/s')
%Die hochfrequenten Oberwellen werden nur noch zeitlich grob dargestellt,
%Dies hängt mit der Wahl der Schrittweite beim Zeitvektor zusammen.
%%
%g) 
% Diese Aufgabe erfordert, die Schrittweite des Zeitvektors
% dt oben zu verringern, da man sonst bei hohen Frequenzen das 
% Abtastgesetz (fs=1/dt >= f/2) verletzt, damit die Harmonischen 
% nicht mehr mit korrekter Frequenz berechnet und der Fehler nicht unter einen 
% bestimmten Wert (ca. 0,18) sinkt, obwohl man immer mehr Oberwellen
% in die Fourierreihe aufnimmt
% Die Aufgabe wurde entsprechend angepasst
Nmax=200;
Tmax=1/((2*Nmax+1)*f0);  %Periodendauer der Harmonischen mit der höchstmöglichen Frequenz
dt=Tmax/10;         %10 Stützwerte pro Periode
t=0:dt:0.5;
[xtideal]= genRechteck(A,f0,t);
%%
%h)
N=1;
e=1;
while(e>=0.02 && N<=Nmax)
    [xNt]=FourierRechteck(t,f0,A,N);
    e=(sum((xtideal-xNt).^2)/length(xNt)); %oder mean((xtideal-xNt).^2)
    N=N+1;
end
%%
%h)
figure
plot(t,xtideal,'r',t,xNt,'b')
xlabel('{\itt}/s')
legend('\itx_{ideal}(t)', ['\itx_{' num2str(N-1) '}(t)'])
title(['Approximation mit {\itN=}' num2str(N-1) ' Oberwellen und Fehlerwert {\ite= }' num2str(e)])
%Höchste Oberwelle wird gut repräsentiert
%%
%i)
for(N=0:100)
    [xNt]=FourierRechteck(t,f0,A,N);
    e(N+1)=sum((xtideal-xNt).^2)/length(xNt);
end
figure
plot((0:N),e,'x-')
xlabel('Anzahl Oberwellen \itN')
ylabel('{\ite(N)}')
