clear;
opt = optimset('display','off');
Modulation=0:0.001:4/pi;
alpha = zeros(length(Modulation),2);
global M;
M = 0.01;
        alpha00(1,1) = 3*pi/180;
        alpha00(1,2) = 59*pi/180;
for ii = 1:length(Modulation)
M = Modulation(ii);
x = fsolve(@harmonic_equations_A,alpha00,opt);
alpha(ii,1) = x(1)*180/pi;
alpha(ii,2) = x(2)*180/pi;
end
plot(Modulation,alpha);
hold on;
ylim([0 90]);
grid on;
xlabel('调制比');
ylabel('开关角度');

function y = harmonic_equations_B(alpha)
global M;
y = [Um_B(alpha,1)*(4/pi) - M;
     Um_B(alpha,5)];
end
function Umn = Um_B(alpha,n)
Umn = (-1+2*(cos(n*alpha(1))-cos(n*alpha(2))));
end

function y = harmonic_equations_A(alpha)
global M;
y = [Um_A(alpha,1)-M*(pi/4);
     Um_A(alpha,5)];
end

function Umn = Um_A(alpha,n)
Umn = (1-2*(cos(n*alpha(1))-cos(n*alpha(2))));
end
