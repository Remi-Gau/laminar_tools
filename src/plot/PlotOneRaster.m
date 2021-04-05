% (C) Copyright 2020 Remi Gau

function PlotOneRaster(Data, Opt, R, CLIM)

    set(gca, 'xtick', [], 'ytick', []);

    ax = gca;
    PlotRectangle(Opt, false, Opt.Raster.AddRectangleXTickLabel);
    axes('Position', ax.Position);

    if nargin < 4
        % use symmetrical scale by default
        MAX = GetAbsMax(Data);
        CLIM = [-MAX MAX];
    end

    imagesc(flipud(Data), CLIM);

    colormap(Opt.Raster.ColorMap);

    axis([0.5 Opt.NbLayers + .5 0 size(Data, 1)]);

    t = title(Opt.Raster.Title);
    set(t, 'fontsize', Opt.Fontsize);

    AddXLabel(Opt);

    [XTick, XTickLabel] = GetXTickLabel(Opt);

    set(gca, ...
        'color', 'none', ...
        'tickdir', 'out', ...
        'xtick', XTick, ...
        'xticklabel',  XTickLabel, ...
        'ytick', [], ...
        'yticklabel', [], ...
        'ticklength', [0.01 0], ...
        'fontsize', Opt.Fontsize);

    if nargin < 3
        R = [];
    end
    PrintR(R, Opt);

    AddProfileToRaster(Data, Opt);

    PlotColorBar(Opt, CLIM);

end

function AddXLabel(Opt)
    if Opt.Raster.AddXLabel
        t = xlabel('cortical depth');
        set(t, 'fontsize', Opt.Fontsize);
    end
end

function [XTick, XTickLabel] = GetXTickLabel(Opt)

    XTick = [];
    XTickLabel = [];

    if ~Opt.Raster.AddXTickLabel
        return

    else

        XTick = 1:Opt.NbLayers;

        XTickLabel = round(linspace(100, 0, 8));
        XTickLabel([1; end]) = [];

    end

end

function AddProfileToRaster(Data, Opt)

    if Opt.Raster.AddProfile

        ax = gca;
        axes('Position', ax.Position);

        hold on;

        PlotBaseline(Opt, 1);

        if isfield(Opt.Raster, 'Profiles')
            % liekly we are dealing with between subject data
            Data = Opt.Raster.Profiles;
            CentralTendency = mean(Data);

            if ~isfield(Opt.Specific{1}, 'Group')
                Opt.Specific{1}.Group.Min = min(Data(:));
                Opt.Specific{1}.Group.Max = max(Data(:));
            end

        else
            % In this case we are plotting the profile of the raster
            % of a single subject
            switch Opt.AverageType
                case 'median'
                    CentralTendency = median(Data);
                case 'mean'
                    CentralTendency = mean(Data);
            end
        end

        [LowerError, UpperError] = ComputeDispersionIndex(Data, Opt);

        xOffset = -0.5;
        iLine = 1;

        % This is ugly and could probably be improved
        % plus it assumes all profiles for a raster should have same properties
        Opt.Specific{1}.ProfileLine.LineWidth = Opt.Raster.Profile.LineWidth;
        Opt.Specific{1}.ProfileLine.MarkerSize = Opt.Raster.Profile.MarkerSize;

        PlotMainProfile(CentralTendency, LowerError, UpperError, Opt, xOffset, iLine);
        set(gca, ...
            'color', 'none', ...
            'YAxisLocation', 'right', ...
            'xTick', []);

        % To center on graph layer below.
        % And any eventual set range
        ax = axis;

        Min = ax(3);
        Max = ax(4);
        if isfield(Opt.Specific{1}, 'Group')
            [Min, Max] = ComputeMargin(Opt.Specific{1}.Group.Min, ...
                                       Opt.Specific{1}.Group.Max);
        end

        axis(gca, [0, Opt.NbLayers, Min, Max]);

    end

end
