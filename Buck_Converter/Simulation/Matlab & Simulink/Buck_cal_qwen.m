%% Design 120W Buck Converter
clc, clear, close all
%% Buck Converter Design Parameters
Vin = 30;               % Input Voltage (V)
Vout = 24;              % Output Voltage (V)
Pout = 120;             % Output Power (W)
fsw = 100e3;           % Switching Frequency (Hz)
efficiency = 0.9;       % Efficiency (90%)
ripple_current_percent = 0.3; % Ripple Current as % of Iout (30%)
ripple_voltage_percent = 0.01; % Ripple Voltage as % of Vout (1%)

%% Derived Parameters
Iout = Pout / Vout;     % Output Current (A)
D = Vout / Vin;         % Duty Cycle
Iin = Pout / (efficiency * Vin); % Input Current (A)

% Inductor Design
delta_IL = ripple_current_percent * Iout; % Ripple Current (A)
L = (Vout * (Vin - Vout)) / (Vin * fsw * delta_IL); % Inductance (H)
L = L * 1e6; % Convert to microhenries (uH)

%% Core Selection (Area Product Calculation)
Isat = Iout + delta_IL / 2; % Saturation Current (A)
Bmax = 0.25;                % Maximum Flux Density (T)
Ku = 0.4;                   % Window Utilization Factor
J = 4;                      % Current Density (A/mm^2)
Ap = (L * 1e-6 * Isat^2) / (Bmax * Ku * J); % Core Area Product (cm^4)

%% Number of Turns
Ac = 30e-6;                 % Core Cross-sectional Area (m^2)
N = (L * 1e-6 * Isat) / (Bmax * Ac); % Number of Turns

%% Wire Gauge
Aw = Isat / J;              % Wire Cross-sectional Area (mm^2)

%% Air Gap
lg = (L * 1e-6 * Isat^2) / (Bmax^2 * Ac); % Air Gap Length (m)
lg = lg * 1e3; % Convert to millimeters (mm)

%% Capacitor Design
delta_VC = ripple_voltage_percent * Vout; % Ripple Voltage (V)
C = delta_IL / (8 * fsw * delta_VC);      % Capacitance (F)
C = C * 1e6; % Convert to microfarads (uF)

%% MOSFET and Diode Selection
Vds = Vin * 1.2; % MOSFET Voltage Rating (V), 20% margin
Ids = Iin * 1.5; % MOSFET Current Rating (A), 50% margin
Vr = Vin * 1.2;  % Diode Reverse Voltage Rating (V), 20% margin
If = Iout * 1.5; % Diode Forward Current Rating (A), 50% margin

%% Display Results
fprintf('--- 120W Buck Converter Design ---\n');
fprintf('Output Current (Iout): %.2f A\n', Iout);
fprintf('Duty Cycle (D): %.2f\n', D);
fprintf('Input Current (Iin): %.2f A\n', Iin);
fprintf('\n');
fprintf('--- Inductor Design ---\n');
fprintf('Inductance (L): %.2f uH\n', L);
fprintf('Core Area Product (Ap): %.2e cm^4\n', Ap);
fprintf('Number of Turns (N): %.0f turns\n', N);
fprintf('Wire Cross-sectional Area (Aw): %.2f mm^2\n', Aw);
fprintf('Air Gap (lg): %.2f mm\n', lg);
fprintf('\n');
fprintf('--- Capacitor Design ---\n');
fprintf('Capacitance (C): %.2f uF\n', C);
fprintf('\n');
fprintf('--- MOSFET Selection ---\n');
fprintf('Voltage Rating (Vds): %.2f V\n', Vds);
fprintf('Current Rating (Ids): %.2f A\n', Ids);
fprintf('\n');
fprintf('--- Diode Selection ---\n');
fprintf('Reverse Voltage Rating (Vr): %.2f V\n', Vr);
fprintf('Forward Current Rating (If): %.2f A\n', If);