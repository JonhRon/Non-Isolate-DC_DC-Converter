%% Inductor Design using Kg method
clc, clear, close all;
%% Input Parameter for ferrite core selection using Kg method
L = 150e-6; % Inductor[H]
Io = 4.166; % DC Current[A]
Delta_I = 1.25; % AC Current[A]
Po = 100; % Output Power[W]
alpha = 1; % Regulation[%]
Fs = 62.5e3; % Ripple Frequency[Hz]
Bm = 0.25; % Operating flux density [Tesla]
Ku = 0.4; % Window utilization
Tr = 25; % Temperature rise goal
%% Calculation Block
% Calculate the peak current Ipk
Ipk = Io + ( Delta_I / 2 );
% Calculate The energy-handling capability
E = (L * Ipk^2 ) / 2;
% Calculate the electrical condition coeffcient Ke
Ke = 0.145 * Po * Bm^2 * 1e-4;
% Calculate the core geometry coefficient Kg
Kg = E^2 / (Ke * alpha);
