% postprocessing for the DC/AC inverter

%% data for control band boundaries
by = @(rhs, bx) sqrt((rhs-(bx./a).^2)*b^2);
  % inner boundary
  rhs = 1*(1-e);
  xib = linspace(-a*sqrt(rhs),a*sqrt(rhs),1e2);
  yib1 = by(rhs, xib);
  yib2 = -by(rhs, xib);
  yib = [yib1; yib2];
  clear rhs
  
  % outer boundary
  rhs = 1*(1+e);
  xob = linspace(-a*sqrt(rhs),a*sqrt(rhs),1e4);
  yob1 = by(rhs, xob);
  yob2 = -by(rhs, xob);
  yob = [yob1; yob2];
 
% %% data for controllable band
% right = min(abs(k1*1.1), abs(a*sqrt(rhs)*1.1));
% left = -right;
% 
% % lower tangetial line
% ltline = @(cbx) -k2/k1*cbx + k2;
% 
% cbx1 = linspace(left,right,1e3);
% cby1 = ltline(cbx1);
% 
% % upper tangetial line
% utline = @(x) -k2/k1*x - k2;
% 
% cbx2 = linspace(left,right,1e3);
% cby2 = utline(cbx1);


%% trajetories and boundaries for ideal case
figure
% % controllable band based on R,L,C,omega
% plot(cbx1,cby1);hold on
% plot(cbx2,cby2);hold on

% ideal case trajectory
plot(xi(:,1),xi(:,2)); hold on
  
% plot outer and inner boundaries
plot(xob,yob,'g-.'); hold on
plot(xib,yib,'g-.'); hold on

% resulting trajectory w/controller
plot(x(2800000:3050000,1),x(2800000:3050000,2),'r'); hold on

% labels
xlabel('i_L','fontsize',15)
ylabel('v_C','fontsize',15)
title('i_L vs. V_C Trajectory','fontsize',15)
grid on
hold off