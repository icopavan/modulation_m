close all;
clear all;
dt=0.001;  %时间采样间隔            
fm=1;       %信号最高频率
%fs=32;       %信号采样频率   
fc=2.5;      %载波频率
T=5;        %信号时长
t=0:dt:T;   %时间间隔
%fsc=40;     %载波采样频率
mt=sqrt(2)*cos(2*pi*fm*t);
%N0=0.01;
%DSB modulation 
s_dsb=mt.*cos(2*pi*fc*t);
B=2*fm;
figure(2)
subplot(311)
plot(t,s_dsb);hold on;
plot(t,mt,'r--');title('DSB调制信号');
xlabel('t')
%DSB demodulation
rt=s_dsb.*cos(2*pi*fc*t);
rt=rt-mean(rt);
[f,rf]=T2F(t,rt);
[t,rt]=lpf(f,rf,B);
subplot(312)
plot(t,rt);hold on;
plot(t,mt/2,'r--');
title('相干解调后的信号波形与输入信号的比较')
xlabel('t')
subplot(313)
[f,sf]=T2F(t,s_dsb);
psf=(abs(sf).^2)/T;
plot(f,psf);
axis([-2*fc 2*fc 0 max(psf)]);
title('DSB信号功率谱')
xlabel('f');grid



