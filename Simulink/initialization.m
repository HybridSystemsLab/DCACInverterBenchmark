% % initialization for DC/AC inverter example
%   clc
%   clear all                                                               

% constants ACCC 2014
global omega %R L Cap Vdc co ci e1 c3
R = 0.6; % resistance ||Ohms||
L = 0.1; % inductance ||Henry's||
Cap = 0.04;  % capacitance ||Farads||
% Vdc = 5; % dc voltage ||Volt||
f = 50; % frequency ||Hz||
omega = f*2*pi; % angular freqency

% % controlable band
% k1 = Vdc/R;
% k2 = Vdc/(1- L*Cap*omega^2);

% control band info based on ideal trajectory
e = 0.1; % control band width percentage
e3 = 0.01; % thin band width percentage
e1 = 0.001; % error value for q = 0  condition around iL = 0
co = 1*(1+e); % outer boundray V(iL, Vc) value, So
ci = 1*(1-e); % inner boundray V(iL, Vc) value, Si
c3 = 1*(1+e+e3); % thinband outside of outer boundray V(iL, Vc) value, S3
 
% ideal trajectory generator
run it_generator.m

% initial conditions
iL0 = 0.1; 
vC0 = 0.01;
p0 = 2;
q0 = -1;

x0 = [iL0; vC0; p0;q0];

% simulation horizon                                                    
T = 8;                                                                 
J = 2e4;                                                                 
                                                                        
% rule for jumps                                                        
% rule = 1 -> priority for jumps                                        
% rule = 2 -> priority for flows                                        
% rule = 3 -> no priority, random selection when simultaneous conditions
rule = 1;

%solver tolerances
% paramNameValStruct.RelTol = '1e-10';
% paramNameValStruct.MaxStep = '.001';
RelTol = 1e-6;
MaxStep = 1e-6;

%% IC correct
% run ic_correct.m