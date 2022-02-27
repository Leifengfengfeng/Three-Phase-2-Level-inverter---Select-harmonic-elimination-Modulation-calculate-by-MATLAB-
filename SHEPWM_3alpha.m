clear;
opt = optimset('display','off');
Modulation=0:0.001:4/pi;% 设置调制度范围
alpha = zeros(length(Modulation),2);%初始化矩阵
global M;
global EH;
EH = [5,7];
M = 0.01;
alpha00(1,1) = 2*pi/180;
alpha00(1,2)= 59.9999999999898*pi/180;
alpha00(1,3) = 90.0000000000099*pi/180;
for ii = 1:length(Modulation)
M = Modulation(ii);
x = fsolve(@harmonic_equations_B,alpha00,opt);
alpha(ii,1) = x(1)*180/pi;
alpha(ii,2) = x(2)*180/pi;
alpha(ii,3) = x(3)*180/pi;
end
plot(Modulation,alpha);
hold on;
ylim([0 90]);
grid on;
xlabel('调制比');
ylabel('开关角度');

function y = harmonic_equations_A(alpha)
global M;
global EH;
y = [Um_A(alpha,1)*(4/pi) - M;
     Um_A(alpha,EH(1));
     Um_A(alpha,EH(2))];
end

function Umn = Um_A(alpha,n)
Umn = (1-2*(cos(n*alpha(1))-cos(n*alpha(2))+cos(n*alpha(3))));
end

function y = harmonic_equations_B(alpha)
global M;
global EH;
y = [Um_B(alpha,1)*(4/pi) - M;
     Um_B(alpha,EH(1));
     Um_B(alpha,EH(2))];
end

function Umn = Um_B(alpha,n)
Umn = (-1+2*(cos(n*alpha(1))-cos(n*alpha(2))+cos(n*alpha(3))));
end