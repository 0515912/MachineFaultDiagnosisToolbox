% -------------------------------------------------------------------------
%                         Demo : Wiener Filter
%--------------------------------------------------------------------------
%-------------------------------------------------------------------------%
clear;
close all;
clc;
pos = [200   200   1000  500];
% -------------------Simulation signal generation--------------------------
fs = 1000;
t = 0:1/fs:5-1/fs;
% x1 Ϊ�źż�����
x1 = cos(2*pi*10*t)+0.2*randn(size(t));
noise = 0.2*randn(1,fs);
% �����ź�xǰ1��Ϊ����������Ϊ��Ҫ������ź�
x = [noise x1];
N = length(x);
t = 0:1/fs:(N-1)/fs;

%---------------------------------Main-------------------------------------%
output=WienerScalart96(x,fs,0.5);
%--------------------------------Result------------------------------------%
% Original waveform
figure
plot(t,x)

% De-noised signal
hold on
plot(0:1/fs:(length(output)-1)/fs,output)
legend('Original signal','De-noised signal');

xlabel('Time (s)')
ylabel('Magnitude')
setfontsize(14);
set(gcf,'pos',pos);

