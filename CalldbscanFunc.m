%Call to dbscanRRfunc.m
clc; clear; close all;
Data = [];
data = pshr_load_data(Data, './', 'HR_03-21-2022.txt','HR');


%dbscanRRfunc('sdsd',data);
X = dbscanRRfuncWAffect('sdsd',data);





