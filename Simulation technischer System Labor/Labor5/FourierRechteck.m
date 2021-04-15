function [xNt]= FourierRechteck(t,f0,A,N)

xNt=[];
xN=(4*A/pi)
x=0
for n=1:N+1
    x=x+(1/((2*n)-1)*sin(2*pi*((2*n)-1)*f0*t));
    
end
xNt=xN.*x
end

