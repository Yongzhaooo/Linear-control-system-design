clear all;clf

rho = [0:0.1:10];

q=sqrt(64+(4-3*rho).^2);

K=(4-3*rho+q)./(8+10*rho+2*q);

plot(rho,K)
xlabel('\it\rho = R_2 / R_1')
ylabel('\itK')

pause

rho = 10;
q=sqrt(64+(4-3*rho).^2);
K=(4-3*rho+q)./(8+10*rho+2*q);

N  = 100;   % Number of samples
R1 = 0.05;
v1 = sqrt(R1)*randn(1,N);
v2 = sqrt(rho*R1)*randn(1,N);
x = zeros(size(v1));
xe = zeros(size(x));
yMA = zeros(size(x))
u1  = randn(1,N/10);
for i=1:N/10;
    for j=1:10
        u(10*(i-1)+j)=u1(i);
    end
end

for k=1:length(u)-1
     x(k+1)  = 0.5*x(k) + u(k) + v1(k);
     y(k)    = x(k) + v2(k);
     xe(k+1) = 0.5*xe(k) + u(k) + K*(y(k)-xe(k));
     if k==1; yMA(k)=y(k); end
     if k==2; yMA(k)=0.5*y(k)+0.5*y(k-1); end
     if k==3; yMA(k)=(1/3)*(y(k)+y(k-1)+y(k-2)); end
     if k==4; yMA(k)=(1/4)*(y(k)+y(k-1)+y(k-2)+y(k-3)); end
     if k>4
         yMA(k)=(1/5)*(y(k)+y(k-1)+y(k-2)+y(k-3)+y(k-4)); end
end
y(k+1) = x(k+1) + v2(k+1)
 
t = [0:1:length(y)-1];
subplot(211)
    plot(t,u,t,u+v1)
    legend('u','u+v1','NorthEast')
    xlabel('k')
subplot(212)
    plot(t,y,'.',t,x,'b',t,xe,'r-',t,yMA,'g-.')
    legend('x + v_2','x','x_{est}','y_{MA5}','NorthEast')
    xlabel('k')
