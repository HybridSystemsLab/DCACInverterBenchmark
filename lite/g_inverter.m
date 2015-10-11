function xplus = g_inverter(x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file       
% Project: DC/AC inverter
%
% Name: g.m
%
% Description: Jump map
%
% Version: v1.8 lite
% Required files: - 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global V qua co ci c3 e1 a b
% states
  iL = x(1);
  vC = x(2);
  p = x(3);
  q = x(4);  
  
% useful expressions
  V = (iL/a)^2 + (vC/b)^2;
  qua = quadrant(iL, vC); 
  
% jump map
  iLplus = iL;
  vCplus = vC;
  
  if p == 1 % when Hfw is in the loop, Hfw takes effect
      if q ~= -1 && iL <= 0 && V <= ci % switch to q = -1 on Si and lhp
          qplus = -1;
      elseif q == 1 
          if V <= c3 && V >= co && (qua == 1 || (qua == 4 && iL >= e1)) 
          % switch to q = -1 on So and rhp expect M2
          qplus = -1;
          elseif V >= ci && V <= co && (qua == 2 && iL >= -e1)
          % to avoid the samll "circle" trajectory near vc axis
          % Hfw jump when within the tracking band when q = 1, and in e1
          % band around vc axis
          qplus = -1;
          else
              qplus=q;
          end
      elseif V <= c3 && V >= co &&... % switch to q = 0 for M1 and M2
          ((qua == 4 && iL <= e1 && q == 1) || (qua == 2 && iL >= -e1 && q == -1))
          qplus = 0;
      elseif q ~= 1 && iL >= 0 && V <= ci % switch to q = 1 on Si and rhp
          qplus = 1;
      elseif q == -1 
          if V <= c3 && V >= co && (qua == 3 || (qua == 2 && iL <= -e1)) 
          % switch to q = 1 on So and rhp expect M1
              qplus = 1;
          elseif V >= ci && V <= co && (qua == 4 && iL <= e1)
          % to avoid the samll "circle" trajectory near vc axis
          % Hfw jump when within the tracking band when q = -1, and in e1
          % band around vc axis
              qplus = 1;
          else
              qplus=q;
          end
      else
          qplus = q;
      end
      pplus = p; % p does not switch from 1 to 2
  elseif p == 2 % when Hg is in the loop
      if  V >= ci && V <= co % switch to Hfw when in tracking band
          pplus = 1;
          qplus = q;
      elseif q ~= 0 && V >= co % Hg, switch to q = 0 when outside So
          pplus = p;
          qplus = 0;
      elseif q == 0 && V <= ci % Hg, switch to q = 0 when outside Si
          pplus = p;
          qplus = 1;   
      else
          pplus = p;
          qplus = q;
      end
  else
      pplus = p;
      qplus = q;
  end
  
xplus = [iLplus; vCplus; pplus; qplus];
end