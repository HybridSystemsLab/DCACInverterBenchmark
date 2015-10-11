function value = C_inverter(x) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file       
% Project: DC/AC inverter
%
% Name: C.m
%
% Description: Flow set
%
% Version: v1.8 lite
% Required files: - 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global V qua co ci e1 c3 a b
% states
  iL = x(1);
  vC = x(2);
  p = x(3);
  q = x(4);

% useful expressions
  V = (iL/a)^2 + (vC/b)^2;
  qua = quadrant(iL, vC); 
  
% flow set
  if p == 1 % when Hfw is in the loop
      if V >= ci && V <= co && q == 0 
          % Hfw flow within the tracking band when q = 0
          value = 1;
  % to avoid the samll "circle" trajectory near vc axis
      elseif V >= ci && V <= co && q == 1 && (qua ~= 2 || (qua == 2 && iL <= -e1))
          % Hfw flow within the tracking band when q = 1, and not in e1
          % band around vc axis
          value = 1;
      elseif V >= ci && V <= co && q == -1 && (qua ~= 4 || (qua == 4 && iL >= e1))
          % Hfw flow within the tracking band when q = 1, and not in e1
          % band around vc axis
          value = 1;
  % places to flow from boundraies with correct q values
      elseif q == -1 
          if iL <= 0 &&  V <= ci % the lhp and Si 
              value = 1;
          elseif V >= co && V <= c3 && (qua == 1 || (qua == 4 && iL >= e1))
          % the rhp and So expect M1
              value = 1;
          else
              value = 0;
          end
      elseif q == 1 
          if iL >= 0 && V <= ci % the rhp and Si 
              value = 1;
          elseif V >= co && V <= c3 && (qua == 3 || (qua == 2 && iL <= -e1)) 
          % the lhp and So expect M2
              value = 1;
          else
              value = 0;
          end
      else
          value = 0;          
      end
  elseif p == 2 % when Hg is in the loop
      if q == 0 && V >= co % q = 0 for outside of So
          value = 1;
      elseif (q ~= 0) && V <= ci % q = 1, -1 for inside of Si
          value = 1;
      else
          value = 0;
      end
  else 
      value = 0;
  end