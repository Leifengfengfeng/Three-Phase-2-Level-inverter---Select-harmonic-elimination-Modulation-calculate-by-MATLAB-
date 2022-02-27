


clear;
Modulation=0:0.001:4/pi;% ���õ��ƶȷ�Χ
alpha11 = zeros(length(Modulation),1);%��ʼ������
global M;
M = 0.01;

for ii = 1:length(Modulation)
M = Modulation(ii);
x = fsolve(@Um_B,60*pi/180);
alpha11(ii,1) = x(1);
end

alpha1 = alpha11*180/pi;
plot(Modulation,alpha1);
hold on;
ylim([0 90]);
grid on;
xlabel('���Ʊ�');
ylabel('���ؽǶ�');

function Umn = Um_A(alpha)
global M;

Umn = (1-2*(cos(alpha)))*(4/pi) - M;
end

function Umn = Um_B(alpha)
global M;

Umn = -(1-2*(cos(alpha)))*(4/pi) - M;
end