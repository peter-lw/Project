clear all; clc ; close all;

f0=10%Hz
dt=1e-4
N1=1000
t=0:dt:(N1*dt)

x1=1+3*sin(50*2*pi*t)+6*cos(80*2*pi*t)+2*cos(200*2*pi*t)+3*sin(200*2*pi*t);
x2=sin(50*2*pi*t)-6*cos(100*2*pi*t)-2*cos(250*2*pi*t)-sin(250*2*pi*t);

subplot(311)
plot(t,x1,'b',t,x2,'r')
grid on
xlabel('{\itt}/s');
legend('{\itx_1(t)}','{\itx_2(t)}')
title('Zeitverlauf, Einseitiges Amplituden- und Phasenspektrum');

T0=1/f0
N=25

for n=1:N
    a1(n+1)=2/T0*trapz(t,x1.*cos(2*pi/T0*n*t))
    a2(n+1)=2/T0*trapz(t,x2.*cos(2*pi/T0*n*t))
    b1(n+1)=2/T0*trapz(t,x1.*sin(2*pi/T0*n*t))
    b2(n+1)=2/T0*trapz(t,x2.*sin(2*pi/T0*n*t))
end

D1=abs(a1-j*b1); %Amplitude
phi1=angle(a1-j*b1).*(D1>1e-12); %Phase. "Rechenungenauigkeiten"

D2=abs(a2-j*b2); %Amplitude
phi2=angle(a2-j*b2).*(D2>1e-12); %Phase. "Rechenungenauigkeiten"

%%Gleichanteil
a1(1)=2/T0*trapz(t,x1); %Berechnung des doppelten Gleichanteils
D1(1)=a1(1)/2; %Berechnung des Gleichanteils
phi1(1)=0;

a2(1)=2/T0*trapz(t,x2); %Berechnung des doppelten Gleichanteils
D2(1)=a2(1)/2; %Berechnung des Gleichanteils
phi2(1)=0;

%%Plotten 

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
ylabel('{\it\phi(n\cdotf_0)}/?');
xlabel('{\itn\cdotf_0}/Hz');

%d 
% +-90 Phasen bezogen auf cos(), +-180 phasen bezogen auf sin()
%Die Amplitude h?ngt von den Koeffizient des Signals ab

%%e
x21=1*sin(50*2*pi*t);
x22=-6*cos(100*2*pi*t);
x23=-2*cos(250*2*pi*t);
x24=-1*sin(250*2*pi*t);

figure
plot(t, x21, t, x22, t, x23 , t, x24)
grid
xlabel('{\itt}/s');
legend('{\itx_{21}(t)}', '{\itx_{22}(t)}', '{\itx_{23}(t)}','{\itx_{23}(t)}' )
title('Teilsignale von {\itx_2(t)}');

%%f kommentar

%%g

t1=0:dt:(N1*dt*3)
x1t1=1+3*sin(50*2*pi*t1)+6*cos(80*2*pi*t1)+2*cos(200*2*pi*t1)+3*sin(200*2*pi*t1);
x2t1=sin(50*2*pi*t1)-6*cos(100*2*pi*t1)-2*cos(250*2*pi*t1)-sin(250*2*pi*t1);

figure
plot(t1,x1t1,t1,x2t1,'r')
grid
xlabel('{\itt}/s');
ylabel('\itx_{1,2}(t)')

T01=0.1
T02=0.02
f01=1/T01
f02=1/T02

text1=['Grundfrequenz {\itx_1(t) f_{01}=1/T_{01}}=' num2str(f01) 'Hz']
text2=['Grundfrequenz {\itx_2(t) f_{02}=1/T_{02}}=' num2str(f02) 'Hz']
legend({text1 text2})

% Grundfrequenz, die die Periodendauer des Signals bestimmt





