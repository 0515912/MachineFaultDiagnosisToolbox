% ��г���ź�ģ����
% fs-----�źŵĲ���Ƶ�ʣ�Hz
% phs----�źŵ�˲ʱ��λ����
% m------����ϵͳ��������ǧ��
% c------����ϵͳ�����ᣬN/(m/s)
% k------����ϵͳ�ĸնȣ�N/m
% ang----���ϵĽǶȼ��
% gain---��Ӧ�źŵķ�ֵ����
% fault_type --�������ͣ��ַ����ͣ���Ϊ��'none'��'inner'��'outer','rolling','rand_impact'


function imp = imp_gen(fs,phs,m,c,k,ang,gain,fault_type)

% ���û�й��ϣ�ֱ������
if strcmp(fault_type,'none')
    imp = 0*phs;
    return
end

N = length(phs);
    
% �������Ĺ���Ƶ��   
fc = (k/m)^0.5/2/pi;
fd = fc*(1-(c/2/m/fc/2/pi)^2)^0.5;
% disp(['-----------------------------------------']);
% disp([fault_type, '���Ϲ���Ƶ��']);
% disp(['���������Ƶ�ʣ� ',num2str(fc),' Hz' ]);
% disp(['���������Ƶ�ʣ� ',int2str(fd),' Hz' ]);
% disp(['-----------------------------------------']);

% �������źŵĳ���(�����źŵ�˥����ȷ�����ɲο�����ѧ)
pn = round(20*m/c*fs);
temp = gain*impulse(tf(1,[m,c,k]),(0:pn-1)/fs);
imp = zeros(size(phs));


if strcmp(fault_type,'rand_impact')

    % ���������������Ĵ���
    N_impact = 3;
    
    % ���ѡȡ������������
    index = round(rand(1,N_impact)*(N-pn-1)); 
    
    % �ɵ͵�������
    index = sort(index);
    
    for i =1:N_impact
       % ����ŵ�λ�ü����� 
       imp(index(i):index(i)+pn-1) =  imp(index(i):index(i)+pn-1)+(0.5+rand(1)/2)*gain*temp;
        
    end
        
    return
end


% ���Ƕȼ����ʱ���ź�����ӳ��
for i = 1:N-pn
    if round(phs(i+1)/ang)>round(phs(i)/ang)
        imp(i:i+pn-1) =  imp(i:i+pn-1)+temp;
    end
end


% �Գ�����н��з�ֵ���ԣ�ģ�⴫��·���仯���غɱ仯����Ȧ���ϵ�Ӱ��
if strcmp(fault_type,'inner')
    am = 0.5*(1-1*cos(phs/180*pi));
elseif strcmp(fault_type,'outer')
    am = ones(size(imp));
elseif strcmp(fault_type,'rolling')
    am = ones(size(imp));
end
imp = imp.*am;

end