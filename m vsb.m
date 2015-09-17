close all;
clear all; %清楚历史记录
dt=0.001; %时间采样间隔
fm=5; %信源最高频率
fc=20; %载波中心频率
T=5;  %信号时长
t=0:dt:T;
mt=sqrt(2)*(cos(2*pi*fm*t)+sin(2*pi*0.5*fm*t));
%VSB modulation  %残留边带调幅调整
s_vsb=mt.*cos(2*pi*fc*t);
B=1.2*fm;  %带通滤波器带宽
[f,sf]=T2F(t,s_vsb);
[t,s_vsb]=vsbpf(f,sf,0.2*fm,1.2*fm,fc);
figure(1)  %生成第一个图
subplot(311)  %画第一个图，以3行1列排列取第一个
plot(t,s_vsb);hold on; %画出VSB信号波形
plot(t,mt,'r--');  %标示mt的波形
title('VSB调制信号');%标题
xlabel('t'); %X轴的名为t
%VSB demodulation
rt=s_vsb.*cos(2*pi*fc*t);
[f,rf]=T2F(t,rt);  %时域变频域，傅立叶变换
[t,rt]=lpf(f,rf,2*fm);%相干解调后，低通滤波
subplot(312)  %创建子图
plot(t,rt);hold on; %画出波形
plot(t,mt/2,'r--') %表示mt/2的信号波形，画频谱图
title('相干解调后的信号波形与输入信号的比较')
xlabel('t') %横坐标为时间
subplot(313) %画第三个以3行1列的图
[f,sf]=T2F(t,s_vsb); %求调制信号的功率频谱图（傅立叶变换）
psf=(abs(sf).^2)/T; %画psf波形
plot(f,psf);
axis([-2*fc 2*fc 0 max(psf)]);
title('VSB信号功率谱');
xlabel('f');
function[t,st]=vsbpf(f,sf,B1,B2,fc)
%This function filter an input data using a lowpass filter
%Inputs:f:frequency samples
%       sf:input data spectrum samples
%       B:lowpass's bandwidth with a rectangle lowpass
%Outputs:t:time samples
%        st:output data's time samples
df=f(2)-f(1);
T=1/df;
hf=zeros(1,length(f));
bf1=[floor((fc-B1)/df):floor((fc-B1)/df)];
bf2=[floor((fc+B1)/df)+1:floor((fc+B2)/df)];
f1=bf1+floor(length(f)/2);
f2=bf2+floor(length(f)/2);
stepf=1/length(f1);
hf(f1)=0:stepf:1-stepf;
hf(f2)=1;
f3=-bf1+floor(length(f)/2);
f4=-bf2+floor(length(f)/2);
hf(f3)=0:stepf:(1-stepf);
hf(f4)=1;
yf=hf.*sf;
[t,st]=F2T(f,yf);
st=real(st);