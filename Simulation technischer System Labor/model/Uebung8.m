clear all; clc; close all;

%a)

R = 10;
L = 100e-3;
C = 100e-6;
Uemax = 2;
Uc0 = 4;
I0 = 0;
tstart = 0;
tstop = 0.1;
TA = 0.0001;
dt = 1e-6;

%b)

D = (R/2)*sqrt(C/L);
w0 = 1/(sqrt(L*C));
fe = (1/(2*pi))*w0*sqrt(1-D^2);


%c)

t1 = tstart:dt:tstop;
Ue1 = Uemax*ones(size(t1));

%d)

Uc_exakt = Uc0+(Uemax-Uc0)*(1-exp(-w0*D.*t1)*(1/sqrt(1-D^2)).*sin(w0*sqrt(1-D^2).*t1+acos(D)));

figure
plot(t1,Ue1,t1,Uc_exakt);
grid
xlabel('{\itt}/s')
ylabel('{\itU(t)}/{\itV}')
txt1 ='{\itU_e(t)}';
txt2 ='{\itU_{Cexakt}(t)}';
title('Simulation eines RLC-Reihenschwingkreises')


%e)

s = tf('s');
Gs = Uc0+(Uemax-Uc0)*1/((L*C*s^2)+(R*C*s)+1);
hold all
[Uc_step]=step(Gs,t1); 
plot(t1,Uc_step)
txt3 ='{\itU_{Cstep}(t)}';


%f)

t = (tstart:TA:tstop)';   
% Definition des Zeitvektors als Spaltenvektor für Plots
k = max(size(t)) ;    % Anzahl der Zeitwerte berechnen
Ue = 2*ones(size(t)) ;  % Definition des Eingangssignals: 1V Sprungsignal
Uc_euler = zeros(size(t)) ; % Leeren Ergebnisvektor definieren
%* Integration mit dem Eulerschen Polygonzugverfahren
Uc_euler(1) = 4 ;         % Anfangsbedingung UC(t0=0)
I_euler(1) = 0 ;
for i=1:(k-1)
    I_euler(i+1) = I_euler(i)+TA*((Ue(i)-R*I_euler(i)-Uc_euler(i))/L);
    Uc_euler(i+1) = Uc_euler(i)+TA*(I_euler(i)/C);
end

plot(t,Uc_euler)
txt4 ='{\itU_{Ceuler}(t)}';
legend(txt1,txt2,txt3,txt4)
hold off
%Abtastzeit = 0.0001s, mit Abtastzeiten >= 0.001 kein brauchbares Ergebniss

%g)
%mit Abtastzeiten < 0.00001 eine sehr genaue Näherung möglich
%bei 0.000001 kein Unterschied zu Uc_exakt erkennbar

%h)

%Dauerschwingungszustand, bei TA > 0.000001 weicht die Eulersche-
%Näherung mit zunehmender Zeit immer weiter ab, bei TA < 0.0000001 keine
%Abweichung zu erkennen


%i)

figure
subplot(2,1,1)
plot(t,Uc_euler)
title('Kondensator')
ylabel('{\itU_C(t)}/{\itV}')
grid
subplot(2,1,2)
plot(t,I_euler)
ylabel('{\itI_C(t)}/{\itV}')
xlabel('{\itt}/s')
grid

%j)
figure
Ul = Ue1-Uc_exakt;
plot(t1,Ue1,t1,Uc_exakt,t1,Ul);
grid
xlabel('{\itt}/s')
ylabel('{\itU(t)}/{\itV}')
txt1_1 ='{\itU_E(t)}';
txt1_2 ='{\itU_C(t)}';
txt1_3 ='{\itU_L(t)}';
title('Spannung an L,C,Eingang')
legend(txt1_1,txt1_2,txt1_3);