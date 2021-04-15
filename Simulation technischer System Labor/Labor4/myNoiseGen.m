function [x,t,N] = myNoiseGen(dist, dt,te)

%Initialisieren der R?ckgabe-Parameter
t=[];
x=[];
N=[];

%Zeitvektor
if te<=0
    error ('signaldauer zu klein')
elseif dt>te
    error ('schrittweite grosser als signaldauer')
end
N=te/dt;
t=0:dt:(N-1)*dt;

%signal 
if dist=='g'
    x=rand(1,length(t))
else
    if dist == 'n'
        x=randn(1,length(t))
    else
        error('Unbekannter Signal')
    end
end
    
end

