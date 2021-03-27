%% (C) Copyright 2020 Remi Gau

clear;
close all;
clc;

OneRoi;

function OneRoi

    OptGenData.NbSubject = 1;
    OptGenData.NbRuns = 2;
    OptGenData.NbLayers = 6;
    OptGenData.NbVertices = 200;

    % use iid data across layer or add some layer error covariance
    OptGenData.IID = false;

    ROI = 1;
    Cdt = 1;

    Opt = SetParametersProfileSimulation(OptGenData, ROI, Cdt);

    Data = GenerateSubjectSurfaceDataLaminarProfiles(Opt);

    % proportion of FWHM for
    Opt.Raster.VerticalFWHM = 1 / 100;
    Opt.Raster.ColorMap = SeismicColorMap(1000);
    Opt.Raster.AddColorBar = true;
    Opt.Raster.AddXLabel =  true;

    [~, ~, Opt] = GetPlottingDefaults(Opt);
    PlotOneRaster(mean(Data, 3), Opt);

    %     Opt.Specific{1}.Data = Data;
    %     Opt.Specific{1}.SubjectVec = SubjectVec;
    %     Opt.Specific{1}.ConditionVec = ones(size(Data, 1), 1);
    %     Opt.Specific{1}.RoiVec = ones(size(Data, 1), 1);
    %
    %     Opt.Specific{1}.Titles = 'ROI 1 - Condition Name';
    %     Opt.Specific{1}.XLabel = {'ROI 1'};
    %
    %     %%
    %     Opt.Title = 'Figure title';
    %
    %     Opt = SetProfilePlottingOptions(Opt);
    %     PlotProfileAndBetas(Opt);
    %     PrintFigure(pwd);

end
