function[t,st]=vsbpf(f,sf,B1,B2,fc)
%本函数作为一个低通滤波器
%输入:f:频谱
%       sf:频谱
%       B1,B2:通带上下界
%		 fc:截止频率
%输出:t:时域信号
%    st:采样后的时域信号
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