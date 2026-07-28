%%MATLAB Script for Boost Converter Design in Continuous Conduction Mode (CCM)
clc,clear;
%% Input Parameters
Vin = 24; % Input Voltage (V)
Vout = 48; % Output Voltage (V)
fsw = 100e3; % Switching Frequency (Hz)
Pout = 100; % Output Power (W)
RippleCurrentRated = 0.3; % Ripple Current Rated (30% of average inductor current)
RippleVoltageRated = 0.01; % Ripple Voltage Rated (1% of output voltage)
%% Step-by-Step Calculations
% Step 1: Calculate Duty Cycle (D)
D = 1 - (Vin / Vout);
% Step 2: Calculate Output Current (Iout)
Iout = Pout / Vout;
% Step 3: Calculate Load Resistance (Rload)
Rload = Vout / Iout;
% Step 4: Calculate Ripple Output Voltage (DeltaVout)
DeltaVout = RippleVoltageRated * Vout;
% Step 5: Calculate Inductor Value (L)
IL = Iout / (1 - D); % Average Inductor Current
DeltaIL = RippleCurrentRated * IL; % Ripple Current
L = (Vin * D) / (fsw * DeltaIL); % Inductance in Henries
% Step 6: Calculate Maximum and Minimum Inductor Currents
ILmax = IL + DeltaIL / 2; % Maximum Inductor Current
ILmin = IL - DeltaIL / 2; % Minimum Inductor Current
C = (Iout * D) / (fsw * DeltaVout); % Capacitance in Farads