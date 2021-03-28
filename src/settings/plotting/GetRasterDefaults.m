% (C) Copyright 2021 Remi Gau

function  Opt = GetRasterDefaults(Opt)

    [~, ~, Opt] = GetPlottingDefaults(Opt);

    Opt.Specific{1, 1}.LineColors = 'k';
    Opt = SetProfilePlottingOptions(Opt);

    Opt.FigDim = [50, 50, 1200, 600];
    Opt.ErrorBarType = 'STD';

    % FWHM for smotthing "across vertices"
    % proportion of tne number of vertices
    Opt.Raster.VerticalFWHM = 1 / 500;

    Opt.Raster.ColorMap = SeismicColorMap(1000);

    Opt.Raster.Sort = true;
    Opt.Raster.CrossValidate = true;

    Opt.Raster.AddProfile = false;

    Opt.Raster.AddColorBar = false;

    Opt.Raster.AddXLabel = false;
    Opt.Raster.AddXTickLabel = false;

end
