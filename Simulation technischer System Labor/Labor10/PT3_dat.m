clear all; clc; close all;

L=100e-3;%Henry
C2=2.38e-3;%Farrad
C1=1.7e-3;%Farrad
R=30.5;%Ohm

a0=1;
a1=R*C1;
a2=L*(C1+C2);
a3=R*L*C1*C2;

dt=1e-2;
tstart=0;
tstop=0.5;
Uemax=10;%Volt
tstep=1e-6;

%B
s=tf('s');
Gs=1/((a3*s^3)+(a2*s^2)+(a1*s)+(a0));
t1=tstart:dt:tstop;

%C
ua_chk=Uemax*step(Gs,t1);

%D
figure(1)
plot(t1,ua_chk);
xlabel('\it{t/s}');
ylabel('\it{U_{achk}(t)/V}');
grid;
title('Sprungantwort eines Tiefpass 3.Ordnung');

%start der Simulation
simOut=sim('PT3_mod','StartTime','0','StopTime','tstop','SolverType','Fixed-Step','FixedStep','dt');
t=simOut.get('tout');
Ua=simOut.get('Ua');
Ue=simOut.get('Ue');

txt1=num2str('\it{U_{a}(t)/V}');

%Plotten das Ergebnis
figure(2)
subplot(211);
plot(t,Ue,t,ua_chk,t,Ua);
legend('\it{U_{e}(t)/V}',[txt1 '(Laplace)'],[txt1 '(integrator)']);
grid
xlabel('\it{t/s}');
ylim([0 Uemax+5]);
title('Sprungantwort eines Tiefpass 3.Ordnung');

%Verringerter Schrittweite
dt=1e-3;
simOut=sim('PT3_mod','StartTime','0','StopTime','tstop','SolverType','Fixed-Step','FixedStep','dt');
t=simOut.get('tout');
Ua=simOut.get('Ua');
Ue=simOut.get('Ue');

%Plotten das Ergebnis
figure(2)
subplot(212);
plot(t,Ue,t1,ua_chk,t,Ua);
legend('\it{U_{e}(t)/V}',[txt1 '(Laplace)'],[txt1 '(integrator)']);
grid
xlabel('\it{t/s}');
title('Sprungantwort eines Tiefpass 3.Ordnung mit verringerter Schrittweite');
ylim([0 Uemax+5]);

%J
s1=0.9;%volt schaltet to low
s2=0.1;%volt schaltet to high
ylow=0;%volt
yhigh=1;%volt 

%M
tstop=1.5;
dt=1e-3;
simOut=sim('rectgen_mod','StartTime','0','StopTime','tstop','Solver', 'ode3','SolverType','Fixed-Step','FixedStep','dt','LimitDataPoints','off');
t=simOut.get('tout');
Ua=simOut.get('Ua');
Uar=simOut.get('Uar');

figure(3)
plot(t,Ua,t,Uar);
title('Simulation eines Rechteck-Generators mit PT3-System und Invertierendem Schmitt-trigger');
legend(['Dreieck-Spannung' txt1], 'Rechteck-Spannung \it{U_{ar}(t)/V}' ); 
xlabel('\it{t/s}');
grid on;






















