% Buck Converter Power Stage Design
clc;
clear;
close all;
% Given Parameters
Vin = 30;           % Input Voltage (V)
Vout = 24;          % Output Voltage (V)
Pout = 120;         % Output Power (W)
Fs = 100e3;         % Switching Frequency (Hz)
ripple_current_rate = 0.3; % 30% ripple current
ripple_voltage_rate = 0.01; % 1% ripple voltage

%% 1. Duty Cycle (D)
D = Vout / Vin;
fprintf('1. Duty Cycle (D): %.2f (80%%)\n', D);

%% 2. Output Current (Iout)
Iout = Pout / Vout;
fprintf('2. Output Current (Iout): %.1f A\n', Iout);

%% 3. Output Resistance (Rout)
Rout = Vout / Iout;
fprintf('3. Output Resistance (Rout): %.1f Ohms\n', Rout);

%% 4. Ripple Current (ΔI_L)
delta_I_L = ripple_current_rate * Iout;
I_L_max = Iout + delta_I_L / 2;
I_L_min = Iout - delta_I_L / 2;
fprintf('4. Ripple Current (ΔI_L): %.1f A (peak-to-peak)\n', delta_I_L);
fprintf('   - Maximum Inductor Current (I_L_max): %.2f A\n', I_L_max);
fprintf('   - Minimum Inductor Current (I_L_min): %.2f A\n', I_L_min);

%% 5. Inductor (L)
L = (Vout * (Vin - Vout)) / (Vin * Fs * delta_I_L);
L_standard = ceil(L / 1e-6); % Round to nearest standard value (µH)
fprintf('5. Inductor (L): %.0f µH (Standard Value: %d µH)\n', L*1e6, L_standard);

%% 6. Ripple Voltage (ΔVout)
delta_Vout = ripple_voltage_rate * Vout;
fprintf('6. Ripple Voltage (ΔVout): %.2f V\n', delta_Vout);

%% 7. Output Capacitor (C)
C = (delta_I_L * D) / (8 * Fs * delta_Vout);
C_standard = ceil(C / 1e-6); % Round to nearest standard value (µF)
fprintf('7. Output Capacitor (C): %.2f µF (Standard Value: %d µF)\n', C*1e6, C_standard);

%% 8. MOSFET Selection
V_mosfet = Vin * 1.5; % 50% margin
I_mosfet = I_L_max * 1.5; % 50% margin
fprintf('8. MOSFET Requirements:\n');
fprintf('   - Voltage Rating: > %.0f V (Recommended: 50 V)\n', V_mosfet);
fprintf('   - Current Rating: > %.2f A (Recommended: 10 A)\n', I_mosfet);
fprintf('   - Example: IRF540N (50 V, 22 A)\n');

%% 9. Diode Selection
V_diode = Vin * 1.3; % 30% margin
I_diode = I_L_max * 1.5; % 50% margin
fprintf('9. Diode Requirements:\n');
fprintf('   - Voltage Rating: > %.0f V (Recommended: 40 V)\n', V_diode);
fprintf('   - Current Rating: > %.2f A (Recommended: 10 A)\n', I_diode);
fprintf('   - Example: SB1045 (40 V, 10 A Schottky)\n');

%% Component Summary
fprintf('\nComponent Summary:\n');
fprintf('--------------------------------------------------\n');
fprintf('Inductor: %d µH (Saturation Current > %.2f A)\n', L_standard, I_L_max);
fprintf('Capacitor: %d µF (%d V, Low ESR)\n', C_standard, Vout * 1.5);
fprintf('MOSFET: 50 V, 10 A (e.g., IRF540N)\n');
fprintf('Diode: 40 V, 10 A Schottky (e.g., SB1045)\n');