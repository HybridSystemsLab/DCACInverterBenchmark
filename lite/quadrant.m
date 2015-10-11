% find out (iL, vC) location as quadrant
function qua = quadrant(iL, vC)
if iL >=0 && vC >=0
    qua = 1; % in quadrant I
elseif iL <=0 && vC >=0
    qua = 2; % in quadrant II
elseif iL <=0 && vC <=0
    qua = 3; % in quadrant III
else qua = 4; % in quadrant IV
end