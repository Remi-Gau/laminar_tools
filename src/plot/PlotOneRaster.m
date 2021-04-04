% (C) Copyright 2020 Remi Gau

function PlotOneRaster(Data, Opt, CLIM)

    set(gca, 'xtick', [], 'ytick', []);

    ax = gca;
    PlotRectangle(Opt, false, Opt.Raster.AddRectangleXTickLabel);
    axes('Position', ax.Position);

    Data = imgaussfilt(Data,  [size(Data, 1) * Opt.Raster.VerticalFWHM  .001]);

    if nargin < 3
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
            Data = Opt.Raster.Profiles;
        end

        GroupMean = mean(Data);
        [LowerError, UpperError] = ComputeDispersionIndex(Data, Opt);

        xOffset = -0.5;
        iLine = 1;
        
        Opt.Specific{1}.ProfileLine.LineWidth = Opt.Raster.Profile.LineWidth;
        Opt.Specific{1}.ProfileLine.MarkerSize = Opt.Raster.Profile.MarkerSize;
        
        PlotMainProfile(GroupMean, LowerError, UpperError, Opt, xOffset, iLine);
        set(gca, ...
            'color', 'none', ...
            'YAxisLocation', 'right', ...
            'xTick', []);

        % to center on graph layer below.
        ax = axis;
        axis(gca, [0, Opt.NbLayers, ax(3), ax(4)]);

    end

end
