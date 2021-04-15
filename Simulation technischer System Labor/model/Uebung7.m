% STS, Fb. EIT, Hochschule Darmstadt

%Übung 7

%Stand: 30.08.2013

clear all;close all;clc

%a)

s = tf('s') %s wird als komplexe Frequenz definiert

w0=5

D=0.2

G1S=1/(s^2/w0^2+2*D/w0*s+1) %PT2-System

%%

%b1)

figure

bode(G1S);

grid

%%

%b2)

w=logspace(-2,3,100);

[Gabs,phi]=bode(G1S,w);

figure

subplot(211);
semilogx(w,20*log10(squeeze(Gabs)));

grid

title('Bode Diagramm')

xlabel('{\it\omega}/s{^-1}')

ylabel('20\cdotlg|{\itG(\omega)}|)')

subplot(212);semilogx(w,squeeze(phi));

ylabel('{\it\phi(\omega)}/1°')

xlabel('{\it\omega}/s{^-1}')

grid

%%

%c)

[reG1S,imG1S,w] = nyquist(G1S); %Real-, Imaginärteil und w ohne Plot

reG1S=squeeze(reG1S); 

imG1S=squeeze(imG1S); 

figure

plot(reG1S,imG1S);

xlabel('\Re')

ylabel('\Im')

%oder

figure; h = nyquistplot(G1S); %Ortskurve

setoptions(h,'ShowFullContour','off') %jetzt nur noch für w>=0

xlabel('\Re')

ylabel('\Im')

%%

%d)

T0=1;

dt=T0/50;                                     

t1=0:dt:T0;                                   

t2=T0+dt:dt:5*T0;                            

t=[t1 t2];                                    

x1=2/T0*(sin(pi/T0*t1)).^2;                                    

x2=zeros(1,length(t2));                       

x=[x1 x2];                                    

%%

%e)

figure;

subplot(311);step(G1S,t)

subplot(312);impulse(G1S,t);

subplot(313);lsim(G1S,x,t);

%%

%f)

figure

pzmap(G1S)

%%

%g)

D=1e-5

G1S0=1/(s^2/w0^2+2*D/w0*s+1) 

D=1

G1S1=1/(s^2/w0^2+2*D/w0*s+1) 

D=2

G1S2=1/(s^2/w0^2+2*D/w0*s+1) 

%%

%h)

figure

bode(G1S0,G1S,G1S1,G1S2)

legend('D=10^{-5}','D=0.2','D=1','D=2')

%%

%i)

[reG1S0,imG1S0,w] = nyquist(G1S0); %Real-, Imaginärteil und w ohne Plot

reG1S0=squeeze(reG1S0); 

imG1S0=squeeze(imG1S0);

[reG1S1,imG1S1,w] = nyquist(G1S1); %Real-, Imaginärteil und w ohne Plot

reG1S1=squeeze(reG1S1); 

imG1S1=squeeze(imG1S1);

[reG1S2,imG1S2,w] = nyquist(G1S2); %Real-, Imaginärteil und w ohne Plot

reG1S2=squeeze(reG1S2); 

imG1S2=squeeze(imG1S2); 

figure

subplot(121);plot(reG1S,imG1S,reG1S1,imG1S1,reG1S2,imG1S2);

legend('D=0.2','D=1','D=2')

xlabel('\Re')

ylabel('\Im')

subplot(122);plot(reG1setS0,imG1S0);

xlabel('\Re')

ylabel('\Im')

%oder

figure; subplot(121); h = nyquistplot(G1S,G1S1,G1S2); %Ortskurve

setoptions(h,'ShowFullContour','off') %jetzt nur noch für w>=0

xlabel('\Re')

ylabel('\Im')

legend('D=0.2','D=1','D=2')

subplot(122); h = nyquistplot(G1S0); %Ortskurve

setoptions(h,'ShowFullContour','off') %jetzt nur noch für w>=0

xlabel('\Re')

ylabel('\Im')

%%

%j)

figure

step(G1S0,G1S,G1S1,G1S2,t)

legend('D=10^{-5}','D=0.2','D=1','D=2')

%%

%k)

figure

pzmap(G1S0,G1S,G1S1,G1S2)

legend('D=10^{-5}','D=0.2','D=1','D=2')

%l) 0<D<1 ,System schwingungsfähig, konj. komplexe Pols, D->0 starke Resonanzüberhöhung

%   => Ortskurve weit aufgebläht im Bereich der Resonanzfrequenz

%%

%m) a)

G2S=s*G1S

%%

%n) b)

figure

bode(G2S);

w=logspace(-2,3,100);

[Gabs,phi]=bode(G2S,w);

grid

figure

subplot(211);semilogx(w,20*log10(squeeze(Gabs)));

grid

title('Bode Diagramm')

xlabel('{\it\omega}/s{^-1}')

ylabel('20\cdotlg|{\itG(\omega)}|)')

subplot(212);semilogx(w,squeeze(phi));

ylabel('{\it\phi(\omega)}/1°')

xlabel('{\it\omega}/s{^-1}')

grid

%%

%n) %c)

[reG2S,imG2S,w] = nyquist(G2S); %Real-, Imaginärteil und w ohne Plot

reG2S=squeeze(reG2S); 

imG2S=squeeze(imG2S); 

figure

plot(reG2S,imG2S);

xlabel('\Re')

ylabel('\Im')

%oder

figure; h = nyquistplot(G2S); %Ortskurve

setoptions(h,'ShowFullContour','off') %jetzt nur noch für w>=0

xlabel('\Re')

ylabel('\Im')

%%

%n) %e)

figure;

subplot(311);step(G2S,t)

subplot(312);impulse(G2S,t);

subplot(313);lsim(G2S,x,t);

%%

%n) f)

figure

pzmap(G2S)

%o) D-Anteil wirkt differenzierend