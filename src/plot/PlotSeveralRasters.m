% (C) Copyright 2021 Remi Gau

function PlotSeveralRasters(Opt, Data, SortingData, Titles, CLIM)

    switch Opt.AverageType
        case 'median'
            Profiles = cellfun(@(x) squeeze(median(x, 1))', Data, 'UniformOutput', false);
        case 'mean'
            Profiles = cellfun(@(x) squeeze(mean(x, 1))', Data, 'UniformOutput', false);
    end
    
    if ~isfield(Opt.Specific{1}, 'Group')
        Min = cellfun(@(x) min(x(:)), Profiles);
        Opt.Specific{1}.Group.Min = min(Min(:));
        Max = cellfun(@(x) max(x(:)), Profiles);
        Opt.Specific{1}.Group.Max = max(Max(:));
    end
    
    Rasters = cellfun(@(x) mean(x, 3), Data, 'UniformOutput', false);
    SortingRaster = mean(SortingData, 3);

    if nargin < 5 || isempty(CLIM)
        MAX = GetAbsMax(Rasters);
        CLIM = [-MAX MAX];
    end

    Opt.m = size(Rasters, 2);
    Opt.n = size(Rasters, 1);

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

            PlotOneRaster(Rasters{iRow, iCol}, Opt, CLIM);

            SubplotCounter = SubplotCounter + 1;

        end
    end

end
