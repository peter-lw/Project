clc;close all;clear all;

w0=5;
D=0.2;
p1=-1;
p2=-0.5;
Kp=5;

s=tf('s');
G1s=1/((s/w0)^2+(2*D*s/w0)+1)
G2s=1/((s-p1)*(s-p2))
Gs=G1s*G2s

Grs=Kp;

Go=Grs*Gs;

figure; 
h = nyquistplot(Go); %Ortskurve
setoptions(h,'ShowFullContour','off') %jetzt nur noch für w>=0
xlabel('\Re')
ylabel('\Im')

%%d 
Kkrit=7.2;
Grs=Kkrit;
Go=Grs*Gs;
figure; 
h = nyquistplot(Go); %Ortskurve
setoptions(h,'ShowFullContour','off') %jetzt nur noch für w>=0
xlabel('\Re')
ylabel('\Im')

Gw=Grs*Gs/(1+Grs*Gs);
figure;
step(Gw);grid %Tkrit ablesen und vergleichen
title('Sprungantwort für {\itK=K_{krit}} (P-Regler)')

Gwkrit=minreal(Gw);%Vereinfachen die Uebertragungsfunktion
figure;
step(Gwkrit);grid %Tkrit ablesen und vergleichen
title('Sprungantwort für {\itK=K_{krit}} (P-Regler)Vereinfachen')

%f
Tkrit=(60-52.4)/4;%Ablesen

%g
figure
pzmap(Gwkrit);
title('PN-Diagramm für {\itK=K_{krit}} (P-Regler)');

%h
wkrit=3.32%ablesen von pzmap
%Wkrit=2*pi/Tkrit=3.3

%i Ziegler Nichols P-Regler
Kp=0.5*Kkrit;
Grs=Kp;
Gw=Grs*Gs/(1+Grs*Gs);
figure
step(Gw);
hold on 

%J Ziegler Nichols PI-Regler
Kp=0.45*Kkrit;
Ki=1.20*Kp/Tkrit;
Grs=Kp*(1+1.2/(Tkrit*s));%Tidak mengerti guna Ki
Gw=Grs*Gs/(1+Grs*Gs);
step(Gw);
hold on

%K Ziegler Nichols PID-Regler
Kp=0.6*Kkrit; 
T1=0.001;
Ki=2/Tkrit*Kp;
Kd=0.125*Tkrit*Kp
GR=Kp+Ki/s+Kd*s/(1+T1*s); %Kenapa formelnya jadi begini
GwPID=(GR*Gs/(GR*Gs+3))
hold on
step(GwPID); %deutlich schneller als PI-Regler
title('Sprungantwort PID-Regler (Ziegler-Nichols)')
legend('P','PI','PID')

%l
sim('aufgabe1_mod');























