% (C) Copyright 2021 Remi Gau

function  Opt = SetPlottingParameters(Opt)

    if nargin < 1 || isempty(Opt)
        Opt = SetDefaults(Opt);
    else
        Opt = SetDefaultFields(Opt, SetDefaults());
    end

    Opt = SetDefaultFields(Opt, GetPlottingDefaults());

    if Opt.PerformDeconvolution
        Opt.Title = [Opt.Title ' - deconvolved'];
    end
    
    if Opt.PoolIpsiContra
        Opt.Title = [Opt.Title ' pooled'];
    end

end

function PlottingDefaults = GetPlottingDefaults()

    PlottingDefaults.Fontsize = 10;
    PlottingDefaults.Visible = 'on';

    PlottingDefaults.ErrorBarType = 'SEM';

    PlottingDefaults.Alpha = 0.05 / 4;

    PlottingDefaults.FigDim = [50, 50, 600, 600];

    PlottingDefaults.Title = '';

end
