% STS, Fb. EIT, Hochschule Darmstadt 
% Übung 2
% Stand 10.9.12
clear all; close all; clc
%a) 
f=1000;         % Frequenz der periodischen Signale
A=3;            % Amplitude Dreieck           
As=A/20;        % Amplitude Störsignal
N0=50;          % Stützwerte pro Periode
P=3;            % Anzahl der Perioden
S=9*A/10;       % Komparatorschwelle
S1=S;           % Schmitt-Trigger-Schwellen
S2=S-0.5;
%%
%b) Zeitvektor
T=1/f;
dt=T/N0;
t1=0:dt:T/2-dt;
y1t=2*A/T*t1;
%%
%c)
plot(t1,y1t,'r')
hold on
stem(t1,y1t)
xlabel('{\itt/s}')
ylabel('\ity_1(t)')
%%
%d) 
t2=T/2:dt:T-dt;
y2t=A*(1-2/T*(t2-T/2));
%oder
y2t=-y1t+A;
figure;
stem(t2,y2t)
%%
%e) 
yPt=[y1t y2t];
yt=repmat(yPt,1,P);
%%
%f) 
N=length(yt);
t=dt*(0:N-1);
figure
plot(t,yt,'r')
hold on
stem(t,yt)
xlabel('{\itt/s}')
ylabel('\ity(t)')
%%
%g)
v1=yt>S;
rt=A*v1;
%%
%h) 
Kt=S*ones(1,N);         % Darstellung der Schwelle
%%
%i) 
figure
plot(t,yt,'b',t,rt,'r',t,Kt,'k')
xlabel('{\itt/s}')
legend('\ity(t)', '\itr(t)','Komparator-Schwelle')
axis([0 max(t) -0.1 A+0.1])
hold on
stem(t,v1,'g')
%%
%j)
st1=rand(1,N);
stn=2*(st1-0.5);
st=As*stn;
figure
plot(t,st,t,yt)
%%
%k) 
yst= yt+st;
hold on
plot(t,yst,'m');
%%
%l)
rst=A*(yst>S);
plot(t,rst,'r',t,Kt,'k')
legend('\its(t)','\ity(t)','\ity_s(t)','\itr_s(t)')
xlabel('{\itt/s}')
%%
%m) 
figure
subplot(2,2,1)
plot(t,yt,'r')
hold on
stem(t,yt)
xlabel('{\itt/s}')
ylabel('\ity(t)')
title('Dreieck-Signal')
subplot(2,2,2)
plot(t,yst,'r')
xlabel('{\itt/s}')
ylabel('\ity_s(t)')
title('gestörtes Dreieck-Signal')
subplot(2,2,3)
plot(t,yt,t,rt,'r',t,Kt,'k')
xlabel('{\itt/s}')
ylabel('\ity(t),r(t)')
title('Rechteck-Impulssignal')
subplot(2,2,4)
plot(t,yst,t,rst,'r',t,Kt,'k')
xlabel('{\itt/s}')
ylabel('\ity_s(t),r_s(t)')
title('Rechteck-Impulssignal')
%%
%n)Verändern Sie nun die verschiedenen Parameter nach der angegebenen Tabelle
% Kommentieren Sie die Veränderungen gegenüber den vorhergehenden Bildern 
%   N0    S           As
%   50    9/10*A      A/20
%    5    9/10*A      A/20 
%   50     3/5*A      A/20 
%   50     1/5*A      A/20 
%   50    9/10*A      A/10
%   50    9/10*A      A/2
%
%%
% Option
%o) 
rstt(1)=0;
for(k=2:N)
    rstt(k)= 0*(rstt(k-1)==0 & yst(k) <= S1)+...
             A*(rstt(k-1)==0 & yst(k) > S1)+...
             A*(rstt(k-1)> 0 & yst(k) > S2)+...
             0*(rstt(k-1)> 0 & yst(k) <= S2);
    %oder
    %rstt(k)= A*(yst(k) > S1)-A*(yst(k) < S2)... 		    %ohne "Gedächtnis"
    %         +rstt(k-1)*((yst(k) >= S2) & (yst(k) <= S1)); %mit "Gedächtnis"
end
%%
% p)
figure
subplot(3,1,1)
plot(t,yt,t,rt,'r',t,Kt,'k')
title('Gewinnung eines Rechteck-Impulssignals aus Dreieck-Signal mit Komperator')
xlabel('{\itt/s}')
legend('\ity_s(t)','\itr_s(t)')
subplot(3,1,2)
plot(t,yst,t,rst,'r',t,Kt,'k')
title('... verrauschtem Dreieck-Signal mit Komperator')
xlabel('{\itt/s}')
legend('\ity_s(t)','\itr_s(t)')
subplot(3,1,3)
plot(t,yst,t,rstt,'r',t,S1*ones(1,N),'k',t,S2*ones(1,N),'k')
title('... mit Schmitt-Trigger')
xlabel('{\itt/s}')
legend('\ity_s(t)','\itr_{st}(t)')






