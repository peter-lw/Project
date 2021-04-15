% STS, Fb. EIT, Hochschule Darmstadt 
%Übung 3 
%Stand: 11.9.2012
%Aufgabe 1
clear all; close all; clc
% a
L=10e-3;    %H
R=100;      %Ohm
w=logspace(1,6,200);
wg=R/L     % Grenzkreisfrequenz wg=R/L
% Amplitudengang
Gw= 1./(1-j*R./(w*L));
Gwabs= abs(Gw);
figure
subplot(211)
semilogx(w,Gwabs)
%%
% Phasengang
phiw=angle(Gw);
subplot(212)
semilogx(w,phiw)
%%
% b) 
subplot(211)
grid
xlabel('{\it\omega}/s^-1')
ylabel('|{\itG(\omega)|}')
title('Amplituden- und Phasengang eines RL-Hochpass {\itR=}100\Omega, {\itL}=10mH')
%%
subplot(212)
xlabel('{\it\omega}/s^-1')
ylabel('{\it\phi(\omega)}/rad')
grid
%%
% c
figure
subplot(211)
semilogx(w/wg,20*log10(Gwabs))
grid
xlabel('{\it\omega}/\omega_g')
ylabel('20\cdotlg|{\itG(\omega)}|/dB')
title('Bodediagramm eines RL-Hochpass {\itR=}100\Omega, {\itL}=10mH')
%%
subplot(212)
semilogx(w/wg,phiw*(180/pi))
xlabel('{\it\omega}/\omega_g')
ylabel('{\it\phi(\omega)}/1°')
grid
%%
% d
figure 
plot(Gw)
grid
ylabel('\Im\{G(\omega)\}')
xlabel('\Re\{G(\omega)\}')
title('Ortskurve eines RL-Hochpass')
%%
%Zusatzaufgabe
wc=[min(w) wg max(w)];
Gwc= 1./(1-j*R./(wc*L));
hold on
plot(real(Gwc),imag(Gwc),'ro')
for m=1:length(wc)
    text(real(Gwc(m)),imag(Gwc(m)),['{\it\omega}=' num2str(wc(m)) 's^{-1}'])
end

