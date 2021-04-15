clc; close all; clear all;

R=10%Ohm
L=0.1%Henry
C=1e-4%Farrad
Uemax=2%volt
TA=1e-4;
dt=100e-6;
tstart=0;
tend=0.1;
Uc0=4;
I0=0;

%%B
D=(R/2)*sqrt(C/L);
w0=1/sqrt(L*C);
fe=1/2*pi*w0*sqrt(1-(D^2));


%%C
t1=tstart:dt:tend;
Ue=Uemax*(ones(size(t1)));

%if uc(0)=0 und I0=0
%Uct=Uemax.*(1-((exp(-w0*D*t)).*1./(sqrt(1-(D^2))).*(sin(w0.*(sqrt(1-D^2)).*t)))+acos(D));
%Ult=;

%%D
%if uc(0)~=0 und I0=0
Uc_exakt = Uc0+(Uemax-Uc0)*(1-exp(-w0*D.*t1)*(1/sqrt(1-D^2)).*sin(w0*sqrt(1-D^2).*t1+acos(D)));

s=tf('s');
Gs=Uc0+(Uemax-Uc0)*1/(((s/w0)^2)+((2*D/w0)*s)+1);
figure
plot(t1,Ue,t1,Uc_exakt);
xlabel('{\itt}/s')
ylabel('{\itU(t)}/{\itV}')
txt1 ='{\itU_e(t)}';
txt2 ='{\itU_{Cexakt}(t)}';
title('Simulation eines RLC-Reihenschwingkreises')

%%E
hold all;
[Uc_step]=step(Gs,t1);
grid
txt3 ='{\itU_{Cstep}(t)}';
plot(t1,Uc_step);


%%F
t=(tstart:TA:tend)';
k=max(size(t));
Ue1=2*ones(size(t));
Uc_euler=zeros(size(t));

Uc_euler(1)=4;
I_euler(1)=0;
for i=1:k-1
    Uc_euler(i+1)=Uc_euler(i)+(TA*(I_euler(i)/C));
    I_euler(i+1)=I_euler(i)+TA*((Ue1(i)-R*I_euler(i)-Uc_euler(i))/L);
end

plot(t,Uc_euler)
txt4 ='{\itU_{Ceuler}(t)}';
legend({txt1,txt2,txt3,txt4});

%bei TA=1e-4 versucht das diagram näherungsweise
% So erklärt sich der mit zunehmender Simulationsdauer tendenziell größer werdende Fehler einer numerischen
% Simulation. Bei hinreichend kleinem Abtastintervall TA ist die Folge der xk jedoch eine brauchbare Näherung
% der exakten Lösung der DGL zu den Zeitpunkten tk .

%%G
% wenn die TA<1e-4 ist, dann die kurve läuft fast genau die gleiche, bis TA<=1e-6 läuft genau die gleiche.

% %H
% dann es zeigt uns eine Dauerschwingung, es wird nicht gedämpf 

%I
figure
subplot(211)
plot(t,I_euler);
ylabel('\it{I_{c}(t)/A}')
title('Kondensator')
grid 

subplot(212)
plot(t,Uc_euler);
ylabel('\it{U_{c}(t)/V}')
xlabel('\it{t/s}')
grid


%j)
figure
Ul = Ue-Uc_exakt-(I_euler.*R);
plot(t1,Ue,t1,Uc_exakt,t1,Ul);
grid
xlabel('{\itt}/s')
ylabel('{\itU(t)}/{\itV}')
txt5 ='{\itU_E(t)}';
txt6='{\itU_C(t)}';
txt7 ='{\itU_L(t)}';
title('Spannung an L,C,Eingang')
legend(txt5,txt6,txt7);















