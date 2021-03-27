% (C) Copyright 2021 Remi Gau

function  [NbLayers, AverageType, Opt] = GetPlottingDefaults(Opt)
    
    Opt.NbLayers = 6;
    
     % average across vertices / voxels
    Opt.AverageType = 'median';

    Opt.Fontsize = 10;
    Opt.Visible = 'on';

    Opt.ErrorBarType = 'SEM';
    
    Opt.Alpha = 0.05 / 4;

    Opt.FigDim = [50, 50, 600, 600];

    if ~isfield(Opt, 'Title')
        Opt.Title = '';
    end

    if ~isfield(Opt, 'PerformDeconvolution')
        Opt.PerformDeconvolution = false;
    end

    if Opt.PerformDeconvolution
        Opt.Title = [Opt.Title ' - deconvolved'];
    end

    NbLayers =  Opt.NbLayers;
    AverageType =  Opt.AverageType ;
    
end
