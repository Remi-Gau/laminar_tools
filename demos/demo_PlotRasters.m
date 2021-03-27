%% (C) Copyright 2020 Remi Gau

clear;
close all;
clc;

OneRoi;

function OneRoi

    Opt.NbSubject = 1;
    Opt.NbRuns = 20;
    Opt.NbLayers = 6;
    Opt.NbVertices = 1000;

    % use iid data across layer or add some layer error covariance
    Opt.IID = true;

    ROI = 1;
    Cdt = 1;

    Opt = SetParametersProfileSimulation(Opt, ROI, Cdt);

    Opt.StdDevWithinSubject = Opt.Betas(1) * 20;

    Data = GenerateSubjectSurfaceDataLaminarProfiles(Opt);

    SortingData = Data;

    Opt.Raster.Sort = true;
    Opt.Raster.CrossValidate = true;

    [Data, SortingData, R] = SortRaster(Data, SortingData, Opt, 'Cst');

    % proportion of FWHM for
    Opt.Raster.VerticalFWHM = 1 / 100;
    Opt.Raster.ColorMap = SeismicColorMap(1000);

    Opt.Raster.AddXLabel = true;

    [~, ~, Opt] = GetPlottingDefaults(Opt);

    subplot(121);
    Opt.Title = 'ROI 1 - Sorting condition';
    PlotOneRaster(mean(SortingData, 3), Opt);

    subplot(122);
    Opt.Title = 'ROI 1 - Sorted condition';
    Opt.Raster.AddColorBar = true;
    PlotOneRaster(mean(Data, 3), Opt);

    % Opt.Specific{1}.Data = Data;
    % Opt.Specific{1}.SubjectVec = SubjectVec;
    % Opt.Specific{1}.ConditionVec = ones(size(Data, 1), 1);
    % Opt.Specific{1}.RoiVec = ones(size(Data, 1), 1);
    %
    % Opt.Specific{1}.XLabel = {'ROI 1'};

    % PrintFigure(pwd);

end
