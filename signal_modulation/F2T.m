function [t,st]=F2T(f,sf)
%this function calculate the time signal using ifft function for the input
%signal's spectrum
df=f(2)-f(1);
Fmax=(f(end)-f(1)+df);
dt=1/Fmax;
N=length(sf);
T=dt*N;
t=0:dt:T-dt;
sff=fftshift(sf);
st=Fmax*ifft(sff);