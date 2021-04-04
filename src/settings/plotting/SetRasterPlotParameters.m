% (C) Copyright 2021 Remi Gau

function  Opt = SetRasterPlotParameters(Opt)

    Opt = SetPlottingParameters(Opt);

    Opt.Specific{1, 1}.LineColors = 'k';
    Opt = SetProfilePlotParameters(Opt);

    Opt = SetDefaultFields(Opt, GetRasterDefaults());

    Opt.FigDim = [50, 50, 1200, 600];
    Opt.ErrorBarType = 'STD';

end

function RasterDefaults = GetRasterDefaults()

    % FWHM for smotthing "across vertices"
    % proportion of tne number of vertices
    RasterDefaults.Raster.VerticalFWHM = 1 / 10000;

    % if we have CPP_SPM with as dependency
    % we use a clean blue to red color map
    % otherwise we go for a more flashy seismic colormap
    try
        color_map_folder = fullfile(fileparts(which('map_luminance')), '..', 'mat_maps');
        load(fullfile(color_map_folder, 'diverging_bwr_iso.mat'));
        RasterDefaults.Raster.ColorMap = diverging_bwr;
    catch
        RasterDefaults.Raster.ColorMap = SeismicColorMap(1000);
    end

    RasterDefaults.Raster.Sort = true;
    RasterDefaults.Raster.CrossValidate = true;

    RasterDefaults.Raster.AddProfile = false;
    RasterDefaults.Raster.Profile.LineWidth = 0.5;
    RasterDefaults.Raster.Profile.MarkerSize = 3;

    RasterDefaults.Raster.AddColorBar = false;

    RasterDefaults.Raster.AddXLabel = false;
    RasterDefaults.Raster.AddXTickLabel = false;

    RasterDefaults.Raster.AddRectangleXTickLabel = true;

end
