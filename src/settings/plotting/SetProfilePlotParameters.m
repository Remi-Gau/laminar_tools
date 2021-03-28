% (C) Copyright 2021 Remi Gau

function Opt = SetProfilePlotParameters(Opt)

    [~, ~, Opt] = SetPlottingParameters(Opt);

    Opt = SetDefaultFields(Opt, GetProfilePlotDefaults());

    for i = 1:size(Opt.Specific, 2)

        Opt.Specific{1, i} = SetDefaultFields(Opt.Specific{1, i}, ...
                                              GetSpecificDefaults());

    end

    if isfield(Opt, 'IsDifferencePlot') && Opt.IsDifferencePlot
        Opt.m = 2;
        Opt.n = 10;

        Opt.Specific{1, 1}.ProfileSubplot = 1:6;
        Opt.Specific{1, 1}.BetaSubplot = {[15 17]; [19 21]; [23 25]};

        Opt.Specific{1, 2}.ProfileSubplot = 7:12;
        Opt.Specific{1, 2}.BetaSubplot = {[16 18]; [20 22]; [24 26]};
        Opt.Specific{1, 2}.LineColors = [127 127 127] / 256;

        Opt.Specific{1, 2}.PlotMinMaxType = 'all';
    end

    Opt = CheckProfilePlottingOptions(Opt);

end

function ProfilePlotDefaults = GetProfilePlotDefaults()

    ProfilePlotDefaults.PlotPValue = true;
    ProfilePlotDefaults.PermutationTest.Do = false;
    ProfilePlotDefaults.PermutationTest.Plot = false;

    ProfilePlotDefaults.PlotQuadratic = false;

    ProfilePlotDefaults.PerformDeconvolution = true;

    ProfilePlotDefaults.ShadedErrorBar = false;

    ProfilePlotDefaults.n = 3;

end

function SpecificDefaults = GetSpecificDefaults()

    SpecificDefaults.IsMvpa = false;
    SpecificDefaults.Ttest.SideOfTtest = 'both';
    SpecificDefaults.PlotSubjects = true;

    % all group groupallcolumns
    SpecificDefaults.PlotMinMaxType = 'group';

    SpecificDefaults.ConditionVec = 1;
    SpecificDefaults.RoiVec = 1;
end
