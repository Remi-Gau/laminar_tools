function Opt = SetDefaults(Opt)

    if nargin < 1 || isempty(Opt)
        Opt = GetDefaults();
    else
        Opt = SetDefaultFields(Opt, GetDefaults());
    end

end

function Defaults = GetDefaults()

    Defaults.NbLayers = 6;

    % central tendency estimator across vertices / voxels
    Defaults.AverageType = 'median';

    Defaults.PerformDeconvolution = true;

    Defaults.PoolIpsiContra = true;

    Defaults.PlotTargets = false;

end
