%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file       Project: DC/AC inverter  @ Hybrid Dynamics and Control
% Lab, http://www.u.arizona.edu/~sricardo/index.php?n=Main.Software
%
% Filename: run_inverter
%
% version: v1.8 lite
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clc
% clear

%% useful constants ADHS2015
global omega R L Cap Vdc co ci e1 c3 V qua a b
R = 0.7; % resistance ||Ohms||
L = 0.106; % inductance ||Henry's||
Cap = 6.63e-5;  % capacitance ||Farads||
Vdc = 220; % dc voltage ||Volt||
f = 60; % frequency ||Hz||
omega = f*2*pi; % angular freqency

% %% useful constants ACC2014
% global omega R L Cap Vdc co ci e1 c3 V qua a b
% R = 0.7; % resistance ||Ohms||
% L = 0.106; % inductance ||Henry's||
% Cap = 6.63e-5;  % capacitance ||Farads||
% Vdc = 220; % dc voltage ||Volt||
% f = 60; % frequency ||Hz||
% omega = f*2*pi; % angular freqency

%% ideal trajectory generator
% it_generator

a = 3*sqrt(2);
b = a/(Cap*omega); % ideal ellipse radius b

%% controller constants/variables
% % controlable band
% k1 = Vdc/R;
% k2 = Vdc/(1- L*Cap*omega^2);

% Initialize control 
V = 0;
qua = 0;

% control band info based on ideal trajectory
e = 0.1; % control band width percentage
e3 = 0.01*a; % thin band width percentage
e1 = 0.01*a; % error value for q = 0  condition around iL = 0
co = 1*(1+e); % outer boundray V(iL, Vc) value, So
ci = 1*(1-e); % inner boundray V(iL, Vc) value, Si
c3 = 1*(1+e+e3); % thinband outside of outer boundray V(iL, Vc) value, S3

 

%% initial conditions
 iL0 = 0.1; 
 vC0 = 0.009;
 p0 = 1;
 q0 = 1; 
 x0 = [iL0; vC0; p0; q0];

%% simulation horizon
TSPAN=[0 0.8];
JSPAN = [0 3e4];

% rule for jumps
% rule = 1 -> priority for jumps
% rule = 2 -> priority for flows
rule = 1;

%solver tolerances
% paramNameValStruct.RelTol = '1e-10';
% paramNameValStruct.MaxStep = '1e-7';
options = odeset('RelTol',1e-5,'MaxStep',1e-5);
%% 
% %% simulate
[t j x] = HyEQsolver(@f_inverter,@g_inverter,@C_inverter,@D_inverter,...
    x0,TSPAN,JSPAN,rule,options);
% save data;
%% plot solution
% run postprocessing.m