% (C) Copyright 2021 Remi Gau

function  Opt = SetRasterPlotParameters(Opt)

    [~, ~, Opt] = SetPlottingParameters(Opt);

    Opt.Specific{1, 1}.LineColors = 'k';
    Opt = SetProfilePlotParameters(Opt);

    Opt = SetDefaultFields(Opt, GetRasterDefaults());

    Opt.FigDim = [50, 50, 1200, 600];
    Opt.ErrorBarType = 'STD';

end

function RasterDefaults = GetRasterDefaults()

    % FWHM for smotthing "across vertices"
    % proportion of tne number of vertices
    RasterDefaults.Raster.VerticalFWHM = 1 / 1000;

    RasterDefaults.Raster.ColorMap = SeismicColorMap(1000);

    RasterDefaults.Raster.Sort = true;
    RasterDefaults.Raster.CrossValidate = true;

    RasterDefaults.Raster.AddProfile = false;

    RasterDefaults.Raster.AddColorBar = false;

    RasterDefaults.Raster.AddXLabel = false;
    RasterDefaults.Raster.AddXTickLabel = false;
    
    RasterDefaults.Raster.AddRectangleXTickLabel = true;

end
