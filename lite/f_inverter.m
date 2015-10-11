function xdot = f_inverter(x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file       
% Project: DC/AC inverter
%
% Name: f.m
%
% Description: Flow map
%
% Version: v1.8 lite
% Required files: - 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 global R L Cap Vdc
% states
  iL = x(1);
  vC = x(2);
  p = x(3);
  q = x(4);

% flow map
  iLdot = -R/L*iL - 1/L*vC + Vdc/L*q;
  vCdot = 1/Cap*iL;
  pdot = 0;
  qdot = 0;

xdot = [iLdot; vCdot; pdot; qdot];
end