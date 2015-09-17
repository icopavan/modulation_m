close all;
clear all;
dt=0.001;
fm=1;
fc=10;
T=5;
t=0:dt:T;
mt=sqrt(2)*(cos(2*pi*fm*t)+sin(2*pi*0.5*fm*t));
%VSB modulation
s_vsb=mt.*cos(2*pi*fc*t);
B=1.2*fm;
[f,sf]=T2F(t,s_vsb);
[t,s_vsb]=vsbpf(f,sf,0.2*fm,1.2*fm,fc);
figure(1)
subplot(311)
plot(t,s_vsb);hold on;
plot(t,mt,'r--');
title('VSB调制信号');
xlabel('t');
%VSB demodulation
rt=s_vsb.*cos(2*pi*fc*t);
[f,rf]=T2F(t,rt);
[t,rt]=lpf(f,rf,2*fm);
subplot(312)
plot(t,rt);hold on;
plot(t,mt/2,'r--')
title('相干解调后的信号波形与输入信号的比较')
xlabel('t')
subplot(313)
[f,sf]=T2F(t,s_vsb);
psf=(abs(sf).^2)/T;
plot(f,psf);
axis([-2*fc 2*fc 0 max(psf)]);
title('VSB信号功率谱');
xlabel('f');
