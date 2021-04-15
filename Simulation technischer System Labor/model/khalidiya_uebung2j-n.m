
%j)
st1=rand(1,N);
stn=2*(st1-0.5);
st=As*stn;
figure
plot(t,st,t,yt)


%k) 
yst= yt+st;
hold on
plot(t,yst,'m');


%l)
rst=A*(yst>S);
plot(t,rst,'r',t,Kt,'k')
legend('\its(t)','\ity(t)','\ity_s(t)','\itr_s(t)')
xlabel('{\itt/s}')


%m) 
figure
subplot(2,2,1)
plot(t,yt,'r')
hold on
stem(t,yt)

xlabel('{\itt/s}')
ylabel('\ity(t)')
title('Dreieck-Signal')
subplot(2,2,2)
plot(t,yst,'r')

xlabel('{\itt/s}')
ylabel('\ity_s(t)')
title('gestörtes Dreieck-Signal')
subplot(2,2,3)
plot(t,yt,t,rt,'r',t,Kt,'k')

xlabel('{\itt/s}')
ylabel('\ity(t),r(t)')
title('Rechteck-Impulssignal')
subplot(2,2,4)
plot(t,yst,t,rst,'r',t,Kt,'k')

xlabel('{\itt/s}')
ylabel('\ity_s(t),r_s(t)')
title('Rechteck-Impulssignal')


%n)Verändern Sie nun die verschiedenen Parameter nach der angegebenen Tabelle
% Kommentieren Sie die Veränderungen gegenüber den vorhergehenden Bildern 
%   N0    S           As
%   50    9/10*A      A/20
%    5    9/10*A      A/20 
%   50     3/5*A      A/20 
%   50     1/5*A      A/20 
%   50    9/10*A      A/10
%   50    9/10*A      A/2
%




