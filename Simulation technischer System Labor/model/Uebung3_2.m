% STS, Fb. EIT, Hochschule Darmstadt 
%Übung 3
%Stand 11.9.2012
%Aufgabe 2
clear all; close all; clc
%a 
RE=1e6;         
CE=20e-12;
n=10;           
%%
%b
R0=(n-1)*RE;    
C0=CE/(n-1);    
C1=1.1e-12;
C2=3.3e-12
%%
%c
w=logspace(0,9,1000);  
%d
%%
vw0=RE./(RE+R0*((1+j*w*RE*CE)./(1+j*w*R0*C0)));  
vw1=RE./(RE+R0*((1+j*w*RE*CE)./(1+j*w*R0*C1)));  
vw2=RE./(RE+R0*((1+j*w*RE*CE)./(1+j*w*R0*C2)));  
%%
%e
plot(w,abs(vw0),w,abs(vw1),w,abs(vw2));            
axis([min(w) 1e6 0.04 0.16])
xlabel('{\it\omega}/s^{-1}')  
ylabel('|{\itv(\omega)}|')      
title('Verstärkungsverläufe beim frequenzkompensierten Spannungsteiler')
%%
%f
legend(['abgeglichender Zustand C_V=' num2str(C0)],...
       ['unterkompensierter Zustand C_V=' num2str(C1)],...
       ['überkompensierter Zustand C_V=' num2str(C2)])
%%
%g
CV=linspace(C0/2,C0*2,10);  
%%
%h
figure
for m=1:length(CV)   
    vw=RE./(RE+R0*((1+j*w*RE*CE)./(1+j*w*R0*CV(m))));
    semilogx(w,20*log10(abs(vw))); 
    hold all
end
%%
%i
legend(num2str(1e12*CV'))
grid
xlabel('{\it\omega}/s^{-1}')   
ylabel('20\cdotlg|{\itv(\omega)}|/dB')    
title('Frequenzabhängiger Spannungsteiler in Abhängigkeit von C_V [pF]')
%%
%Zusatzaufgabe
hold off
for m=1:length(CV)   
    vw(m,:)=RE./(RE+R0*((1+j*w*RE*CE)./(1+j*w*R0*CV(m))));
end
%%
%i
figure
semilogx(w,20*log10(abs(vw))); 
legend(num2str(1e12*CV'))
grid
xlabel('{\it\omega}/s^{-1}')   
ylabel('20\cdotlg|{\itv(\omega)}|/dB')    
title('Frequenzabhängiger Spannungsteiler in Abhängigkeit von C_V [pF]')


