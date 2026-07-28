%% 120W Buck Converter Design 
clc, clear, close all;
%% Design Parameter
Vin = 24;           % Input Voltage (V)
Vout = 12;          % Output Voltage (V)
Pout = 100;         % Output Power (W)
Fs = 62.5e3;         % Switching Frequency (Hz)
ripple_current_rate = 0.3; % 30% ripple current
ripple_voltage_rate = 0.01; % 1% ripple voltage
%% 1. Duty Cycle (D)
D = Vout / Vin;
%% 2. Output Current (Iout)
Iout = Pout / Vout;
%% 3. Output Resistance (Rout)
Rout = Vout / Iout;
%% 4. Ripple Current (ΔI_L)
delta_I_L = ripple_current_rate * Iout;
I_L_max = Iout + delta_I_L / 2;
I_L_min = Iout - delta_I_L / 2;
%% 5. Inductor (L)
L = (Vout * (Vin - Vout)) / (Vin * Fs * delta_I_L);
L_standard = ceil(L / 1e-6); % Round to nearest standard value (µH)
%% 6. Ripple Voltage (ΔVout)
delta_Vout = ripple_voltage_rate * Vout;
%% 7. Output Capacitor (C)
C = (delta_I_L * D) / (8 * Fs * delta_Vout);
C_standard = ceil(C / 1e-6); % Round to nearest standard value (µF)