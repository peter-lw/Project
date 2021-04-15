%a
function [x,t,N]= myNoiseGen(dist,dt,te)
%b)
%initialisieren der Rückgabewert
N=0;
x=[];
t=[];
%d
if dt<=1
    error('[es ist zu klein]')
elseif te<=1
    error('[es ist zu klein]')
end
    
t=0:dt:te;
N=length(t)

%e
if dist =='g'
    x=rand(1,N)
 elseif dist == 'n'
     x=randn(1,N)
     
else
    error('[es ist kein gleichverteilt oder normalverteilt]')
end

%i
