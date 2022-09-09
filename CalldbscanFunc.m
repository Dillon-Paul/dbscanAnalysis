%Call to dbscanRRfunc.m
clc; clear; close all;
cd C:/A_Important/School_Materials/'Smith Research'/matlab/PSHR_pipeline-main/
addpath('./Analysis');
addpath('./Preprocess');
addpath('./Export');
addpath('./Import');
addpath('./sample');
addpath('../analyses');
addpath('../analyses');







% data = [];
% data = pshr_load_data(data, './sample/', 'HR_A.txt','HR');
% data = pshr_load_data(data, './sample/', 'ECG_A.txt', 'ECG');
% data = load_affect(data, './sample/','A_coding.csv');

data = pshr_load('HR',{'./sample/HR_A.txt'}, 'ECG', {'./sample/ECG_A.txt'}, 'Affect', {'./sample/A_coding.csv'});

%
calcs = [];
calcs(:,1) = rmssd_calc(data.HR.Raw{1}(:,3), {5,'units'}, false);
calcs(:,2) = pnnx_calc(data.HR.Raw{1}(:,3), 50, {5,'units'}, false); 
calcs(:,3) = sdnn_calc(data.HR.Raw{1}(:,3), {5,'units'}, false); 
calcs(:,4) = sdsd_calc(data.HR.Raw{1}(:,3), {5,'units'}, false); 



data.HR.Raw = affect_mark(data.HR.Raw{1}, data.Affect.Times{1}, {'SIB','clothing adjustment'});

calcs(:,5) = data.HR.Raw(:,3); %RRint column

affect = data.HR.Raw(:,4); %affect column

Fdbscan(calcs,affect)

%
%dbscanRRfunc('sdsd',data);
%X = dbscanAnalysis(data);





