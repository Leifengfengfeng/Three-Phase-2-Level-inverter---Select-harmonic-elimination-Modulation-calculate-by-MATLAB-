clear;
opt = optimset('display','off');
Modulation=0:0.001:1.27;% ���õ��ƶȷ�Χ
alpha = zeros(length(Modulation),2);%��ʼ������
global M;
global EH;
EH = [5,7,11,13];
M = 0.01;
alpha00(1,1) = 0.00133222137466374*pi/180;%Max voltage is 1.152, positive
alpha00(1,2) = 18.7123758384981*pi/180;
alpha00(1,3) = 41.2876241615030*pi/180;
alpha00(1,4) = 60.0000000000021*pi/180;
alpha00(1,5) = 78.7123758384933*pi/180;

        
%         alpha00(1,1)=3*pi/180;%Max voltage is 1.169, negative
%         alpha00(1,2)=21*pi/180; 
%         alpha00(1,3)=39*pi/180; 
%         alpha00(1,4)=61*pi/180;
%         alpha00(1,5)=79*pi/180;

for ii = 1:length(Modulation)
M = Modulation(ii);
x = fsolve(@harmonic_equations_A,alpha00,opt);
alpha(ii,1) = x(1)*180/pi;
alpha(ii,2) = x(2)*180/pi;
alpha(ii,3) = x(3)*180/pi;
alpha(ii,4) = x(4)*180/pi;
alpha(ii,5) = x(5)*180/pi;
end
plot(Modulation,alpha);
hold on;
ylim([0 90]);
grid on;
xlabel('���Ʊ�');
ylabel('���ؽǶ�');

function y = harmonic_equations_A(alpha)
global M;
global EH;
y = [Um_A(alpha,1)*(4/pi) - M;
     Um_A(alpha,EH(1));
     Um_A(alpha,EH(2));
     Um_A(alpha,EH(3));
     Um_A(alpha,EH(4))];
end

function Umn = Um_A(alpha,n)
Umn = (1-2*(cos(n*alpha(1))-cos(n*alpha(2))+cos(n*alpha(3))-cos(n*alpha(4))+cos(n*alpha(5))));
end

function y = harmonic_equations_B(alpha)
global M;
global EH;
y = [Um_B(alpha,1)*(4/pi) - M;
     Um_B(alpha,EH(1));
     Um_B(alpha,EH(2));
     Um_B(alpha,EH(3));
      Um_B(alpha,EH(4))];
end

function Umn = Um_B(alpha,n)
Umn = (-1+2*(cos(n*alpha(1))-cos(n*alpha(2))+cos(n*alpha(3))-cos(n*alpha(4))+cos(n*alpha(5))));
end