% STS, Fb. EIT, Hochschule Darmstadt
%Übung 10
%Stand: 11.09.2012
close all; clear all; clc
clear all;close all;clc;
%a) 
R=30.5
C1=1.74e-3
C2=2.38e-3
L=100e-3
a3=R*L*C1*C2
a2=L*(C1 + C2)
a1=R * C1
tstart=0;
tstop=0.5;
dt=0.001;
Uemax=10;
tstep=1e-3;
%%
%b) 
s=tf('s');
Gs=1/(a3*s^3+a2*s^2+a1*s+1);
%%
%c)
t1=0:dt:0.5;
ua_chk=Uemax*step(Gs,t1);
%%
%d)
plot(t1,ua_chk)
grid
xlabel('{\itt}/s')
ylabel('{\itu_{achk}(t)}/V')
title('Sprungantwort eines Tiefpass 3. Ordnung')
%%
%g)
simOut=sim('PT3_mod', 'StartTime','tstart','StopTime','tstop', 'Solver', 'ode3')
t=simOut.get('tout');
ue=simOut.get('ue');
ua=simOut.get('ua');
%%
%h)
figure
subplot(211)
plot(t,ue,t1,ua_chk,t,ua)
grid
xlabel('{\itt}/s')
legend('{\itu_e(t)}/V','{\itu_a(t)}/V (Laplace)','{\itu_a(t)}/V (Integrator)');
title('Simulation eines Tiefpass 3.Ordnung (PT3-System)')
%%
%i
tstop=0.5;
simOut=sim('PT3_mod','StartTime','tstart','StopTime','tstop', 'Solver', 'ode3','FixedStep','dt')
t=simOut.get('tout');
ue=simOut.get('ue');
ua=simOut.get('ua');
subplot(212)
plot(t,ue,t1,ua_chk,t,ua)
grid
xlabel('{\itt}/s')
legend('{\itu_e(t)}/V','{\itu_a(t)}/V (Laplace)','{\itu_a(t)}/V (Integrator)')
title('Simulation eines Tiefpass 3.Ordnung (PT3-System) mit verringerter Schrittweite')
%genauere Darstellung der Kurve durch verbesserte Zeitauflösung 
%%
%Rechteck-Generator
%j)
s1=0.9;
s2=0.1;
ylow=0;
yhigh=1;
%%
%l)
tstop=1.5; %m)
simOut=sim('rectgen_mod','StartTime','tstart','StopTime','tstop',...
           'Solver', 'ode3','FixedStep','dt','LimitDataPoints','off')
t=simOut.get('tout');
ua=simOut.get('ua');
uar=simOut.get('uar');
figure
plot(t,ua,t,uar)
grid
xlabel('{\itt}/s')
legend('Dreieck-Spannung {\itu_a(t)}/V','Rechteck-Spannung {\itu_{ar}(t)}/V')
title('Simulation eines Rechteck-Generators mit PT3-System und invertierendem Schmitt-Trigger')
% das PT3-System integriert die Spannung, die der Schmitt-Trigger liefert
% dadurch steigt bzw. sinkt seine Ausgangsspannung, die am Eingang des
% Schmitt-Triggers ansteht und ihn bei Erreichen der Schaltschwellen s1
% bzw. s2 zum Kippen bringt

