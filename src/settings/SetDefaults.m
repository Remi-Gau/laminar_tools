function Opt = SetDefaults(Opt)

    if nargin < 1 || isempty(Opt)
        Opt = GetDefaults();
    else
        Opt = SetDefaultFields(Opt, GetDefaults());
    end

end

function Defaults = GetDefaults()

    Defaults.NbLayers = 6;

    % average across vertices / voxels
    Defaults.AverageType = 'median';

    Defaults.PerformDeconvolution = true;

end
