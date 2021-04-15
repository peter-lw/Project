% STS, Fb. EIT, Hochschule Darmstadt 
%Übung 4 
%Stand: 28.08.2013
%Aufgabe 2
clear all; close all; clc
%b)
[xn, t, N] = myNoiseGen('n', 1e-3, 50e-3);
%%
%e)
[xg, t, N] = myNoiseGen('g', 1e-3, 50e-3);
%f)
%[xu, t, N] = myNoiseGen('x', 1e-3, 50e-3);
%%
%g)
plot(t,xn,'x-',t,xg,'x-')
xlabel('{\itt}/s');ylabel('\itx(t)');
grid
legend('gleichverteilt','normalverteilt')
%i)
%[xn, t, N] = myNoiseGen('n', 50e-3, 1e-3);
%[xn, t, N] = myNoiseGen('n', 1e-3, 0);
%%
%j)
figure
te=0.005;
dt=1e-3;
while te <= 1000
    [xn, t, N] = myNoiseGen('n', dt, te);
    [xg, t, N] = myNoiseGen('g', dt, te);
    [Habsn,binsn]=hist(xn,50);
    [Habsg,binsg]=hist(xg,50);
    subplot(1,2,1)
    bar(binsn,Habsn/N,1)
    axis([-5 5 0 0.1])
    xlabel('Werteintervalle'); 
    ylabel('\itH_{rel}(x(t))' ); 
    title(['normalverteilt t_e=' num2str(te) 's'])
    subplot(1,2,2)
    bar(binsg,Habsg/N,1)
    axis([0 1 0 0.1])
    xlabel('Werteintervalle'); 
    title(['gleichverteilt {\itt_e}=' num2str(te) 's'])
    te=3*te;
    pause(0.75)
end

