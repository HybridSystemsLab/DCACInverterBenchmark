% sample data
sr = 200; % sampling rate
s = size(t);
n = ceil(s(1)/sr); % new data set size
x_hybrid = zeros(n,4);
t_hybrid = zeros(n,1);
for i = 1:n
x_hybrid(i,:) = x((i-1)*sr + 1,:);
t_hybrid(i) = t((i-1)*sr + 1);
end