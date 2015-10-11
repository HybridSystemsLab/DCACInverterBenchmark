% ideal trajectory generator

%% constants and ICs
% define largest ellipse size within controllable region
%   amax = abs(Vdc*sqrt(...
%       R^2+(1/(Cap*omega)-L*omega)^2)/(R^2-(1/(Cap*omega)-L*omega)^2));
%   bmax = amax/(Cap*omega);
  
% given initial conditions of ideal trajectories
%   xi0 = [(amax - 1e-3)/sqrt(1+e), 0];
  % xi0 = input('Enter xi0 (in form of [iL0, Vc0]):');
  
global a b

% check above input
% while(1)
% % % corresponding tractable ideal trajectory based on given IC and "e"
% %   a = sqrt(xi0(1)^2 + xi0(2)^2/(Cap*omega)^2);% ideal ellipse radius a
% % give constant a
   b = 0.0123;
   a = b*(Cap*omega); % ideal ellipse radius a  
%  
%   if a >= amax/sqrt(1+e) || b >= bmax/sqrt(1+e)
%       display('Inappropriate Initial Condition!')
%       xi0 = input('Re-enter xi0 (in form of [iL0, Vc0]):');      
%   end
%   
%   if a <= amax/sqrt(1+e) && b <= bmax/sqrt(1+e),  break, end
% end
%   
% integration time domain
  tspan = [0, 1.1/f];
  xi0 = [a, 0];  
%% ideal trajectory integration
% ode solver
options = odeset('RelTol',1e-5,'MaxStep',1e-4);
[T, xi] = ode15s(@it,tspan, xi0,options);