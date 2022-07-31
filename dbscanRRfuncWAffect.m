function X = dbscanRRfuncWAffect(calcType,data)
%Creates 3D plots of RRint vs calcType vs isAffect with dbscan clustering
    %   Inputs:
    %       calcType: "string" that is type of calculation that calls another function i.e.
    %       rmssd_calc, pnnx_calc, sdnn_calc, sdsd_calc etc.
    %       data: [struct] with HR struct --> Raw. Raw is a n-by-3
    %       numerical array where n is the number of RRintervals collected
    %   Outputs:
    %       Function does not return any output values
    %       Function displays three 3D plots
    %           Raw data with no dbscan clustering
    %           dbscan clustering including outliers
    %           dbscan clustering without outliers

clc; close all;

%calcFunc = string(calcType+"_calc");


switch calcType
    case 'rmssd'
        data.HR.Raw(:,4) = rmssd_calc(data.HR.Raw(:,3), {5,'units'}, false);  
    case 'pnnx'
        data.HR.Raw(:,4) = pnnx_calc(data.HR.Raw(:,3), 50, {5,'units'}, false); 
    case 'sdnn'
        data.HR.Raw(:,4) = sdnn_calc(data.HR.Raw(:,3), {5,'units'}, false); 
    case 'sdsd'
        data.HR.Raw(:,4) = sdsd_calc(data.HR.Raw(:,3), {5,'units'}, false); 
end




%format longG
%disp(data.HR.Raw)

RRint = data.HR.Raw(:,3);
calcTypedata = data.HR.Raw(:,4);

%Creating fake affect column
zVals = zeros(size(RRint));
for i = 1:size(zVals)
    if mod(i,20) == 0 
        zVals(i) = 1;
    end
end    
data.HR.Raw(:,5) = zVals;
affect = data.HR.Raw(:,5);

X = [RRint,calcTypedata,affect];



figure;
scatter3(X(:,2),X(:,1),X(:,3),'o'); %plot of data without clustering
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