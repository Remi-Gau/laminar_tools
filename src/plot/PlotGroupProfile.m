% (C) Copyright 2020 Remi Gau

function  PlotGroupProfile(Opt, iColumn)

    if nargin < 2 || isempty(iColumn)
        iColumn = 1;
    end

    ThisSubplot = GetSubplotIndices(Opt, iColumn);

    subplot(Opt.n, Opt.m, ThisSubplot);
    PlotRectangle(Opt, true);

    subplot(Opt.n, Opt.m, ThisSubplot);

    hold on;
    grid off;

    IsMvpa = PlotBaseline(Opt, iColumn);

    RoiVec = Opt.Specific{1, iColumn}.Group.RoiVec;
    ConditionVec = Opt.Specific{1, iColumn}.Group.ConditionVec;

    RoiList = unique(RoiVec);
    CdtList = unique(ConditionVec);

    iLine = 1;

    for iRoi = 1:numel(RoiList)

        for iCdt = 1:numel(CdtList)

            Criteria = {
                        RoiVec, RoiList(iRoi); ...
                        ConditionVec, CdtList(iCdt)};
            RowsToSelect = ReturnRowsToSelect(Criteria);

            Data = Opt.Specific{1, iColumn}.Group.Data(RowsToSelect, :);

            PlotProfileSubjects(Data, Opt.NbLayers, Opt.Specific{1, iColumn}.PlotSubjects);

            GroupMean = mean(Data);
            [LowerError, UpperError] = ComputeDispersionIndex(Data, Opt);

            xOffset = (iLine - 1) * 0.1;
            PlotMainProfile(GroupMean, LowerError, UpperError, Opt, xOffset, iColumn, iLine);

            iLine = iLine + 1;

        end
    end

    %% Set tighet axes with margin
    [Min, Max] = ComputeMargin(Opt.Specific{1, iColumn}.Group.Min, ...
                               Opt.Specific{1, iColumn}.Group.Max);

    axis(gca, [0.5, Opt.NbLayers + .5, Min, Max]);

    %% Labels and titles
    set(gca, ...
        'tickdir', 'out', ...
        'xtick', [0 Opt.NbLayers], ...
        'xticklabel', ' ', ...
        'ticklength', [0.01 0.1], ...
        'xgrid', 'off', ...
        'ygrid', 'off', ...
        'fontsize', Opt.Fontsize);

    %     XLabel = 'Cortical depth';
    %     t = xlabel(XLabel);
    %     set(t, ...
    %         'fontweight', 'bold', ...
    %         'fontsize', Opt.Fontsize);

    YLabel = 'B Param. est. [a u]';
    if IsMvpa
        YLabel = 'Decoding accuracy';
    end
    t = ylabel(YLabel);
    set(t, ...
        'fontweight', 'bold', ...
        'fontsize', Opt.Fontsize);

    Title = Opt.Specific{1, iColumn}.Titles;
    t = title(Title);
    set(t, 'fontsize', Opt.Fontsize + 2);

end

function PlotProfileSubjects(GroupMean, NbLayers, PlotSubjects)

    if PlotSubjects

        % TODO
        % plot each subject with its own color
        % COLOR_SUBJECTS = SubjectColours();

        for SubjInd = 1:size(GroupMean, 1)
            plot( ...
                 1:NbLayers, ...
                 GroupMean(SubjInd, :), '-', ...
                 'LineWidth', 1, ...
                 'Color', [0.7, 0.7, 0.7]);
        end

    end

end

function ThisSubplot = GetSubplotIndices(Opt, iColumn)
    %
    % returns subplot on which to draw the lainar profile depending on the
    % number of columns in the figure
    %

    if isfield(Opt.Specific{1, iColumn}, 'ProfileSubplot')
        ThisSubplot = Opt.Specific{1, iColumn}.ProfileSubplot;
        return
    end

    switch Opt.m

        case 1
            ThisSubplot = 1:2;

        case 2

            switch iColumn
                case 1
                    ThisSubplot = [1 3];

                case 2
                    ThisSubplot = [2 4];
            end

        case 3

            switch iColumn
                case 1
                    ThisSubplot = [1 4];

                case 2
                    ThisSubplot = [2 5];

                case 3
                    ThisSubplot = [3 6];
            end

    end

end
