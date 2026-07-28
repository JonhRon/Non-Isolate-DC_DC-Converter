%% Voltage Control For Buck Converter
clc, clear, close all;
%% Buck Converter Parameter For Transfer Function
Vi = 30; % Input Voltage
L = 35e-6; % Inductor
C = 10e-6; % Capacitor
r = 0.1; % Internal Resistance of Component
R = 5.236; % Power Load Resistance
%% Buck Converter Tarnsfer Function
s = tf('s');
Gps = Vi /( L * C ) * (1+ s * C * r ) / ( s ^2 + s *( r / L + 1/( R * C ) ) + 1/( L * C ) )