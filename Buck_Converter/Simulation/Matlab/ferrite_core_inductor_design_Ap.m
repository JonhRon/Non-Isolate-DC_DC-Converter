%% Inductor Design using Ap method
clc, clear, close all;
%% Input Parameter for ferrite core selection using Ap method
L = 34.9e-6; % Inductor[H]
Io = 4.583; % DC Current[A]
Delta_I = 1.375; % AC Current[A]
Po = 110; % Output Power[W]
alpha = 1; % Regulation[%]
Fs = 100e3; % Ripple Frequency[Hz]
Bm = 0.25; % Operating flux density [Tesla]
Ku = 0.4; % Window utilization
Tr = 25; % Temperature rise goal
J = 250; % Current Density [ amps-per-cm^2 ]
%% Calculation Block
% Calculate the peak current Ipk
Ipk = Io + ( Delta_I / 2 );
% Calculate The energy-handling capability
E = (L * Ipk^2 ) / 2;
% Calculate the electrical condition coeffcient Ke
Ke = 0.145 * Po * Bm^2 * 1e-4;
% Calculate the core geometry coefficient Ap
Ap = (2 * E * 1e4) / (Bm * J * Ku);