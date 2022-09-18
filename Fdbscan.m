function idx = Fdbscan(M1,labs,M2,epsilon,minpoints)
%Creates 3D plots of RRint vs calcType vs isAffect with dbscan clustering
    %   Inputs:
    %       M1: [n-by-m matrix] a matrix where each column is a different feature and 
    %           each row is a different datapoint
    %       labs: [1-by-m cell array] of string labels for each column in M1
    %       M2: [n-by-1 vector] of 0's or 1's where 1 is problematic behavior
    %       epsilon: [] //Include what a recommended value is for this
    %       minpoints: [] //Include what a recommended value is for this
    %       method: [] Either K-means clustering or dbscan analysis
    %       //Add option for not displaying any figures, in case the user
    %       just wants the idx
    %       
    %   Outputs:
    %       Function does not return any output values //If function
    %       returns nothing, then what is `idx` for?
    %       Function displays two 3D plots with x number of subplots where
    %       x=the number of columns-1 of M1 //this isn't that clear

    %           Raw data with no dbscan/kmeans clustering
    %           dbscan/kmeans clustering without outliers

clc; close all;
%{
calcs = [];

calcs(:,1) = rmssd_calc(data.HR.Raw{1}(:,3), {5,'units'}, false);
calcs(:,2) = pnnx_calc(data.HR.Raw{1}(:,3), 50, {5,'units'}, false); 
calcs(:,3) = sdnn_calc(data.HR.Raw{1}(:,3), {5,'units'}, false); 
calcs(:,4) = sdsd_calc(data.HR.Raw{1}(:,3), {5,'units'}, false); 
X = calcs;

RRint = data.HR.Raw{1}(:,3);

%% 
data.HR.Raw = affect_mark(data.HR.Raw{1}, data.Affect.Times{1}, {'SIB','clothing adjustment'});
affect = data.HR.Raw(:,4);

%}
% //obviously remove chunks of commented code if not longer needed



    

    for z = 2:size(M1,2)


        %{   
            %dont plot outliers right now
        subplot(2,2,z);
        scatter3(M1(:,z),M1(:,z+1),affect,'o'); %plot of data without clustering
        xlabel(labs{z})
        ylabel(labs{z+1})
        zlabel("affect")
        title(labs{z} + " vs " + labs{z+1} + " with affect");
        grid on
        grid minor
        %}

        affect = M2;
        arr1 = [M1(:,1),M1(:,z),affect];
        
        idx(:,z) = dbscan(arr1,epsilon,minpoints);
    
        %PLOTTING  | | |
        %          V V V   

        % create n, value used for number of loop iterations 
        uni = unique(idx(:,z));  %returns array with no reptitions 
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
        

        subplot(2,2,z-1)
        for i = 1:n
            %plot3(arr1(idx1==-1,1),arr1(idx1==-1,2),arr1(idx1==-1,3),'.','color','b')  %all points not assigned a cluster 
            plot3(arr1(idx(:,z)==i,1),arr1(idx(:,z)==i,2),arr1(idx(:,z)==i,3),'.','color',connectedColorBank{i},'MarkerSize',12) % all points in diff clusters
            hold on
        end
        xlabel(labs{1})
        ylabel(labs{z})
        zlabel("affect")
        title(labs{1} + " vs " + labs{z} + " with affect");
        grid on
        grid minor
        
    end




end

