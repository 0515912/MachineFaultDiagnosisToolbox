% ��ͨ�˲���
% x ԭʼ�ź�
% fs ����Ƶ��
% lf ��ͨ��ֹ
% hf ��ͨ��ֹ
function [xx] = mybpf(x,fs,lf,hf)
N = length(x);
len=N;
F = fft(x);
L = round(lf/fs*len);
H = round(hf/fs*len);
%dd = len-cc;
F(1:L)=0;
F(N-L+2:N)=0;
F(H:N-H+2)=0;

aa =F;
xx = ifft(aa);
end