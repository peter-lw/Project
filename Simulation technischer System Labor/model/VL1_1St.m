%VL1_1St, STS WS14
%Löschen aller Variablen
%Schließen aller Plot-Fenster
%Inhalt des Command Windows löschen
clear all; close all; clc
a=5; %a bekommt den Wert 5
b=3;
c=a*b; %Ergebnis Mult. in Variable c
whos
%weitere elementare Operationen
d=a/b
e=a^b
disp(d)
disp('e=')
disp(e)
%in einer Zeile
disp(['e=' num2str(e)]);
%vordefinierte Variablen
f=pi %z.B. pi
format long %nur für Ausgabe
pi
format short
%Variable e nicht vordefiniert
e=exp(1); %nun ist e wie gewohnt definiert
%e ist nun neu definiert
%einige elementare Funktionen
phi=pi/3;
phi_Grad=phi*180/pi
x=cos(phi)
y=sin(phi)
k=100;
u=log10(k) %10er Logarithmus
v=log(e); %ln
w=log2(16); %ld
%i und j sind auch vordefiniert
CZ=4+4*j;
%betrag und Phase(Winkel
Betr_CZ=abs(CZ)
phi_CZ_Grad=angle(CZ)*180/pi
Wurzela=sqrt(a) %Wurzel
