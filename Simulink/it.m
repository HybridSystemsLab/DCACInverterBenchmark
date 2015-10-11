function xidot = it(t, xi)
global omega a b
 
xidot = zeros(2,1);

xidot(1) = -a/b*omega*xi(2);
xidot(2) = b/a*omega*xi(1);
end