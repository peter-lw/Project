clc 
clear all
close all 

R=100 %ohm
L=10^-2%Henry
N=200

wstart=10;
wend=10^6;
w = logspace(1,log10(wend),N); 

wg=R/L; %Grenzkreisfrequenz
Gw=1./(1-(j*(wg./w)))
Gwabs=1./sqrt(1+((wg./w).^2)); % oder Gwabs=abs(Gw)
GwabsdB=mag2db(Gwabs)

figure('Name','Bode Diagram','NumberTitle','off')
subplot(2,1,1)
semilogx(w,GwabsdB,'k')      %halblogarithmische Darstellung
grid on 
xlabel('{\it\omega} /s^{-1}')
ylabel('|{\itG(\omega)}|/dB')
title('Amplituden- und Phasengang eines RL-Hochpass {\itR}=100{\Omega}, {\itL} = 10mH')

phiw=angle(Gw);
phiwgr=180/pi*phiw;
subplot(2,1,2)
semilogx(w,phiwgr,'k')
grid
xlabel('{\it\omega} /s^{-1}')
ylabel('{\it\phi(\omega)}/1\circ') %statt \circ auch ? m?glich
title('Phasengang')

figure('Name','Ortskurve','NumberTitle','off')
plot(real(Gw),imag(Gw))
ylabel('\Im\{{\itG(\omega)}\}')
xlabel('\Re\{{\itG(\omega)}\}')
title('Ortskurve des RC-Gliedes')
grid

wi=[0 wg max(w)]; % (1)
Gwi=1./(1-(j*(wg./wi)))
Gwir=real(Gwi); % (3)
Gwii=imag(Gwi);
hold on % (4)
plot(Gwir,Gwii,'ro')
for k=1:length(Gwi) % (5)
text(Gwir(k),Gwii(k),[num2str(wi(k)) 's^{-1}'])
end


