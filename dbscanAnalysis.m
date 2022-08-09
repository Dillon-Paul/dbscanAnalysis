function X = dbscanAnalysis(data)
%Creates 3D plots of RRint vs calcType vs isAffect with dbscan clustering
    %   Inputs:
    %       rmssd_calc, pnnx_calc, sdnn_calc, sdsd_calc etc.
    %       data: [struct] with HR struct --> Raw. Raw is a n-by-4
    %       numerical array where n is the number of RRintervals collected
            
    %   Outputs:
    %       Function does not return any output values
    %       Function displays three 3D plots
    %           Raw data with no dbscan clustering
    %           dbscan clustering including outliers
    %           dbscan clustering without outliers

clc; close all;
sadss
%calcFunc = string(calcType+"_calc");

%{
switch calcType
    case 'rmssd'
        data.HR.Raw{1}(:,4) = rmssd_calc(data.HR.Raw{1}(:,3), {5,'units'}, false);  
    case 'pnnx'
        data.HR.Raw{1}(:,4) = pnnx_calc(data.HR.Raw{1}(:,3), 50, {5,'units'}, false); 
    case 'sdnn'
        data.HR.Raw{1}(:,4) = sdnn_calc(data.HR.Raw{1}(:,3), {5,'units'}, false); 
    case 'sdsd'
        data.HR.Raw{1}(:,4) = sdsd_calc(data.HR.Raw{1}(:,3), {5,'units'}, false); 
end
%}



%format longG
%disp(data.HR.Raw)
calcs = [];
calcs(:,1) = rmssd_calc(data.HR.Raw(:,3), {5,'units'}, false);
calcs(:,2) = pnnx_calc(data.HR.Raw(:,3), 50, {5,'units'}, false); 
calcs(:,3) = sdnn_calc(data.HR.Raw(:,3), {5,'units'}, false); 
calcs(:,4) = sdsd_calc(data.HR.Raw(:,3), {5,'units'}, false); 
X = calcs;

RRint = data.HR.Raw(:,3);
affect = data.HR.Raw(:,4);


%calcTypedata = data.HR.Raw{1}(:,4);

%% 
%data.HR.Raw = affect_mark(data.HR.Raw{1}, data.Affect.Times{1}, {'SIB','clothing adjustment'});


% %Creating fake affect column
% zVals = zeros(size(RRint));
% for i = 1:size(zVals)
%     if mod(i,20) == 0 
%         zVals(i) = 1;
%     end
% end    
%data.HR.Raw(:,5) = zVals;


affect = data.HR.Raw(:,4);




subplot(2,2,1);
scatter3(calcs(:,1),RRint,affect,'o'); %plot of data without clustering
xlabel("rmssd")
ylabel("RRint")
zlabel("affect")
title("RRint vs rmssd including outliers");
grid on
grid minor

subplot(2,2,2);
scatter3(calcs(:,2),RRint,affect,'o'); %plot of data without clustering
xlabel("pnn50")
ylabel("RRint")
zlabel("affect")
title("RRint vs pnn50 including outliers");
grid on
grid minor

subplot(2,2,3);
scatter3(calcs(:,3),RRint,affect,'o'); %plot of data without clustering
xlabel("sdnn")
ylabel("RRint")
zlabel("affect")
title("RRint vs sdnn including outliers");
grid on
grid minor

subplot(2,2,4);
scatter3(calcs(:,4),RRint,affect,'o'); %plot of data without clustering
xlabel("sdsd")
ylabel("RRint")
zlabel("affect")
title("RRint vs sdsd including outliers");
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
xlabel("rmssd")
ylabel("RRint")
zlabel('affect')
title("dbscan of RRint vs rmssd without outliers");
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
xlabel("pnn50")
ylabel("RRint")
zlabel('affect')
title("dbscan of RRint vs pnn50 without outliers");
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
xlabel("sdnn")
ylabel("RRint")
zlabel('affect')
title("dbscan of RRint vs sdnn without outliers");
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
    %plot3(z1(idxrmssd==-1,2),z1(idxrmssd==-1,1),z1(idxrmssd==-1,3),'.','color','b')  %all points not assigned a cluster
    plot3(z1(idxsdsd==i,2),z1(idxsdsd==i,1),z1(idxsdsd==i,3),'.','color',connectedColorBank{i},'MarkerSize',12) % all points in diff clusters
    hold on
end
xlabel("sdsd")
ylabel("RRint")
zlabel('affect')
title("dbscan of RRint vs sdsd without outliers");
grid on
grid minor




%{
calcType = "rmssd";
figure;
%rmssd
scatter3(Z(:,2),Z(:,1),calcs(:,1),'o'); %plot of data without clustering
xlabel(calcType)
ylabel("RRint")
zlabel("affect")
title("RRint vs " + calcType);
grid on
grid minor

idx = dbscan(X,20,10);
%idx is n-by-1 vector with cluster indices for each point
% idx = dbscan(X,epsilon,minpts) with array X, epsilon radius, and
% minpoints in a cluster


% create n, value used for number of loop iterations 
uni = unique(idx);  %returns array with no reptitions 
numUni = numel(uni);  %counts number of elements 
n=numUni;             %set n to total number of unique elements in idx

% colors
colorbank = {};
connectedColorBank = {};
for i = 1:n
    colorbank{i} = {rand,rand,rand};
    connectedColorBank{i} = string("[" + colorbank{i}{1} + "," + colorbank{i}{2} + "," + colorbank{i}{3} + "]");
end


%loop generating clusters with outliers
figure;


for i = 1:n
    plot3(X(idx==-1,2),X(idx==-1,1),X(idx==-1,3),'.','color','b')  %all points not assigned a cluster
    plot3(X(idx==i,2),X(idx==i,1),X(idx==i,3),'.','color',connectedColorBank{i},'MarkerSize',12) % all points in diff clusters
    hold on
end
xlabel(calcType)
ylabel("RRint")
zlabel('affect')
title("dbscan of RRint vs " + calcType + " with outliers");
grid on
grid minor




%loop generating clusters without outliers
figure;
for i = 1:n   
    plot3(X(idx==i,2),X(idx==i,1),X(idx==i,3),'.','color',connectedColorBank{i},'MarkerSize',12) 
    hold on
end
xlabel(calcType)
ylabel("RRint")
zlabel("affect")
title("dbscan of RRint vs " + calcType + " without outliers");
grid on
grid minor




hold off


end

%}