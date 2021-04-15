% STS, Fb. EIT, Hochschule Darmstadt
%Übung 6
%Aufgabe 2
%Stand: 29.08.2013

clear all; close all; clc
% a)
T0=0.001;
dt = T0/100;
t1=0:dt:0.5*T0;
t2=0.5*T0+dt:dt:T0;
t=[t1 t2] % Zeitvektor
%%
% b)
% Erzeugung der Signale
f0=1/T0;
x1=1-16*((t1-0.25*T0)/T0).^2;
x2=zeros(size(t2));
x=[x1 x2];
%%
% c)
plot(t,x)
xlabel('{\itt}/s');ylabel('\itx(t)')
%%
% d)
%Berechnung des Fourierspektrums für 25 Werte
%Integriert wird über eine ganze Zahl n von Perioden, entspricht 0...n*2Pi
N=25;
A=zeros(1,N+1); %Koeffizientenvektoren mit 0 initialisieren 
B=zeros(1,N+1); 
for n=1:N
        A(n+1)=2/T0*trapz(t,x.*cos(2*pi*f0*n*t));
        B(n+1)=2/T0*trapz(t,x.*sin(2*pi*f0*n*t));
end
D=abs(A-1j*B);               %Amplitude
phi=angle(A-1j*B).*(D>1e-9); %oder -atan2(B,A).*(D>1e-9)
%Numerisch bed. unsinnige Phasen werden durch .*(D1>1e-9) eliminiert
A(1)=2/T0*trapz(t,x);       %Berechnung des doppelten Gleichanteils
D(1)=A(1)/2;
phi1(1)=0;
%%
%e) Plotten der Spektren
n=0:length(D)-1; %Indexvektor
figure
subplot(211); 
stem(n*f0,D);
grid;
ylabel('{\itD(k\cdotf_0)}');
subplot(212); 
stem(n*f0,phi*180/pi);
grid;
ylabel('{\it\phi(k\cdotf_0)}/°');
xlabel('{\itk\cdotf_0}/Hz');