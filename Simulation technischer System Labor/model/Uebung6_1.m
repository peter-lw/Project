% STS, Fb. EIT, Hochschule Darmstadt

%Übung 6

%Aufgabe 2

%Stand: 29.08.2013



clear all; close all; clc

% a)

f0=10;

dt = 0.1e-3;

N1 = 1000; 

t=0:dt:N1*dt; % Zeitvektor

%%

% Erzeugung der Signale

x10=1;

x11=3*sin(50*2*pi*t);

x12=6*cos(80*2*pi*t);

x13=2*cos(200*2*pi*t);

x14=3*sin(200*2*pi*t);

x1 = x10 + x11 + x12 +x13 + x14;

x21=1*sin(50*2*pi*t);

x22=-6*cos(100*2*pi*t);

x23=-2*cos(250*2*pi*t);

x24=-1*sin(250*2*pi*t);

x2 = x21 + x22 + x23 + x24;



% plot der Zeitsignale

figure

subplot(311); 

plot(t, x1, t, x2,'r')

grid

xlabel('{\itt}/s');

legend('{\itx_1(t)}','{\itx_2(t)}')

title('Zeitverlauf, Einseitiges Amplituden- und Phasenspektrum');



%%

% b)

%Berechnung des Fourierspektrums für 25 Werte

%Integriert wird über eine ganze Zahl n von Perioden, entspricht 0...n*2Pi

T0=1/f0;            % Periodendauer von x1

N=25;

A1=zeros(1,N+1); %Koeffizientenvektoren mit 0 initialisieren 

B1=zeros(1,N+1); %(Matlab muss die Vektoren nicht in jedem Schleifendurchlauf verlängern)

A2=zeros(1,N+1); 

B2=zeros(1,N+1);

for n=1:N

        A1(n+1)=2/T0*trapz(t,x1.*cos(2*pi*f0*n*t));

        B1(n+1)=2/T0*trapz(t,x1.*sin(2*pi*f0*n*t));

        A2(n+1)=2/T0*trapz(t,x2.*cos(2*pi*f0*n*t));

        B2(n+1)=2/T0*trapz(t,x2.*sin(2*pi*f0*n*t));

end

D1=abs(A1-1j*B1);               %Amplitude

phi1=angle(A1-1j*B1).*(D1>1e-9); %oder -atan2(B1,A1).*(D1>1e-9)

%Numerisch bed. unsinnige Phasen werden durch .*(D1>1e-9) eliminiert

D2=abs(A2-1j*B2);               

phi2=angle(A2-1j*B2).*(D2>1e-9); %oder -atan2(B2,A2).*(D2>1e-9)



A1(1)=2/T0*trapz(t,x1);       %Berechnung des doppelten Gleichanteils

D1(1)=A1(1)/2;

phi1(1)=0;

A2(1)=2/T0*trapz(t,x2);

D2(1)=A2(1)/2;

phi2(1)=0;

%%

%c) Plotten der Spektren

n=0:length(D1)-1; %Indexvektor (D1 und D2 gleich lang)

subplot(312); 

stem(n*f0,D1);

hold all

stem(n*f0,D2,'xr');

grid;

ylabel('{\itD(n\cdotf_0)}');

subplot(313); 

stem(n*f0,phi1*180/pi);

hold all

stem(n*f0,phi2*180/pi,'xr');

grid;

ylabel('{\it\phi(n\cdotf_0)}/°');

xlabel('{\itn\cdotf_0}/Hz');

%%

%d)

%Amplituden im Amplitudenspektrum sind Werte der Koeffizienten der Gleichungen

%Phase -+90° bei +-sin-Funktionen, 0°180° bei +-cos-Funktionen

%bzw. -atan2(B,A) bei Addition von A*cos und B*sin  

%e)

figure

plot(t, x21, t, x22, t, x23 , t, x24)

grid

xlabel('{\itt}/s');

legend('{\itx_{21}(t)}', '{\itx_{22}(t)}', '{\itx_{23}(t)}','{\itx_{23}(t)}' )

title('Teilsignale von {\itx_2(t)}');

%%

%f

%Amplitude eines Teilsignals -> Amplitude einer Linie im Amplitudenspektrum 

%1/Periodendauer eines Teilsignals -> Frequenz seiner Linie im

%Amplitudenspektrum (ggf. auch im Phasenspektrum)

%Phasenverschiebung des Signals gegenüber cos -> Höhe der Linie seiner Frequenz im Phasenspektrum

%%

%g

t1=(0:dt:3*N1*dt);    % Zeitvektor

x1t1 = 3*sin(50*2*pi*t1) + 6*sin(80*2*pi*t1) + 2*sin(200*2*pi*t1);

x2t1 = 1*sin(50*2*pi*t1) + 6*cos(100*2*pi*t1) + 2*sin(200*2*pi*t1);

figure

plot(t1,x1t1,t1,x2t1,'r')

grid

xlabel('{\itt}/s');

ylabel('\itx_{1,2}(t)')

T01=0.1;

T02=0.02;

f01=1/T01;

f02=1/T02;

% legend( ['Grundfrequenz {\itx_1(t) f_{01}=1/T_{01}}=' num2str(f01) 'Hz'], ...
% 
%         ['Grundfrequenz {\itx_2(t) f_{02}=1/T_{02}}=' num2str(f02) 'Hz'])

% Größter gemeinsamer Teiler der beteiligten Frequenzen ist die

% Grundfrequenz, die die Periodendauer des Signals bestimmt

%%

% h)

fs = 1/dt;                      % Abtastfrequenz

Nfft=round(4*T02/dt);            % 4 Perioden von x2

Nfft1=round(4.5*T02/dt);          % 4.5 Perioden von x2

%%

%i)

f = 0:fs/Nfft:fs/2;              %Berechnung der Frequenzvektoren

f1 = 0:fs/Nfft1:fs/2;            

%%

%j)

X2f = abs(fft(x2,Nfft)*2/Nfft);

X2f(1)=X2f(1)/2; %bei f=0 wird anders skaliert

X2f1 = abs(fft(x2,Nfft1)*2/Nfft1);

X2f1(1)=X2f1(1)/2; %bei f=0 wird anders skaliert

if mod(N,2)==0 

    X2f1(N/2+1)=X2f1(N/2+1)/2; %bei f=fs/2 wird anders skaliert

end

X2f = X2f(1:length(f));

X2f1 = X2f1(1:length(f1));

%%

%k)

figure

stem(f,X2f,'bo');

hold all;

stem(f1,X2f1,'rx');

axis([0 500 0 max(X2f)])

ylabel('|{\itX_2(f)}|');

xlabel('{\itf}/Hz');

title('Amplitudenspektrum berechnet über');

legend('4 Perioden von {\itx_2(t)}', '4.5 Perioden von {\itx_2(t)}')

grid;



% j)

% Für die ganze Anzahl analysierter Perioden ergibt sich das gleiche

% Ergebnis wie in c).

% Für die 4.5 Perioden liegen die Frequenzlinien an anderen Positionen 

% der Frequenzskala (andere Frequenzauflösung) und es entsteht nicht nur eine 

% von 0 verschiedene Linie bei der erwarteten Frequenz sondern das Spektrum 

% ist verfälscht und zeigt mehr Frequenzen an, als im Signal enthalten sind.

% => spektraler Leckeffekt



