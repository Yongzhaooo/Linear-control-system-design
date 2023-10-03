% Continuous time state space model for reactor where A+B -> C
clear all
A = [-5 -1; -1 -5]
B = eye(2)
C = eye(2)
D = zeros(2,2)
sysc = ss(A,B,C,D);

% Discretize
h = 0.01
sysd  = c2d(sysc,h)
Ad = sysd.a
Bd = sysd.b
C  = sysd.c
D  = sysd.d
N  = eye(2)
% Check controllability and observability
S       = ctrb(Ad,Bd)
kappa_c = cond(S)
O       = obsv(Ad,C)
kappa_o = cond(O)

% Time discrete white noise
R1  = diag([0.1 0.05]);%R1=0.1*eye(2)
R12 = zeros(2)
R2  = 0.1*eye(2)

% Kalman filter
[K,P,Z,E] = dlqe(Ad,N,C,R1,R2)

Qx = [1 0;0 1]
%Qu = 0.1*[1 0;0 1]
Qu = 100*Bd'*inv(R1)*Bd

% LQ solution
[L,S,Lambda] = lqr(sysd,Qx,Qu,0)

% Reference feed forward
K_FF = inv(C*inv(eye(2)-Ad+Bd*L)*Bd)
sim('LQG_2by2_2workspace')


Variances = var(x)
I=find(tout<10);
subplot(311), plot(tout(I),x(I,1),'b',tout(I),xhat(I,1),'g',tout(I),r(I,1),'r') 
    ylabel('x_1, r_1 and x_{e1}')
    title(['Var(x_1)=',num2str(Variances(1)),'    and    Var(x_2)=',num2str(Variances(2))])
    axis([0 max(tout(I)) -5 5])
subplot(312), plot(tout(I),x(I,2),'b',tout(I),xhat(I,2),'g',tout(I),r(I,2),'r')
    ylabel('x_2')
    ylabel('x_2, r and x_{e2}')
    axis([0 max(tout(I)) -5 5])
subplot(313), plot(tout(I),u(I,1),'b',tout(I),u(I,2),'g'), ylabel('u')
    xlabel('time')
    axis([0 max(tout(I)) min(min(u(I,:)))*1.1 max(max(u(I,:)))*1.1])
    axis([0 max(tout(I)) -15 15])



