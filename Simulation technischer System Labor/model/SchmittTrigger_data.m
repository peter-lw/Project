% STS, Fb. EIT, Hochschule Darmstadt

%�bung 9

%Stand: 11.09.2012

clear all; close all; clc



% c)

A=5; % Parameter f�r sine-Wave-Block

f=20;

 % Parameter f�r Relay-Block (Discontinuities)

Us=1;   % Schaltschwelle (Betrag)

Ua=5;   % Amplitude des Ausgangssignals (Betrag)

%%

% j)

Us1=0;

%%

% d)

simOut=sim('SchmittTrigger_mod');

%%

% f)

P=3; 

N=50;

simOut=sim('SchmittTrigger_mod','StartTime','0','StopTime','P/f','FixedStep','1/(f*N)')

t=simOut.get('tout');
Uet=simOut.get('Uet');

Uat=simOut.get('Uat');

%%

% g)

plot(t,Uet,t,Uat)

axis([0 max(t) -5.1 5.1])

grid

xlabel('t/s');legend('U_e(t)','U_a(t)')

title('Simulation eines Schmitt-Triggers')

%%

% h)

figure

plot(Uet,Uat)

axis([-A-0.1 A+0.1 -Ua-0.1 Ua+0.1])

xlabel('U_e(t)'); ylabel('U_a(t)');

title (['�bertragungskennlinie des Schmitt-Triggers {\it|U_s|}=' num2str(Us) 'V'])



% durch Schalthysterese (Schwelle uoff ~= uon) wird erreicht, 

% dass geringere St�rungen nicht zu einem irrt�mlichen Schalten des

% Schmitt-Triggers f�hren. 

% bei St�rungen, die das Signal �ber die Schltschwelle bringen, erfolgen

% aber trotzdem Fehlschaltungen (ca. bei 0.1s)

%%

%k)

Uest=simOut.get('Uest');

Uast=simOut.get('Uast');

figure

subplot(211)

plot(t,Uet,'b',t,Uat,'r',t,Uest,'g',t,Uast,'k')

grid

% legend('{\itU_{e}(t)} - ungest�rt','\itU_{a}(t)',...
% 
%        '{\itU_{es}(t)} - gest�rt','\itU_{as}(t)')

%%

%l)

Us1=1;

simOut=sim('SchmittTrigger_mod','StartTime','0','StopTime','P/f','FixedStep','1/(f*N)')

t=simOut.get('tout');

Uet=simOut.get('Uet');

Uat=simOut.get('Uat');

Uest=simOut.get('Uest');

Uast=simOut.get('Uast');

subplot(212)

plot(t,Uet,'b',t,Uat,'r',t,Uest,'g',t,Uast,'k')

grid

xlabel('{\itt}/s')

%%

% m)

subplot(211)

title('Bei gest�rtem Eingangssignal verbessert die Schalthysterese die Qualit�t des Ausgangssignals - oben {\it|U_s|}=0V unten {\it|U_s|}=1V')



% %Darstellungen f�r das Aufgabenblatt 

% figure

% subplot(211)

% plot(t,Uet)

% axis([0 max(t) -5.2 5.2])

% set(gca,'YTick',(-5:1:5))

% grid

% ylabel('U_e(t)')

% subplot(212)

% plot(t,Uat)

% axis([0 max(t) -5.1 5.1])

% grid

% xlabel('t/s');ylabel('U_a(t)')

