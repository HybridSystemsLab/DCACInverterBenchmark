% Benchmark test for DC/AC inverter

a = 3*sqrt(2);
b = 120*sqrt(2); % check consistency with run_inverter.m

%% Generate ICs
% All ICs are within the tracking band for taking the period value
% IC1 - 0; IC2 - 25; IC3 - 45; IC4 - 65; IC5 -90
ICs = [a 0;
       a/4 0;
       a/2 0;
       3*a/4 0;
       0 b];
   
for i = 2:4
    ICs(i,2) = b * sqrt(1 - (ICs(i,1)/a)^2);
end

band = [0.1; 0.05; 0.01];

%% simulation
for k = 1:3
    for i = 1:5
        e = band(k); % control band width percentage
        iL0 = ICs(i,1); 
        vC0 = ICs(i,2);
        run_inverter
        swi_num = max(j);
        tot_tim = max(t);
        swi_ave = swi_num/tot_tim;
        name = num2str(k*10+i);
        save(name,'x','j','t','x0','e','swi_ave')
    end
end

% clear
% clc
% % IC5
% e = 0.01; % control band width percentage
% iL0 = 0.14; 
% vC0 = 0.004;
% run_inverter
% save('inverter1_5.mat','x','j','t','x0','e')

%% Calculate the average and std
% bandwith 20%
load('11','swi_ave');
S11 = swi_ave;
load('12','swi_ave');
S12 = swi_ave;
load('13','swi_ave');
S13 = swi_ave;
load('14','swi_ave');
S14 = swi_ave;
load('15','swi_ave');
S15 = swi_ave;

AVG1 = [S11; S12; S13; S14; S15];
S1_avg = mean(AVG1);
S1_std = std(AVG1);

% bandwith 10%
load('21','swi_ave');
S21 = swi_ave;
load('22','swi_ave');
S22 = swi_ave;
load('23','swi_ave');
S23 = swi_ave;
load('24','swi_ave');
S24 = swi_ave;
load('25','swi_ave');
S25 = swi_ave;

AVG2 = [S21; S22; S23; S24; S25];
S2_avg = mean(AVG2);
S2_std = std(AVG2);

% bandwith 2%
load('31','swi_ave');
S31 = swi_ave;
load('32','swi_ave');
S32 = swi_ave;
load('33','swi_ave');
S33 = swi_ave;
load('34','swi_ave');
S34 = swi_ave;
load('35','swi_ave');
S35 = swi_ave;

AVG3 = [S31; S32; S33; S34; S35];
S3_avg = mean(AVG3);
S3_std = std(AVG3);
