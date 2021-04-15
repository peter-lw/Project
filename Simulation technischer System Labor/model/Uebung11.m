% STS, Fb. EIT, Hochschule Darmstadt
%Übung 11
%Stand: 11.09.2012
clear all;close all;clc
%a)
s = tf('s') %s wird als komplexe Frequenz definiert
w0=5
D=0.2
G1=1/(s^2/w0^2+2*D/w0*s+1) %1. PT2-System
p1=-1
p2=-0.5
G2=zpk([],[p1 p2],1) %2. PT2-System
GS=G1*G2
KP=5
GR=KP;
%%
%b)
Go=GR*GS
%%
%c)
figure;
h = nyquistplot(Go); %Re, Im und w ohne Plot
set(h,'showfullcontour','off') %Schnittpunkt bei -1
title('Ortskurve für {\itK}=5 (P-Regler)')
xlabel('Re\{{\itG(\omega)}\}'); ylabel('Im\{{\itG(\omega)}\}') %nicht gefordert
%%
%d)
%1. Abschätzung von Kkrit aus Ortskurve
Kkrit=1/0.68*KP %Ortskurve schneidet bei ungefähr -0.68 die neg, reelle Achse
%%
%e)
%Genaue Bestimmung von Kkrit nach Ausprobieren (Dauerschwingungen)
Kkrit=7.2
GR=Kkrit;
Gwkrit=minreal(GR*GS/(1+GR*GS));
figure;step(Gwkrit);grid %Tkrit ablesen und vergleichen
title('Sprungantwort für {\itK=K_{krit}} (P-Regler)')
%%
%f)
Tkrit=(16.5-3.13)/7 %abgelesen
%g)
figure
pzmap(Gwkrit) %System ist grenzstabil 1 Polpaar auf der imaginären Achse
title('PN-Diagramm für {\itK=K_{krit}} (P-Regler)')
%%
%h)
wkrit=3.32
2*pi/wkrit %ungefähr gleich Tkrit aus f)
%%
%i)
%Ziegler-Nichols (P-Regler)
KP=0.5*Kkrit; 
GR=KP;
GwP=minreal(GR*GS/(GR*GS+1))
figure
step(GwP); %deutliche Regelabweichung
title('Sprungantwort P-Regler (Ziegler-Nichols)')
%%
%j)
%Ziegler-Nichols (PI-Regler)
KP=0.45*Kkrit; 
KI=1.2*KP/Tkrit;
GR=KP*(1+1.2/(Tkrit*s))
GwPI=minreal(GR*GS/(GR*GS+1))
hold on
step(GwPI); %Es gibt nun keine Regelabweichung mehr
title('Sprungantwort PI-Regler (Ziegler-Nichols)')
%%
%k)
%Ziegler-Nichols (PID-Regler)
KP=0.6*Kkrit; 
T1=0.001;
KI=2/Tkrit*KP;
KD=0.125*Tkrit*KP
GR=KP+KI/s+KD*s/(1+T1*s);
GwPID=minreal(GR*GS/(GR*GS+1))
hold on
step(GwPID); %deutlich schneller als PI-Regler
title('Sprungantwort PID-Regler (Ziegler-Nichols)')
legend('P','PI','PID')
%l) siehe Uebung11_simulink.mdl
