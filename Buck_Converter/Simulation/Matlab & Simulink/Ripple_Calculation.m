clc, clear, close all
%% Parameters of buck converter
C = 100e-6;%Capacitor [F]
L = 100e-6;%Inductor [H]
Vi = 12;%Input Voltage [V]
Vo = 5;%Output Voltage [V]
Io = 1;%Output Current [A]
f = 100e3;%Switching frequency
R = 2.5; %Load resistor
r = 0.01;%Internal resistor
%% Formular of buck converter
D = Vo/Vi;%Duty cycle [%]
dIo = (Vi - Vo)*D/(L*f);%Inductor ripple current
dVo = (1 -D)/(8*L*C*f^2);%Capacitor ripple current
dImax =  Io + (dIo/2);%Maximum ripple current
dImin = Io - (dIo/2);%Minimun ripple current
Lmin = (Vi-Vo)*D/(dImin*f);%Inductor[H]
%% Buck Transfer Function
s = tf('s');
Buck_TF2 = ((Vi/(L*C))*(1+(s*C*r)))/((s^2)+(s*((r/L)+(1/(R*C))))+(1/(L*C)))
%% PID Design
%Gc = pidTuner(Buck_TF2); % PID Tuner
kp = 0.00062;%Kp Gain
ki = 15.41;%Ki Gain
Gc = kp + ki/s; %PID method
Gcl=feedback(Gc*Buck_TF2,1);%Feedback
step(5*Gcl);%Step repones
hold on;
%% Digital Control
Ts = 1e-3; % 2ms
Z = tf( 'z' ,Ts);
gc_dig_tustin = c2d(Gc ,Ts , 'tustin' )
gps_dig_tustin = c2d(Buck_TF2 ,Ts , 'tustin' );
Gcl_dig_tustin=feedback(gc_dig_tustin*gps_dig_tustin,1);
step(5*Gcl_dig_tustin);
grid on
xlim([0, 0.050]);
ylim([0, 5.5]);