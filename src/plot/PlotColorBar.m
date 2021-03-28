% (C) Copyright 2020 Remi Gau

function PlotColorBar(Opt, CLIM)

    if Opt.Raster.AddColorBar

        ColorScale = CLIM(2):-.01:CLIM(1);

        ax = gca;
        axPos = ax.Position;
        axPos(1) = axPos(1) + axPos(3) + .04;
        axPos(3) = .015;
        axes('Position', axPos);

        colormap(Opt.Raster.ColorMap);

        imagesc(repmat(ColorScale', ...
                       [1, 200]), ...
                CLIM);

        yTick = linspace(1, numel(ColorScale), 5);

        set(gca, ...
            'tickdir', 'out', ...
            'xtick', [], ...
            'xticklabel',  [], ...
            'ytick', yTick, ...
            'yticklabel', round(10 * linspace(CLIM(2), CLIM(1), 5)) / 10, ...
            'ticklength', [0.01 0.01], ...
            'fontsize', 8, ...
            'YAxisLocation', 'right');

        box off;

    end
end
