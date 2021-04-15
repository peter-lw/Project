clear all; clc ;close all

T0=0.001 ;
f0=1/T0
dt=T0/100;

t1=0:dt:0.25*T0;
t2=0.25*T0:dt:0.75*T0;
t3=0.75*T0:dt:T0;

t=[t1 t2 t3];

x1=1-(64*((t1-0.125*T0).^2)/(T0.^2));
x2=zeros(size(t2));
x3=-1+(64*((t3-0.875*T0).^2)/(T0.^2));

x=[x1 x2 x3];

%%c
figure
plot(t,x);
xlabel('{\itt/s}') ;
ylabel('{\itx(t)}');

%%d
N=25

for n=1:N
     a(n+1)=2/T0*trapz(t,x.*cos(2*pi/T0*n*t))
     b(n+1)=2/T0*trapz(t,x.*sin(2*pi/T0*n*t))    
end

D=abs(a-j*b); %Amplitude
phi=angle(a-j*b).*(D>1e-12); %Phase. "Rechenungenauigkeiten"

%%Gleichanteil
a(1)=2/T0*trapz(t,x); %Berechnung des doppelten Gleichanteils
D(1)=a(1)/2; %Berechnung des Gleichanteils
phi(1)=0;

%%plotten
n=0:length(D)-1;
figure
subplot(211)
stem(n*f0,D);
hold 
grid
ylabel('{\itD(n\cdotf_0)}');

subplot(212)
stem(n*f0,phi*180/pi);
ylabel('{\it\phi(k\cdotf_0)}/?');
xlabel('{\itk\cdotf_0}/Hz');












    
    
    
    
