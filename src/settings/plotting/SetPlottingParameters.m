% (C) Copyright 2021 Remi Gau

function  [NbLayers, AverageType, Opt] = SetPlottingParameters(Opt)

    Opt = SetDefaultFields(Opt, GetPlottingDefaults());

    if Opt.PerformDeconvolution
        Opt.Title = [Opt.Title ' - deconvolved'];
    end

    NbLayers =  Opt.NbLayers;
    AverageType =  Opt.AverageType;

end

function PlottingDefaults = GetPlottingDefaults()

    PlottingDefaults.NbLayers = 6;

    % average across vertices / voxels
    PlottingDefaults.AverageType = 'median';

    PlottingDefaults.Fontsize = 10;
    PlottingDefaults.Visible = 'on';

    PlottingDefaults.ErrorBarType = 'SEM';

    PlottingDefaults.Alpha = 0.05 / 4;

    PlottingDefaults.FigDim = [50, 50, 600, 600];

    PlottingDefaults.Title = '';

    PlottingDefaults.PerformDeconvolution = false;

end
