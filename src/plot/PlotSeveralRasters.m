% (C) Copyright 2021 Remi Gau

function PlotSeveralRasters(Opt, Data, SortingData, Titles, R, CLIM)

    switch Opt.AverageType
        case 'median'
            Profiles = cellfun(@(x) squeeze(median(x, 1))', Data, 'UniformOutput', false);
        case 'mean'
            Profiles = cellfun(@(x) squeeze(mean(x, 1))', Data, 'UniformOutput', false);
    end
    
    Rasters = cellfun(@(x) mean(x, 3), Data, 'UniformOutput', false);
    SortingRaster = mean(SortingData, 3);

    if nargin < 6 || isempty(CLIM)
        CLIM = ComputeClimMatrix(Rasters, false());
        Opt.Raster.ColorMap = NonCenteredDivergingColorMap(Rasters, Opt.Raster.ColorMap);
    end
 
    if ~isfield(Opt.Specific{1}, 'Group')
        Clim = ComputeClimMatrix(Profiles, false());
        Opt.Specific{1}.Group.Min = Clim(1);
        Opt.Specific{1}.Group.Max = Clim(2);
    end

    Opt.m = size(Rasters, 2);
    Opt.n = size(Rasters, 1);
    
    Opt.FigDim = [50, 50, 50 + Opt.m * 400, 50 + Opt.n * 400];

    figure('name', Opt.Title, 'position', Opt.FigDim);

    SetFigureDefaults(Opt);

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
            Opt.Raster.Title = Titles{iRow, iCol};

            Opt.Raster.AddProfile = true;

            if nargin < 5
                r = [];
            else
                r = R{iRow, iCol};
            end
            
            PlotOneRaster(Rasters{iRow, iCol}, Opt, r, CLIM);

            SubplotCounter = SubplotCounter + 1;

        end
    end

    mtit(Opt.Title, ...
        'fontsize', Opt.Fontsize + 4, ...
        'xoff', 0, ...
        'yoff', .05);
    
end
