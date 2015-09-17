function[M,m,df]=fftseq(m,tz,df)
fz=1/tz;
if nargin==2
    n1=0;
else n1=fz/df;
end
n2=length(m);
n=2^(max(nextpow2(n1),nextpow2(n2)));
M=fft(m,n);
m=[m,zeros(1,n-n2)];
df=fz/n;