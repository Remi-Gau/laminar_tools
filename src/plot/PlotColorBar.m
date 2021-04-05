% (C) Copyright 2021 Remi Gau

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

        NbTicks = 5;
        yTick = linspace(1, numel(ColorScale), NbTicks);
        yTickLabel = linspace(CLIM(2), CLIM(1), NbTicks);
        yTickLabel = round(yTickLabel, 1);

        set(gca, ...
            'tickdir', 'out', ...
            'xtick', [], ...
            'xticklabel',  [], ...
            'ytick', yTick, ...
            'yticklabel', yTickLabel, ...
            'ticklength', [0.01 0.01], ...
            'fontsize', 8, ...
            'YAxisLocation', 'right');

        box off;

    end
end
