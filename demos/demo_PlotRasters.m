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
Opt.NbVertices = 1000;

OneRoi(Opt);
OneRoiTwoConditions(Opt);

%% demos with one group
Opt.NbSubject = 10;

% determine range of vertices
% that will be given to each subject [Min Max]
Opt.NbVerticesRange = [1000 2000];

GroupOneRoi(Opt);
GroupOneRoi2Conditions(Opt);
Group2By2(Opt);

%% demos with ROIs of different size on same figure (left and right hemisphere)
Group2By2DifferentRois(Opt);

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

    [Data, SortingData, Beta] = SortRaster(Data, SortingData, Opt, SortBy);

    Data = BinRaster(Data);

    Data = SmoothRaster(Data, Opt);

    %% Plot

    Opt.Title = 'Raster - One ROI - One Condition';

    Opt = OpenFigure(Opt);

    MAX = GetAbsMax(Data);
    CLIM = [-MAX MAX];

    subplot(1, 10, 1);
    Opt.Raster.Title = 'ROI 1 - Sorting condition';
    Opt.Raster.PlotRValue = false;
    Opt.Raster.AddRectangleXTickLabel =  false;
    PlotOneRaster(SortingData, Opt, [], CLIM);

    subplot(1, 10, 2:9);
    Opt.Raster.Title = 'ROI 1 - Sorted condition';
    Opt.Raster.AddRectangleXTickLabel =  true;
    Opt.Raster.PlotRValue = true;
    Opt.Raster.AddProfile = true;
    Opt.Raster.AddColorBar = true;
    PlotOneRaster(SortingData, Opt, Beta, CLIM);

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

    [Data, SortingData, Beta] = SortRaster(Data, SortingData, Opt, SortBy);

    Data = BinRaster(Data, NbBin);
    Data = SmoothRaster(Data, Opt);

    SortingData = BinRaster(SortingData, NbBin);
    SortingData = SmoothRaster(SortingData, Opt);

    %% Plot

    Opt.Title = 'Raster - One ROI - With Condition';

    Opt = OpenFigure(Opt);

    MAX = GetAbsMax(Data);
    CLIM = [-MAX MAX];

    subplot(121);
    Opt.Raster.Title = 'ROI 1 - Sorting condition';
    PlotOneRaster(SortingData, Opt, [], CLIM);

    subplot(122);
    Opt.Raster.Title = 'ROI 1 - Sorted condition';
    Opt.Raster.AddProfile = true;
    Opt.Raster.AddColorBar = true;
    PlotOneRaster(SortingData, Opt, Beta, CLIM);

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

    [Data, SortingData, Beta] = SortRaster(Data, SortingData, Opt, SortBy);

    Data = BinRaster(Data);
    Data = SmoothRaster(Data, Opt);

    SortingData = BinRaster(SortingData);
    SortingData = SmoothRaster(SortingData, Opt);

    %% Plot

    Opt.Title = 'Group Raster - One ROI - One Condition';

    Opt = OpenFigure(Opt);

    % let's take the median across vertices
    Profiles = median(Data, 1);
    Opt.Raster.Profiles = squeeze(Profiles)';

    % here we take the mean across subjects
    Data = mean(Data, 3);
    SortingData = mean(SortingData, 3);

    MAX = GetAbsMax(Data);
    CLIM = [-MAX MAX];

    subplot(1, 10, 1);
    Opt.Raster.Title = 'ROI 1 - Sorting condition';
    Opt.Raster.AddRectangleXTickLabel =  false;
    PlotOneRaster(SortingData, Opt, [], CLIM);

    subplot(1, 10, 2:9);
    Opt.Raster.Title = 'ROI 1 - Sorted condition';
    Opt.Raster.AddRectangleXTickLabel =  true;
    Opt.Raster.AddProfile = true;
    Opt.Raster.AddColorBar = true;
    PlotOneRaster(SortingData, Opt, Beta, CLIM);

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

    [Data, SortingData, Beta] = SortRaster(Data, SortingData, Opt, SortBy);

    Data = BinRaster(Data);
    Data = SmoothRaster(Data, Opt);

    SortingData = BinRaster(SortingData);
    SortingData = SmoothRaster(SortingData, Opt);

    %% Plot

    Opt.Title = 'Group Raster - One ROI - 2 Conditions';

    Opt = OpenFigure(Opt);

    % get profile for each subject and condition
    Profiles = median(Data, 1);
    Opt.Raster.Profiles = squeeze(Profiles)';
    SortingData = mean(SortingData, 3);

    % get maximum for average raster
    Data = mean(Data, 3);
    MAX = GetAbsMax(Data);
    CLIM = [-MAX MAX];

    subplot(1, 10, 1);
    Opt.Raster.Title = 'ROI 1 - Sorting condition';
    Opt.Raster.AddRectangleXTickLabel =  false;
    PlotOneRaster(SortingData, Opt, [], CLIM);

    subplot(1, 10, 2:9);
    Opt.Raster.Title = 'ROI 1 - Sorted condition';
    Opt.Raster.AddRectangleXTickLabel =  true;
    Opt.Raster.AddProfile = true;
    Opt.Raster.AddColorBar = true;
    PlotOneRaster(SortingData, Opt, Beta, CLIM);

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
            Titles{ROI, Cdt} = sprintf('Condition: %i, %i', ROI, Cdt);

        end
    end

    SortingData = Data{1, 1};

    %% Sort and bin data

    SortBy = 'Cst';

    Opt = SetRasterPlotParameters(Opt);

    [Data, SortingData, Beta] = PrepareRasterData(Data, SortingData, Opt, SortBy);

    Opt.Title = 'Group Raster - 2 X 2 Conditions';

    PlotSeveralRasters(Opt, Data, SortingData, Titles, Beta);

end

function Group2By2DifferentRois(Opt)
    %
    % just as an example of how to plot several conditions
    % sorted by the same one
    %

    %% Generate data
    %
    % let's pretend that they are 4 different conditions

    Opt = GenerateNumberVertexForSubject(Opt);

    for ROI = 1:2

        Opt.NbVerticesRange = [1000 2000] * ROI;

        for Cdt = 1:2

            Opt = SetParametersProfileSimulation(Opt, ROI, Cdt);
            Data{Cdt, ROI} = GenerateGroupSurfaceDataRaster(Opt);
            SortingData{Cdt, ROI} = Data{Cdt, ROI};
            Titles{Cdt, ROI} = sprintf('Condition: %i, %i', ROI, Cdt);

        end
    end

    %% Sort and bin data

    SortBy = 'Cst';

    Opt = SetRasterPlotParameters(Opt);

    [Data, SortingData, Beta] = PrepareRasterData(Data, SortingData, Opt, SortBy);

    Opt.Title = 'Group Raster - 2 X 2 Conditions';

    PlotSeveralRasters(Opt, Data, SortingData, Titles, Beta);

end
