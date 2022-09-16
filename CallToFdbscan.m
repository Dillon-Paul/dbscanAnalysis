

%Call to Fdbscan
clc; clear; close all;
cd C:/A_Important/School_Materials/'Smith Research'/matlab/PSHR_pipeline-main/
addpath('./Analysis');
addpath('./Preprocess');
addpath('./Export');
addpath('./Import');
addpath('./sample');
addpath('../analyses');
addpath('../Github-repository/dbscanAnalysis');

data = pshr_load('HR',{'./sample/HR_A.txt'}, 'ECG', {'./sample/ECG_A.txt'}, 'Affect', {'./sample/A_coding.csv'});

data.HR.Raw = affect_mark(data.HR.Raw{1}, data.Affect.Times{1}, {'SIB','clothing adjustment'});

calcs(:,1) = data.HR.Raw(:,3); %%RRint
calcs(:,2) = pnnx_calc(data.HR.Raw(:,3), 50, {5,'units'}, false); %pnn50
calcs(:,3) = rmssd_calc(data.HR.Raw(:,3), {5,'units'}, false); %rmssd
calcs(:,4) = sdnn_calc(data.HR.Raw(:,3), {5,'units'}, false);  %sdnn
calcs(:,5) = sdsd_calc(data.HR.Raw(:,3), {5,'units'}, false);  %sdsd

affect = data.HR.Raw(:,4); %affect column

labs1 = {'RRint', 'pnn50','rmssd','sdnn','sdsd'};

idx = Fdbscan(calcs,labs1,affect,20,20);




