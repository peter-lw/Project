close all; clear all;clc;

A=5;%volt
f=20;%Hz
Uson=1;%Volt
Usoff=-1;%volt
Uamax=5;%Volt
Uamin=-5;%Volt

%simulationsparameter
P=3;% 3 Perioden
N=50; %Stutzpunkte jede Periode
tstop=1/f*P;
dt=1/(f*N);
Ustor=3;%Volt amplitude stör <-3 3>
%j<
Us1=0;

%Start der Simulation
simOut=sim('SchmittTriggers_mod','StartTime','0','StopTIme','tstop','SolverType','Fixed-Step','FixedStep','dt');
t=simOut.get('tout');
Uet=simOut.get('Uet');
Uat=simOut.get('Uat');

%plotten
figure
plot(t,Uet,t,Uat);
grid
ylim([-5.1;5.1]);
xlabel('t/s');
legend('U_e(t)','U_a(t)');
title('Simulation eines Schmitt-Triggers');

%H
Us=1;
figure
plot(Uet,Uat);
axis([-A-0.1 A+0.1 -Uamax-0.1 Uamax+0.1]);
grid;
xlabel('U_e(t)'); ylabel('U_a(t)');
title (['Übertragungskennlinie des Schmitt-Triggers {\it|U_s|}=' num2str(Us) 'V'])

%%Störung 

%I
Uast=simOut.get('Uast');
%K
Uest=simOut.get('Uest');

figure
subplot(211)
plot(t,Uet,t,Uat,t,Uest,t,Uast);
legend('U_e(t)','U_a(t)','U_{es}(t)','U_{as}(t)');
grid
ylim([-10 10]);
title('Bei gestörtem Eingangssignal verbessert die Schalthysterese die Qualität des Ausgangssignals - oben {\it|U_s|}=0V unten {\it|U_s|}=1V')

%%L
Us1=1;
simOut=sim('SchmittTriggers_mod','StartTime','0','StopTIme','tstop','SolverType','Fixed-Step','FixedStep','dt');

Uast=simOut.get('Uast');
subplot(212)
plot(t,Uet,t,Uat,t,Uest,t,Uast);
grid
ylim([-10 10]);
xlabel('t/s');







