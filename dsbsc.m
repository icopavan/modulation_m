clear
echo on
t0=2;                         %信号持续时间
ts=0.001;                    %信号抽样间隔
fc=100;                       %载波频率
fs=1/ts;                      
df=0.3;                      %频率分辨力
t=[-t0/2:ts:t0/2];           %定义时间序列 
%以下三句为定义信号序列
x=sin(200*t);                
m=x./(200*t);
m(1001)=1;                     %避免产生无穷大的值
c=cos(2*pi*fc.*t);             %载波
u=m.*c;                        %抑制载波调制
[M,m,df1]=fftseq(m,ts,df);      %傅利叶变换
M=M/fs;
[U,u,df1]=fftseq(u,ts,df);      %傅利叶变换
U=U/fs;                         %频率压缩     
f=[0:df1:df1*(length(m)-1)]-fs/2;
pause
clf
subplot(2,2,1)
plot(t,m(1:length(t)))             %做出未调信号的波形
axis([-0.4,0.4,-0.5,1.1])
xlabel('时间');
title('未调信号');
pause;                          %暂停程序，待按键后继续执行
subplot(2,2,3)                  
plot(t,c(1:length(t)))
axis([-0.1,0.1,-1.5,1.5]);
xlabel('时间');
title('载波');
pause
subplot(2,2,2)
plot(t,u(1:length(t)))
axis([-0.2,0.2,-1,1.2]);
xlabel('时间')
title('已调信号');
pause
subplot(2,1,1)
plot(f,abs(fftshift(M)))
xlabel('频率');
title('未调信号的频谱')
subplot(2,1,2)
plot(f,abs(fftshift(U)))
title('已调信号的频谱');
xlabel('频率')