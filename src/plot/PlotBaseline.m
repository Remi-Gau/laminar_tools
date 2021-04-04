% (C) Copyright 2021 Remi Gau

function IsMvpa = PlotBaseline(Opt, iColumn)

    Baseline = [0, 0];

    IsMvpa = false;
    if isfield(Opt.Specific{1, iColumn}, 'IsMvpa')
        IsMvpa = Opt.Specific{1, iColumn}.IsMvpa;
    end

    if IsMvpa
        Baseline = [0.5, 0.5];
    end
    plot([0, Opt.NbLayers + 1], Baseline, '-k', 'LineWidth', 1);

end
