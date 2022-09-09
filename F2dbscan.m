function F2dbscan(M1,M2)
%Creates 3D plots of RRint vs calcType vs isAffect with dbscan clustering
    %   Inputs:
    %       rmssd_calc, pnnx_calc, sdnn_calc, sdsd_calc etc.
    %       data: [struct] with HR struct --> Raw. Raw is a n-by-4
    %       M1 = A n-by-m matrix, where each column is a different feature and each row is a different datapoint
    %       M2 = A n-by-1 vector of 0's or 1's where 1 is problematic behavior
    %       numerical array where n is the number of RRintervals collected
            
    %   Outputs:
    %       Function does not return any output values
    %       Function displays three 3D plots
    %           Raw data with no dbscan clustering
    %           dbscan clustering including outliers
    %           dbscan clustering without outliers

clc; close all;



calcs(:,1) = M1(:,1);
calcs(:,2) = M1(:,2);
calcs(:,3) = M1(:,3);
calcs(:,4) = M1(:,4);
RRint = M1(:,5);
affect = M2;


subplot(2,2,1);
scatter3(calcs(:,1),RRint,affect,'o'); %plot of data without clustering
xlabel("feature 1")
ylabel("feature 2")
zlabel("affect")
%title("RRint vs rmssd including outliers");
grid on
grid minor

subplot(2,2,2);
scatter3(calcs(:,2),RRint,affect,'o'); %plot of data without clustering
xlabel("feature 1")
ylabel("feature 2")
zlabel("affect")
%title("RRint vs pnn50 including outliers");
grid on
grid minor

subplot(2,2,3);
scatter3(calcs(:,3),RRint,affect,'o'); %plot of data without clustering
xlabel("feature 1")
ylabel("feature 2")
zlabel("affect")
%title("RRint vs sdnn including outliers");
grid on
grid minor

subplot(2,2,4);
scatter3(calcs(:,4),RRint,affect,'o'); %plot of data without clustering
xlabel("feature 1")
ylabel("feature 2")
zlabel("affect")
%title("RRint vs sdsd including outliers");
grid on
grid minor

z1 = [RRint,calcs(:,1),affect];
z2 = [RRint,calcs(:,2),affect];
z3 = [RRint,calcs(:,3),affect];
z4 = [RRint,calcs(:,4),affect];



idxrmssd = dbscan(z1,20,10);
idxpnn50 = dbscan(z2,20,10);
idxsdnn = dbscan(z3,20,10);
idxsdsd = dbscan(z4,20,10);
%idx is n-by-1 vector with cluster indices for each point
% idx = dbscan(X,epsilon,minpts) with array X, epsilon radius, and
% minpoints in a cluster

%% Plotting data with clustering

%% rmssd without outliers

% create n, value used for number of loop iterations 
uni = unique(idxrmssd);  %returns array with no reptitions 
numUni = numel(uni);  %counts number of elements 
n=numUni;             %set n to total number of unique elements in idx

% colors
colorbank = {};
connectedColorBank = {};
for i = 1:n
    colorbank{i} = {rand,rand,rand};
    connectedColorBank{i} = string("[" + colorbank{i}{1} + "," + colorbank{i}{2} + "," + colorbank{i}{3} + "]");
end

%loop generating clusters without outliers
figure;
subplot(2,2,1)
for i = 1:n
    %plot3(z1(idxrmssd==-1,2),z1(idxrmssd==-1,1),z1(idxrmssd==-1,3),'.','color','b')  %all points not assigned a cluster
    plot3(z1(idxrmssd==i,2),z1(idxrmssd==i,1),z1(idxrmssd==i,3),'.','color',connectedColorBank{i},'MarkerSize',12) % all points in diff clusters
    hold on
end
xlabel("feature 1")
ylabel("feature 2")
zlabel('affect')
%title("dbscan of RRint vs rmssd without outliers");
grid on
grid minor

%% pnn50 without outliers

% create n, value used for number of loop iterations 
uni = unique(idxpnn50);  %returns array with no reptitions 
numUni = numel(uni);  %counts number of elements 
n=numUni;             %set n to total number of unique elements in idx

% colors
colorbank = {};
connectedColorBank = {};
for i = 1:n
    colorbank{i} = {rand,rand,rand};
    connectedColorBank{i} = string("[" + colorbank{i}{1} + "," + colorbank{i}{2} + "," + colorbank{i}{3} + "]");
end

%loop generating clusters without outliers
subplot(2,2,2)
for i = 1:n
    %plot3(z1(idxrmssd==-1,2),z1(idxrmssd==-1,1),z1(idxrmssd==-1,3),'.','color','b')  %all points not assigned a cluster
    plot3(z1(idxpnn50==i,2),z1(idxpnn50==i,1),z1(idxpnn50==i,3),'.','color',connectedColorBank{i},'MarkerSize',12) % all points in diff clusters
    hold on
end
xlabel("feature 1")
ylabel("feature 2")
zlabel('affect')
%title("dbscan of RRint vs pnn50 without outliers");
grid on
grid minor

%% sdnn without outliers

% create n, value used for number of loop iterations 
uni = unique(idxsdnn);  %returns array with no reptitions 
numUni = numel(uni);  %counts number of elements 
n=numUni;             %set n to total number of unique elements in idx

% colors
colorbank = {};
connectedColorBank = {};
for i = 1:n
    colorbank{i} = {rand,rand,rand};
    connectedColorBank{i} = string("[" + colorbank{i}{1} + "," + colorbank{i}{2} + "," + colorbank{i}{3} + "]");
end

%loop generating clusters without outliers
subplot(2,2,3)
for i = 1:n
    %plot3(z1(idxrmssd==-1,2),z1(idxrmssd==-1,1),z1(idxrmssd==-1,3),'.','color','b')  %all points not assigned a cluster
    plot3(z1(idxsdnn==i,2),z1(idxsdnn==i,1),z1(idxsdnn==i,3),'.','color',connectedColorBank{i},'MarkerSize',12) % all points in diff clusters
    hold on
end
xlabel("feature 1")
ylabel("feature 2")
zlabel('affect')
%title("dbscan of RRint vs sdnn without outliers");
grid on
grid minor

%% sdsd without outliers

% create n, value used for number of loop iterations 
uni = unique(idxsdsd);  %returns array with no reptitions 
numUni = numel(uni);  %counts number of elements 
n=numUni;             %set n to total number of unique elements in idx

% colors
colorbank = {};
connectedColorBank = {};
for i = 1:n
    colorbank{i} = {rand,rand,rand};
    connectedColorBank{i} = string("[" + colorbank{i}{1} + "," + colorbank{i}{2} + "," + colorbank{i}{3} + "]");
end

%loop generating clusters without outliers
subplot(2,2,4)
for i = 1:n
    %plot3(z1(idxrmssd==-1,2),z1(idxrmssd==-1,1),z1(idxrmssd==-1,3),'.','color','b')
    %%all points not assigned a cluster (outliers)
    plot3(z1(idxsdsd==i,2),z1(idxsdsd==i,1),z1(idxsdsd==i,3),'.','color',connectedColorBank{i},'MarkerSize',12) % all points in diff clusters
    hold on
end
xlabel("feature 1")
ylabel("feature 2")
zlabel('affect')
%title("dbscan of RRint vs sdsd without outliers");
grid on
grid minor





end

