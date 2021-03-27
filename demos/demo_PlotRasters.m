%% (C) Copyright 2020 Remi Gau

clear;
close all;
clc;

Opt.NbSubject = 1;
Opt.NbRuns = 20;
Opt.NbLayers = 6;
Opt.NbVertices = 1000;

% use iid data across layer or add some layer error covariance
Opt.IID = true;

% FWHM for smotthing "across vertices"
% proportion of tne number of vertices
Opt.Raster.VerticalFWHM = 1 / 500;
Opt.Raster.ColorMap = SeismicColorMap(1000);
Opt.Raster.AddXLabel = true;

Opt.Raster.Sort = true;
Opt.Raster.CrossValidate = true;

%%
OneRoi(Opt)

%%
OneRoTwoConditions(Opt)

function OneRoi(Opt)
    
    ROI = 1;
    Cdt = 1;
    Opt = SetParametersProfileSimulation(Opt, ROI, Cdt);
    Opt.StdDevWithinSubject = Opt.Betas(1) * 15;
    Data = GenerateSubjectSurfaceDataLaminarProfiles(Opt);
    
    SortingData = Data;
    
    [Data, SortingData, R] = SortRaster(Data, SortingData, Opt, 'Cst');
    
    [~, ~, Opt] = GetPlottingDefaults(Opt);
    
    figure
    
    subplot(121);
    Opt.Title = 'ROI 1 - Sorting condition';
    PlotOneRaster(mean(SortingData, 3), Opt);
    
    subplot(122);
    Opt.Title = 'ROI 1 - Sorted condition';
    Opt.Raster.AddColorBar = true;
    PlotOneRaster(mean(Data, 3), Opt);
    
end


function OneRoTwoConditions(Opt)
    
    % TODO
    % Generating correlated conditions will require tweaking the
    % variance-covariance matrix used to generate data with
    % MVNRND
    
    ROI = 1;
    Cdt = 1;
    Opt = SetParametersProfileSimulation(Opt, ROI, Cdt);
    Data = GenerateSubjectSurfaceDataLaminarProfiles(Opt);
    
    ROI = 1;
    Cdt = 2;
    Opt = SetParametersProfileSimulation(Opt, ROI, Cdt);
    SortingData = GenerateSubjectSurfaceDataLaminarProfiles(Opt);
    
    [Data, SortingData, R] = SortRaster(Data, SortingData, Opt, 'Cst');
    
    [~, ~, Opt] = GetPlottingDefaults(Opt);
    
    figure
    
    subplot(121);
    Opt.Title = 'ROI 1 - Sorting condition';
    PlotOneRaster(mean(SortingData, 3), Opt);
    
    subplot(122);
    Opt.Title = 'ROI 1 - Sorted condition';
    Opt.Raster.AddColorBar = true;
    PlotOneRaster(mean(Data, 3), Opt);
    
end
