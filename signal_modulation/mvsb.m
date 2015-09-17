 close all;
 clear all;
 dt=0.001;
 fm=5;
 fc=20;fs=20;fsc=80;
 T=5;
 t=0:dt:T;
 mt=sqrt(2)*(cos(2*pi*fm*t)+sin(2*pi*0.5*fm*t));
 %vsb modulation
 s_vsb=mt.*cos(2*pi*fc*t);
 B=1.2*fm;
 [f,sf]=T2F(t,s_vsb);
 [t,s_vsb]=vsbpf(f,sf,0.2*fm,1.2*fm,fc);
 figure(1)
 subplot(311)
 plot(t,s_vsb);hold on;
 plot(t,mt,'r--');
 title('vsb调制信号');
 xlabel('t');
 %vsb demodulation
 rt=s_vsb.*cos(2*pi*fc*t);
 [f,rf]=T2F(t,rt);
 [t,rt]=lpf(f,rf,2*fm);
 subplot(312)
 plot(t,rt);hold on;
 plot(t,mt/2,'r--');
 title('相干解调后的信号波形与输入信号的比较');
 xlabel('t')
 subplot(313)
 [f,sf]=T2F(t,s_vsb);
 psf=(abs(sf).^2)/T;
 plot(f,psf);
 axis([-2*fc 2*fc 0 max(psf)])
 title('vsb信号功率谱')
 xlabel('f')
 
 
 N=3072;    %数据长度
M=64;        %频率平滑长度
figure(3);
K=round(2.5*N*fc/fsc);          %频率轴
alfa=round(2.5*N*fc/fsc);
G1=pxg(s_vsb,N,M,K,alfa,fs);
p=(-K:32:K)*fsc/N;
q=(-alfa:32:alfa)*2*fsc/N;
mesh(p,q,abs(G1));