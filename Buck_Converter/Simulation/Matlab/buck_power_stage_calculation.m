% % Design 120 W Buck Converter
clc , clear , close all
% % Buck Converter Design Parameters
Vin = 25; % Input Voltage ( V )
Vout = 12; % Output Voltage ( V )
Pout = 100; % Output Power ( W )
fsw = 62.5e3 ; % Switching Frequency ( Hz )
efficiency = 0.9; % Efficiency (90%)
ripple_current_percent = 0.3; % Ripple Current as % of Iout (30%)
ripple_voltage_percent = 0.01; % Ripple Voltage as % of Vout (1%)
% % Derived Parameters
Iout = Pout / Vout ; % Output Current ( A )
D = Vout / Vin ; % Duty Cycle
Iin = Pout / ( efficiency * Vin ) ; % Input Current ( A )
% Inductor Design
delta_IL = ripple_current_percent * Iout ; % Ripple Current ( A )
L = ( Vout * ( Vin - Vout ) ) / ( Vin * fsw * delta_IL ) ; % Inductance ( H )
L = L * 1e6 ; % Convert to microhenries ( uH )
% % Core Selection ( Area Product Calculation )
Isat = Iout + delta_IL / 2; % Saturation Current ( A )
Bmax = 0.25; % Maximum Flux Density ( T )
Ku = 0.4; % Window Utilization Factor
J = 4; % Current Density ( A / mm ^2)
Ap = ( L * 1e-6 * Isat ^2) / ( Bmax * Ku * J ) ; % Core Area Product ( cm ^4)
% % Number of Turns
Ac = 30e-6; % Core Cross - sectional Area ( m ^2)
N = ( L * 1e-6 * Isat ) / ( Bmax * Ac ) ; % Number of Turns
% % Wire Gauge
Aw = Isat / J ; % Wire Cross - sectional Area ( mm ^2)
% % Air Gap
lg = ( L * 1e-6 * Isat ^2) / ( Bmax ^2 * Ac ) ; % Air Gap Length ( m )
lg = lg * 1e3 ; % Convert to millimeters ( mm )
% % Capacitor Design
delta_VC = ripple_voltage_percent * Vout ; % Ripple Voltage ( V )
C = delta_IL / (8 * fsw * delta_VC ) ; % Capacitance ( F )
C = C * 1e6 ; % Convert to microfarads ( uF )
% % MOSFET and Diode Selection
Vds = Vin * 1.2; % MOSFET Voltage Rating ( V ) , 20% margin
Ids = Iin * 1.5; % MOSFET Current Rating ( A ) , 50% margin
Vr = Vin * 1.2; % Diode Reverse Voltage Rating ( V ) , 20% margin
If = Iout * 1.5; % Diode Forward Current Rating ( A ) , 50% margin