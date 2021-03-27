%% (C) Copyright 2020 Remi Gau

clear
close all
clc

OneRoi

function OneRoi

    OptGenData.NbSubject = 1;
    OptGenData.NbRuns = 2;
    OptGenData.NbLayers = 6;
    OptGenData.NbVertices = 100;
    
    % use iid data across layer or add some layer error covariance
    OptGenData.IID = false;
    
    % proportion of FWHM for
    OptGenData.Raster.VerticalFWHM = 1/500;

    ROI = 1;
    Cdt = 1;
    
    OptGenData = SetParametersProfileSimulation(OptGenData, ROI, Cdt);
    Data = GenerateSubjectSurfaceDataLaminarProfiles(OptGenData);
    
    [~, ~, OptGenData] = GetPlottingDefaults(OptGenData);
    PlotOneRaster(mean(Data, 3), OptGenData)
    
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