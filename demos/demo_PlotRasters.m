% (C) Copyright 2020 Remi Gau

clear;
close all;
clc;

Opt.NbRuns = 20;
Opt.NbLayers = 6;

% use iid data across layer
% or add some layer error covariance
Opt.IID = false;

%% demos with one subject
Opt.NbSubject = 1;
Opt.NbVertices = 5000;

OneRoi(Opt);
% OneRoiTwoConditions(Opt);

%% demos with one group
Opt.NbSubject = 10;

% determine range of vertices
% that will be given to each subject [Min Max]
Opt.NbVerticesRange = [4000 5000];

% GroupOneRoi(Opt);
% GroupOneRoi2Conditions(Opt);
Group2By2(Opt);

function OneRoi(Opt)
    
    %% Generate data
    
    ROI = 1;
    Cdt = 1;
    Opt = SetParametersProfileSimulation(Opt, ROI, Cdt);
    Data = GenerateSubjectSurfaceDataRaster(Opt);
    
    %% Sort and bin data
    
    SortBy = 'Cst';
    
    Opt = SetRasterPlotParameters(Opt);
    
    SortingData = Data;
    
    [Data, SortingData, R] = SortRaster(Data, SortingData, Opt, SortBy);
    
    Data = BinRaster(Data);
    
    %% Plot
    
    Opt.Title = 'Raster - One ROI - One Condition';
    
    figure('name', Opt.Title, 'position', Opt.FigDim);
    
    SetFigureDefaults(Opt);
    
    MAX = GetAbsMax(Data);
    CLIM = [-MAX MAX];
    
    subplot(1, 10, 1);
    Opt.Raster.Title = 'ROI 1 - Sorting condition';
    Opt.Raster.AddRectangleXTickLabel =  false;
    PlotOneRaster(SortingData, Opt, CLIM);
    
    subplot(1, 10, 2:9);
    Opt.Raster.Title = 'ROI 1 - Sorted condition';
    Opt.Raster.AddRectangleXTickLabel =  true;
    
    Opt.Raster.AddProfile = true;
    Opt.Specific{1, 1}.ProfileLine.LineWidth = 1;
    Opt.Specific{1, 1}.ProfileLine.MarkerSize = 6;
    
    Opt.Raster.AddColorBar = true;
    PlotOneRaster(Data, Opt, CLIM);
    
end

function OneRoiTwoConditions(Opt)
    
    %% Generate data
    
    % TODO
    % Generating correlated conditions will require tweaking the
    % variance-covariance matrix used to generate data with
    % MVNRND
    
    ROI = 1;
    Cdt = 1;
    Opt = SetParametersProfileSimulation(Opt, ROI, Cdt);
    Data = GenerateSubjectSurfaceDataRaster(Opt);
    
    ROI = 1;
    Cdt = 2;
    Opt = SetParametersProfileSimulation(Opt, ROI, Cdt);
    SortingData = GenerateSubjectSurfaceDataRaster(Opt);
    
    %% Sort and bin data
    
    SortBy = 'Cst';
    
    NbBin = 500;
    
    Opt = SetRasterPlotParameters(Opt);
    
    [Data, SortingData, R] = SortRaster(Data, SortingData, Opt, SortBy);
    
    Data = BinRaster(Data, NbBin);
    SortingData = BinRaster(SortingData, NbBin);
    
    %% Plot
    
    Opt.Title = 'Raster - One ROI - With Condition';
    
    figure('name', Opt.Title, 'position', Opt.FigDim);
    
    SetFigureDefaults(Opt);
    
    MAX = GetAbsMax(Data);
    CLIM = [-MAX MAX];
    
    subplot(121);
    Opt.Raster.Title = 'ROI 1 - Sorting condition';
    PlotOneRaster(SortingData, Opt, CLIM);
    
    subplot(122);
    Opt.Raster.Title = 'ROI 1 - Sorted condition';
    Opt.Raster.AddProfile = true;
    Opt.Raster.AddColorBar = true;
    PlotOneRaster(Data, Opt, CLIM);
    
end

function GroupOneRoi(Opt)
    
    %% Generate data
    
    Opt = GenerateNumberVertexForSubject(Opt);
    
    ROI = 1;
    Cdt = 1;
    Opt = SetParametersProfileSimulation(Opt, ROI, Cdt);
    Data = GenerateGroupSurfaceDataRaster(Opt);
    
    %% Sort and bin data
    
    SortBy = 'Cst';
    
    Opt = SetRasterPlotParameters(Opt);
    
    SortingData = Data;
    
    [Data, SortingData, R] = SortRaster(Data, SortingData, Opt, SortBy);
    
    Data = BinRaster(Data);
    SortingData = BinRaster(SortingData);
    
    %% Plot
    
    Opt.Title = 'Group Raster - One ROI - One Condition';
    
    figure('name', Opt.Title, 'position', Opt.FigDim);
    
    SetFigureDefaults(Opt);
    
    Profiles = mean(Data, 1);
    Opt.Raster.Profiles = squeeze(Profiles)';
    
    Data = mean(Data, 3);
    SortingData = mean(SortingData, 3);
    
    MAX = GetAbsMax(Data);
    CLIM = [-MAX MAX];
    
    subplot(1, 10, 1);
    Opt.Raster.Title = 'ROI 1 - Sorting condition';
    Opt.Raster.AddRectangleXTickLabel =  false;
    PlotOneRaster(SortingData, Opt, CLIM);
    
    subplot(1, 10, 2:9);
    Opt.Raster.Title = 'ROI 1 - Sorted condition';
    
    Opt.Raster.AddRectangleXTickLabel =  true;
    
    Opt.Raster.AddProfile = true;
    Opt.Specific{1, 1}.ProfileLine.LineWidth = 1;
    Opt.Specific{1, 1}.ProfileLine.MarkerSize = 6;
    
    Opt.Raster.AddColorBar = true;
    
    PlotOneRaster(Data, Opt, CLIM);
    
end

function GroupOneRoi2Conditions(Opt)
    
    %% Generate data
    
    Opt = GenerateNumberVertexForSubject(Opt);
    
    ROI = 1;
    Cdt = 1;
    Opt = SetParametersProfileSimulation(Opt, ROI, Cdt);
    Data = GenerateGroupSurfaceDataRaster(Opt);
    
    ROI = 1;
    Cdt = 2;
    Opt = SetParametersProfileSimulation(Opt, ROI, Cdt);
    SortingData = GenerateGroupSurfaceDataRaster(Opt);
    
    %% Sort and bin data
    
    SortBy = 'Cst';
    
    Opt = SetRasterPlotParameters(Opt);
    
    [Data, SortingData, R] = SortRaster(Data, SortingData, Opt, SortBy);
    
    Data = BinRaster(Data);
    SortingData = BinRaster(SortingData);
    
    %% Plot
    
    Opt.Title = 'Group Raster - One ROI - 2 Conditions';
    
    figure('name', Opt.Title, 'position', Opt.FigDim);
    
    SetFigureDefaults(Opt);
    
    % get profile for each subject and condition
    Profiles = mean(Data, 1);
    Opt.Raster.Profiles = squeeze(Profiles)';
    
    SortingData = mean(SortingData, 3);
    
    % get maximum for average raster
    Data = mean(Data, 3);
    MAX = GetAbsMax(Data);
    CLIM = [-MAX MAX];
    
    subplot(1, 10, 1);
    Opt.Raster.Title = 'ROI 1 - Sorting condition';
    Opt.Raster.AddRectangleXTickLabel =  false;
    PlotOneRaster(SortingData, Opt, CLIM);
    
    subplot(1, 10, 2:9);
    Opt.Raster.Title = 'ROI 1 - Sorted condition';
    
    Opt.Raster.AddRectangleXTickLabel =  true;
    
    Opt.Raster.AddProfile = true;
    Opt.Specific{1, 1}.ProfileLine.LineWidth = 1;
    Opt.Specific{1, 1}.ProfileLine.MarkerSize = 6;
    
    Opt.Raster.AddColorBar = true;
    
    PlotOneRaster(Data, Opt, CLIM);
    
end

function Group2By2(Opt)
    %
    % just as an example of how to plot several conditions
    % sorted by the same one
    %
    
    %% Generate data
    %
    % let's pretend that they are 4 different conditions
    
    Opt = GenerateNumberVertexForSubject(Opt);
    
    for ROI = 1:2
        for Cdt = 1:2
            
            Opt = SetParametersProfileSimulation(Opt, ROI, Cdt);
            Data{ROI, Cdt} = GenerateGroupSurfaceDataRaster(Opt);
            
        end
    end
    
    SortingData = Data{1,1};
    
    %% Sort and bin data
    
    SortBy = 'Cst';
    
    Opt = SetRasterPlotParameters(Opt);
    
    for i = 1:numel(Data)
        
        [Data{i}] = SortRaster(Data{i}, SortingData, Opt, SortBy);
        Data{i} = BinRaster(Data{i});
        
    end
    
    [SortingData] = SortRaster(SortingData, SortingData, Opt, SortBy);
    SortingData = BinRaster(SortingData);
    
    Profiles = cellfun(@(x) squeeze(mean(x, 1))', Data, 'UniformOutput', false);
    Rasters = cellfun(@(x) mean(x, 3), Data, 'UniformOutput', false);
    SortingRaster = mean(SortingData, 3);
    
    MAX = GetAbsMax(Rasters);
    CLIM = [-MAX MAX];
    
    %% Plot
    
    Opt.m = size(Rasters, 2);
    Opt.n = size(Rasters, 1);
    
    Opt.Title = 'Group Raster - 2 X 2 Conditions';
    
    figure('name', Opt.Title, 'position', Opt.FigDim);
    
    SetFigureDefaults(Opt);
    
    Opt.Specific{1, 1}.ProfileLine.LineWidth = 0.5;
    Opt.Specific{1, 1}.ProfileLine.MarkerSize = 3;
    
    SubplotCounter = 1;
    
    Opt.Raster.AddRectangleXTickLabel =  false;
    
    for iRow = 1:Opt.n
        
        if iRow == Opt.n
            Opt.Raster.AddRectangleXTickLabel =  true;
        end
        
        Opt.Raster.AddColorBar = false;
        
        for iCol = 1:Opt.m

            if iCol == Opt.m
                Opt.Raster.AddColorBar = true;
            end

            subplot(Opt.n, Opt.m, SubplotCounter);
            
            Opt.Raster.Profiles = Profiles{iRow, iCol};
            Opt.Raster.Title = sprintf('Condition: %i, %i', iRow, iCol);

            Opt.Raster.AddProfile = true;

            PlotOneRaster(Rasters{iRow, iCol}, Opt, CLIM);
            
            SubplotCounter = SubplotCounter + 1;
            
        end
    end
    
end

