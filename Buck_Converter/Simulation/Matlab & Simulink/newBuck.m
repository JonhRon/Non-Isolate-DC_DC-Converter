clc, clear
%% Prameter of Buck Converter
Vi = 30;%Input Voltage[V]
Vo = 24;%Ouput Voltage[V]
Po = 120;%Power Ouput[W]
f = 100e3;%Frequency[Hz]    
dV = 0.1/100.0;%Voltage Ripple Rate[V]
di = 30/100.0;%Current Ripple Rate[A]
%% Formular Of Buck Converter
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
%% Transfer Function for Buck Converter
s = tf('s');
Buck_TF1 = (Vi/(L*C)*(1+(s*C*r)))/((s^2)+(s*((r/L)+(1/(R*C))))+(1/(L*C)))