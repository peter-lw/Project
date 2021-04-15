% STS, Fb. EIT, Hochschule Darmstadt
%Übung 5 
%Stand: 11.09.2012
%d)
function [xNt]=FourierRechteck(t,f0,A,N)
%Berechnung der Fourierreihe bis zur N-ten Oberwelle        
xNt=0;
for n=1:N+1
   xNt= xNt+(1/(2*n-1))*sin(2*pi*(2*n-1)*f0*t);
end
xNt= 4*A/pi*xNt;

% Zusatzaufgabe
% oder mit Hilfe der Matrix-Operationen
% i ist 1xN Zeilenvektor
% 2*pi*(2*i'-1)*f erzeugt einen Nx1 Spaltenvektor, der das 1.,3.,5.,...
% Vielfache der Keisfrequenz omega enthält
% wird das Ergebnis mit t mittels Matrix-Operation multipliziert, 
% erhält man eine Nx(size(t))-Matrix, deren Zeilen den Parameter-
% Vektor 2*pi*(2*i'-1)*f*t für eine Harmonische enthält
% n=1:N+1;
% xNt=4*A/pi*1./(2*n-1)*sin(2*pi*(2*n'-1)*f*t);
