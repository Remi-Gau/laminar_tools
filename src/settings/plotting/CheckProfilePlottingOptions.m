% (C) Copyright 2021 Remi Gau

function Opt = CheckProfilePlottingOptions(Opt)

    % define subplot grid
    if ~isfield(Opt, 'm')
        Opt.m = size(Opt.Specific, 2);
    end

    if Opt.PlotQuadratic
        Opt.n = Opt.n + 1;
    end
    Opt.n = Opt.n + 1;

    switch Opt.m
        case 1
            Opt.FigDim = [50, 50, 600, 1000];
        case 2
            Opt.FigDim = [50, 50, 1200, 1000];
        case 3
            Opt.FigDim = [50, 50, 1800, 1000];
    end

    if Opt.n >= 5
        Opt.FigDim(4) = 1600;
    end

    if Opt.PermutationTest.Do
        Opt.PermutationTest = CreatePermutationList(Opt.PermutationTest);
    end

    if contains(Opt.ErrorBarType, 'CI')
        Opt.ShadedErrorBar = false;
    end

    for i = 1:Opt.m

        Opt.Specific{i}.NbLines = prod([ ...
                                        numel(unique(Opt.Specific{i}.ConditionVec)); ...
                                        numel(unique(Opt.Specific{i}.RoiVec))]);

        if Opt.Specific{i}.NbLines > 1
            Opt.ShadedErrorBar = false;
            Opt.Specific{i}.PlotSubjects = false;
        end

    end

end
