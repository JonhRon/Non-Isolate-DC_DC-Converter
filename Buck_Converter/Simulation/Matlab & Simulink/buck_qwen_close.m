%% 120W Close Loop Buck Converter
clc, clear, close all
%% Paramter for Buck Converter
Vi = 30;%Input Voltage
R = 4.8;%Load Resistance
L = 51.2e-6;%Inductance
C = 12.50e-6;%Capacitance
r = 1e-3;%Indernal Resistance
%% Buck Converter Transfer Function
s = tf('s');
Buck_120W = ((Vi/(L*C))*(1+(s*C*r)))/((s^2)+(s*((r/L)+(1/(R*C))))+(1/(L*C)))
%% PID Design
%Gc = pidTuner(Buck_TF2); % PID Tuner
kp = 0.00062;%Kp Gain
ki = 15.41;%Ki Gain
Gc = kp + ki/s; %PID method
Gcl=feedback(Gc*Buck_120W,1);%Feedback
step(24*Gcl);%Step repones
hold on;
%% Digital Control
Ts = 1e-3; % 2ms
Z = tf( 'z' ,Ts);
gc_dig_tustin = c2d(Gc ,Ts , 'tustin' )
gps_dig_tustin = c2d(Buck_120W ,Ts , 'tustin' );
Gcl_dig_tustin=feedback(gc_dig_tustin*gps_dig_tustin,1);
%step(5*Gcl_dig_tustin);
grid on
xlim([0, 0.050]);
ylim([0, 24.5]);