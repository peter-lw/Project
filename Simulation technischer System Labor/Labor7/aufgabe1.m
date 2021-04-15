clear all; clc; close all;

w0=5;
D=0.2;
s=tf('s')
G1s=1/(((s/w0)^2)+((2*D/w0)*s)+1);

%%B
G1=tf(G1s);

figure(1);
bode(G1);
grid;

wstart=1e-2;
wend=1e3;
w=logspace(log10(wstart),log10(wend),100);

[Gabs,phi]=bode(G1s,w);
Gabsdb=mag2db(Gabs);

figure
subplot(211)
title('Bode Diagramm');
semilogx(w,squeeze(Gabsdb));
grid on
xlabel('\it\omega/s^-1')
ylabel('20\cdotlg|{\itG(\omega)}|)')

phigr=180/pi*phi;
subplot(212)
semilogx(w,squeeze(phigr))
grid on
title('Bode Diagramm');
xlabel('\it\omega/s^-1')
ylabel('\it{\phi(\omega)}/1')

%%c plot der Ortskurve nur für w>=0 in eigener Regei

[re,im,w]=nyquist(G1s);
reg1s=squeeze(re);
img1s=squeeze(im);

figure
plot(reg1s,img1s);
xlabel('\Re');
ylabel('\Im');

%%oder
figure; h = nyquistplot(G1s); %Ortskurve
setoptions(h,'ShowFullContour','off') %jetzt nur noch für w>=0
xlabel('\Re')
ylabel('\Im')

%%D 
t0=1 %in sekunde
dt=t0/50;
t1=0:dt:t0;
t2=t0+dt:dt:5*t0;
t=[t1 t2];

x1= 2/t0*(sin(pi/t0*t1)).^2;
x2=zeros(1,length(t2));
xt=[x1 x2];

%%E
figure

subplot(311);
step(G1s,t);
subplot(312);
impulse(G1s,t);
subplot(313);
lsim(G1s,xt,t);

%%F
figure 
pzmap(G1s);

%%G

D1=1e-5;
D2=1;
D3=2;

G1s1=1/(((s/w0)^2)+((2*D1/w0)*s)+1);
G1s2=1/(((s/w0)^2)+((2*D2/w0)*s)+1);
G1s3=1/(((s/w0)^2)+((2*D3/w0)*s)+1);

%%H
figure
bode(G1s,G1s1,G1s2,G1s3);
legend('D=0.2','D=10^{-5}','D=1','D=2')
grid on

%%I
[re,im,w]=nyquist(G1s);
[re1,im1,w]=nyquist(G1s1);
[re2,im2,w]=nyquist(G1s2);
[re3,im3,w]=nyquist(G1s3);

reg1s=squeeze(re);
img1s=squeeze(im);
reg1s1=squeeze(re1);
img1s1=squeeze(im1);
reg1s2=squeeze(re2);
img1s2=squeeze(im2);
reg1s3=squeeze(re3);
img1s3=squeeze(im3);

figure(99)
subplot(121)
hold on;
plot(reg1s,img1s, 'k');
plot(reg1s3,img1s3, 'r')
plot(reg1s2,img1s2, 'g')
legend('D=0.2','D=1','D=2');
xlabel('\Re');
ylabel('\Im');

subplot(122)
plot(reg1s1,img1s1);
xlabel('\Re');
ylabel('\Im');
legend('D=10^-5');


%Oder 

figure;
subplot(121);
h=nyquistplot(G1s,G1s3,G1s2);
setoptions(h,'ShowFullContour','off');
legend('D=0.2','D=1','D=2');
xlabel('\Re');
ylabel('\Im');

subplot(122);
h=nyquistplot(G1s1);
setoptions(h,'ShowFullContour','off');
legend('D=10^-5');
xlabel('\Re');
ylabel('\Im');

%%J sprung antwort von G1s

figure
step(G1s,G1s1,G1s2,G1s3,t);
legend('D=0.2','D=10^{-5}','D=1','D=2');

%%K
figure
pzmap(G1s,G1s1,G1s2,G1s3);
legend('D=0.2','D=10^{-5}','D=1','D=2');

%%M
G2s=s*G1s;

%%N-b

G2=tf(G2s);

figure(1);
bode(G2);
grid;

w=logspace(log10(wstart),log10(wend),100);
[Gabs,phi]=bode(G2s,w);
Gabsdb=mag2db(Gabs);

figure
subplot(211)
title('Bode Diagramm');
semilogx(w,squeeze(Gabsdb));
grid on
xlabel('\it\omega/s^-1')
ylabel('20\cdotlg|{\itG(\omega)}|)')

phigr=180/pi*phi;
subplot(212)
semilogx(w,squeeze(phigr))
grid on
title('Bode Diagramm');
xlabel('\it\omega/s^-1')
ylabel('\it{\phi(\omega)}/1')

%%N-c plot der Ortskurve nur für w>=0 in eigener Regei

[re,im,w]=nyquist(G2s);
reg2s=squeeze(re);
img2s=squeeze(im);

figure
plot(reg2s,img2s);
xlabel('\Re');
ylabel('\Im');

%%oder
figure; h = nyquistplot(G2s); %Ortskurve
setoptions(h,'ShowFullContour','off') %jetzt nur noch für w>=0
xlabel('\Re')
ylabel('\Im')

%%N-D 
t0=1 %in sekunde
dt=t0/50;
t1=0:dt:t0;
t2=t0+dt:dt:5*t0;
t=[t1 t2];

x1= 2/t0*(sin(pi/t0*t1)).^2;
x2=zeros(1,length(t2));
xt=[x1 x2];

%%N-E
figure

subplot(311);
step(G2s,t);
subplot(312);
impulse(G2s,t);
subplot(313);
lsim(G2s,xt,t);

%%F
figure 
pzmap(G2s);








