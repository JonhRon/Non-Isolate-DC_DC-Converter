%% Buck Converter 120W Design
clc, clear, close all
%% Buck Parameters
Vi = 40;%Input Voltage[V]
Vo = 30;%Ouput Voltage[V]
Po = 120;%Power Ouput[W]
f = 62.5e3;%Frequency[Hz]    
dV = 0.1/100.0;%Voltage Ripple Rate[V]
di = 40/100.0;%Current Ripple Rate[A]
%% Buck Formular
Io = Po/Vo;% Ouput Current[A]
R = Vo/Io;%Load Resistor[ohm]
D = Vo/Vi;%Duty Cycle[%]
dVo = dV*Vo;%Ripple Voltage[V]
dIo = di*Io;%Ripple Current[V]
Imax = Io + (dIo/2);% Maximum Output Current
Imin = Io - (dIo/2);% Minimum Output Current
L = (Vi-Vo)*D/(dIo*f);%Inductor[H] 
C = (1-D)/(8*L*dVo*f^2);%Capacitor[F]
r = 1e-3;%Component Resistor
%% Parameters Selection
Cs = 100e-6;%Capacitor selection
Ls = 100e-6;%Inductor selection
dI_o = (Vi - Vo)*D/(Ls*f);%Inductor ripple current
dV_o = (1 -D)/(8*Ls*Cs*f^2);%Capacitor ripple current
dI_max =  Io + (dI_o/2);%Maximum ripple current
dI_min = Io - (dI_o/2);%Minimun ripple current
L_min = (Vi-Vo)*D/(dI_min*f);%Inductor[H]
%% Buck Transfer Function
s = tf('s');
Buck_TF = ((Vi/(Ls*Cs))*(1+(s*Cs*r)))/((s^2)+(s*((r/Ls)+(1/(R*Cs))))+(1/(L*Cs)))
%% Buck PID Conntroller
%Gc = pidTuner(Buck_TF2); % PID Tuner
kp = 0.00062;%Kp Gain
ki = 15.41;%Ki Gain
Gc = kp + ki/s; %PID method
Gcl=feedback(Gc*Buck_TF,1);%Feedback
step(5*Gcl);%Step repones
hold on;
%% Buck Digital Control
Ts = 1e-3; % 2ms
Z = tf( 'z' ,Ts);
gc_dig_tustin = c2d(Gc ,Ts , 'tustin' )
gps_dig_tustin = c2d(Buck_TF ,Ts , 'tustin' );
Gcl_dig_tustin=feedback(gc_dig_tustin*gps_dig_tustin,1);
step(5*Gcl_dig_tustin);
grid on
xlim([0, 0.050]);
ylim([0, 5.5]);