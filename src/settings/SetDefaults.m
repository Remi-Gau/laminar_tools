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

    Defaults.PerformDeconvolution = false;

    Defaults.PlotQuadratic = false;

    % make sure that conditions are organized as ipsi and contra
    % not as left and right
    Defaults.ReassignIpsiContra = true;

    Defaults.PoolIpsiContra = false;
    
    Defaults.CombineHemisphere = false;

    Defaults.Targets = false;

end
