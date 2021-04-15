clear all
clc
close all

dt=1e-3 % Sekunde
te=50e-3%sekunde

[xn,t,n]=myNoiseGen('n',dt,te);%normalverteilung
[xg,t,n]=myNoiseGen('g',dt,te);%gleichverteilung
%[xg,t,n]=myNoiseGen('g',5,1);
%[xg,t,n]=myNoiseGen('g',dt,-1);

figure(1)
plot(t,xn,'o-',t,xg,'x-')
xlabel('{\itt/s}')
ylabel('{\itx(t)}')
legend({'gleichverteilt' 'normalverteilt'})
grid on

%relativ häufigkeit
dt1=1e-3%sekunde
te1=5e-3%sekunde
nbins=50%intervall

while(te1<1000)
    [xn1,t1,n1]=myNoiseGen('n',dt1,te1);%normalverteilung
    [xg1,t1,n1]=myNoiseGen('g',dt1,te1);%gleichverteilung
    
    
    figure(2)
    [habsn, nbinsn] = hist(xn1, 50);
    [habsg, nbinsg] = hist(xg1, 50);
    
    hreln = habsn/n1;
    hrelg = habsg/n1;
    
    subplot(1,2,1)
    bar(nbinsn, hreln);
    axis([-5 5 0 0.1]);
    text1 = ['normalverteilt t_e = ' num2str(te1) 's'];
    title(text1);
    xlabel('Werteintervalle');
    ylabel('{\itH_{rel}(x(t))}');
    
    subplot(1,2,2)
    bar(nbinsg, hrelg);
    axis([0 1 0 0.1]);
    text2 = ['gleichverteilt t_e = ' num2str(te1) 's'];
    title(text2);
    xlabel('Werteintervalle');
    
    
    te1=te1*3
    pause(0.75)
end











