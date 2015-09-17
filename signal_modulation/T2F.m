function[f,sf]=T2F(t,st)    %计算信号的傅里叶变换
% this is a function using the FFT function to calculation a single's 
%Fourier translation 
%input is the time and the signal vectors,the length of the time must
%greater than 2;Output is the frequency and the signal spectrum
dt=t(2)-t(1);
T=t(end);
df=1/T;
N=length(st);
f=-N/2*df:df:N/2*df-df;
sf=fft(st);
sf=T/N*fftshift(sf);
