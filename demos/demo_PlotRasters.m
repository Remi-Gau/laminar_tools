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

%%
OneRoi(Opt);

%%
OneRoTwoConditions(Opt);

function OneRoi(Opt)

    %% Generate data

    ROI = 1;
    Cdt = 1;
    Opt = SetParametersProfileSimulation(Opt, ROI, Cdt);
    Opt.StdDevWithinSubject = Opt.Betas(1) * 15;
    Data = GenerateSubjectSurfaceDataLaminarProfiles(Opt);

    %% Sort and bin data

    Opt = SetRasterPlotParameters(Opt);

    SortingData = Data;

    [Data, SortingData, R] = SortRaster(Data, SortingData, Opt, 'Cst');

    Data = BinRaster(Data);
    SortingData = BinRaster(SortingData);

    %% Plot

    Opt.Title = 'Raster - One ROI - One Condition';

    figure('name', Opt.Title, 'position', Opt.FigDim);

    SetFigureDefaults(Opt);

    MAX = GetAbsMax(cat(1, Data, SortingData));
    CLIM = [-MAX MAX];

    subplot(121);
    Opt.Raster.Title = 'ROI 1 - Sorting condition';
    PlotOneRaster(mean(SortingData, 3), Opt, CLIM);

    subplot(122);
    Opt.Raster.Title = 'ROI 1 - Sorted condition';
    Opt.Raster.AddProfile = true;
    Opt.Raster.AddColorBar = true;
    PlotOneRaster(mean(Data, 3), Opt, CLIM);

end

function OneRoTwoConditions(Opt)

    %% Generate data

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

    %% Sort and bin data

    NbBin = 500;

    Opt = SetRasterPlotParameters(Opt);

    [Data, SortingData, R] = SortRaster(Data, SortingData, Opt, 'Cst');

    Data = BinRaster(Data, NbBin);
    SortingData = BinRaster(SortingData, NbBin);

    %% Plot

    Opt.Title = 'Raster - One ROI - With Condition';

    figure('name', Opt.Title, 'position', Opt.FigDim);

    SetFigureDefaults(Opt);

    MAX = GetAbsMax(cat(1, Data, SortingData));
    CLIM = [-MAX MAX];

    subplot(121);
    Opt.Raster.Title = 'ROI 1 - Sorting condition';
    PlotOneRaster(mean(SortingData, 3), Opt, CLIM);

    subplot(122);
    Opt.Raster.Title = 'ROI 1 - Sorted condition';
    Opt.Raster.AddProfile = true;
    Opt.Raster.AddColorBar = true;
    PlotOneRaster(mean(Data, 3), Opt, CLIM);

end
