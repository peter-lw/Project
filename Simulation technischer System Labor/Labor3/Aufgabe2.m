clear all; clc
close all;

re=1000 %Ohm
ce=20e-12 %Farrad
n=10
c1=1.1e-12%Farrad
c2=3.3e-12%Farrad

c0=ce/(n-1)
r0=re*(n-1)

wstart=0
wend=10e10
w=logspace(wstart,log10(wend),1000)

vw0=(re./(re+r0*((1+j*w*re*ce)./(1+j*w*r0*c0))))
vw1=(re./(re+r0*((1+j*w*re*ce)./(1+j*w*r0*c1))))
vw2=(re./(re+r0*((1+j*w*re*ce)./(1+j*w*r0*c2))))

vw0abs=abs(vw0)
vw1abs=abs(vw1)
vw2abs=abs(vw2)


figure(1)
plot(w,vw0abs,w,vw1abs,w,vw2abs)
xlim([1 10e6])
grid on 
xlabel('{\it\omega} /s^{-1}')
ylabel('|{\itV(\omega)}|')
txt1=['abgeglichender Zustand C_v =' num2str(c0)]
txt2=['unterkompensierter Zustand C_v =' num2str(c1)]
txt3=['Ueberkompensierter Zustand C_v =' num2str(c2)]
title('Verstaerkungsverlaeufe beim frequenzkompensierten Spannungsteiler')
legend({txt1 txt2 txt3})


figure(2)
cv=linspace((c0./2),(2*c0),10)
for i=1:length(cv)
    vw01=(re./(re+r0*((1+j*w*re*ce)./(1+j*w*r0*cv(i)))))
    vw0absdB=mag2db(abs(vw01))
    semilogx(w,vw0absdB)
    hold all
end

for m=1:length(cv)
    txt4=[num2str(cv(m))]
    mleg(m)=string(txt4);   
end
xlim([1 10e10])
grid on 
title('Frequenzabhängiger Spannungsteiler in Abhängigkeit von C_v [pF]')
xlabel('{\it\omega} /s^{-1}')
ylabel('|{\itV(\omega)}|/dB')
legend(mleg)

%%zusatzaufgabe
x=(w*r0)'*cv
vw02=(re./(re+r0*((1+j*w*re*ce)./(1+j.*x))))
figure(3)
semilogx(w,mag2db(abs(vw02)))
xlim([1 10e10])
grid on 
title('Frequenzabhängiger Spannungsteiler in Abhängigkeit von C_v [pF]')
xlabel('{\it\omega} /s^{-1}')
ylabel('|{\itV(\omega)}|/dB')
legend(mleg)


