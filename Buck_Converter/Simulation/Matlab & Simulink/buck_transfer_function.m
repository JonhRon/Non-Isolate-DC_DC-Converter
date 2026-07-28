clc
clear
%% Parameter Of Buck Converter
Vi = 12;    %Input Voltage
Vo = 5;     %Ouput Voltage
F  = 50e3;  %Switching Frequency
dI = 0.01;  %Ripple Current
dVo = 0.01; %Ripple Voltage
n = 0.9;    %Efficiency
I = 2;      %Ouput Current
R = 2.5;    %Load
r = 1e-3;  %Component Resistor
C = 80e-6;
L = 73-6;
%% Transfer Function for Buck Converter
s = tf('s');
Gs1 = ((Vi/(L*C))*(1+(s*C*r)))/((s^2)+(s*((r/L)+(1/(R*C))))+(1/(L*C)))
H = ss(Gs1);