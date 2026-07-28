%% Desgin Boost Converter 120W
clc, clear, close all
%% Boost parameter
Vi = 12; %Input Voltage
Vo = 60; %Output Voltage
Io = 2; %Output Current
dI = 40/100; %Ripple Current rate
dV = 0.1/100; %Ripple Voltages rate
fs = 62.5e3; %Switching Frequency
r = 0.1; %Internal Resistor
%% Boost Power stage calculation
D = (Vo - Vi)/Vo; % Duty Cycle
Po = Vo*Io; % Output Power
RL = Vo/Io; % Output Load
dIo = Io * dI; % Output Ripple Current
dVo = Vo * dV; % Output Ripple Voltage
L = (Vi*D)/(dIo*fs); %Inductor Selection [H]
dImax = Vi/((1-D)^2*RL) + (Vi*D)/(2*L*fs); %Maximum Output Ripple Current 
dImin = Vi/((1-D)^2*RL) - (Vi*D)/(2*L*fs); %Minimun Output Ripple Current
Lmin = (D*(1-D)^2*RL)/(2*fs); %Minimum Inductor selection [H]
C = D/(RL*(dVo/Vo)*fs); %Cpacitor Selection [F]24
%% Parameter Selection
Cs = 330e-6;  %Capacitor [F]
Ls = 220e-6; %Inductor [H]
Le = Ls/(1-D)^2;
dI_o = (Vi*D)/(Ls*fs);  %Ripple Cureent [A]
dV_o = (D*Vo)/(RL*Cs*fs); %Ripple Voltage [V]
dI_max = Vi/((1-D)^2*RL) + (Vi*D)/(2*Ls*fs);
dI_min = Vi/((1-D)^2*RL) - (Vi*D)/(2*Ls*fs);
%% Boost Transfer function
s = tf('s');
Boost_TF = Vi/(1-D)^2*(1-s*Le/RL)*(1+s*r*Cs)/(Le*Cs*(s^2+s*(1/(RL*Cs)+r/Le)+1/(Le*Cs)))
%Gs = (Vout/(1-D)*(1-(s*Lmin/(Rout*(1-D)^2))))/((s^2*Lmin*C/(1-D)^2)+(s*Lmin/(Rout*(1-D)^2))+1)
%% Boost PI Controller
%c = pidTuner(Boost_TF); % PID Tuner
kp = 6.8625e-05;%Kp Gain
ki = 0.1865;%Ki Gain6.8625e-05
Gc = kp + ki/s; %PID method
Gcl=feedback(Gc*Boost_TF,1);%Feedback
step(60*Gcl);%Step repones
hold on;
%% Boost Digital Control
Ts = 1e-3; % 2ms
Z = tf( 'z' ,Ts);
gc_dig_tustin = c2d(Gc ,Ts , 'tustin' )
gps_dig_tustin = c2d(Boost_TF ,Ts , 'tustin' );
Gcl_dig_tustin=feedback(gc_dig_tustin*gps_dig_tustin,1);
step(60*Gcl_dig_tustin);
grid on
xlim([0, 0.2]);
ylim([0, 63]);