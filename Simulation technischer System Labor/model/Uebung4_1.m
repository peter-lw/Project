% STS, Fb. EIT, Hochschule Darmstadt 
%Übung 4 
%Stand: 28.08.2013
%Aufgabe 1
clear all; close all; clc
%a
t=0:1e-5:0.04;
%b
x=sin(2*pi*400*t); y=sin(2*pi*500*t);
%c
z=x.*y;
%d
n=2*0.4*(rand(1,length(z))-0.5);
zn=z+n;
%e
plot(t,zn)
xlabel('{\itt}/s')
ylabel('\itz_n(t)')