% (C) Copyright 2021 Remi Gau

function  [NbLayers, AverageType, Opt] = GetPlottingDefaults(Opt)

    NbLayers = 6;

    % average across vertices / voxels
    AverageType = 'median';

    Opt.NbLayers = NbLayers;
    Opt.AverageType = AverageType;

    Opt.Fontsize = 10;
    Opt.Visible = 'on';

    if ~isfield(Opt, 'Title')
        Opt.Title = '';
    end

    if ~isfield(Opt, 'PerformDeconvolution')
        Opt.PerformDeconvolution = false;
    end

    if Opt.PerformDeconvolution
        Opt.Title = [Opt.Title ' - deconvolved'];
    end
end
