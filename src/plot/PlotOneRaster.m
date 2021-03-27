% (C) Copyright 2020 Remi Gau

function PlotOneRaster(Data, Opt, CLIM)

    Data = imgaussfilt(Data,  [size(Data, 1) * Opt.Raster.VerticalFWHM  .001]);

    if nargin < 3
        % use symmetrical scale by default
        MAX = max(abs(Data(:)));
        CLIM = [-MAX MAX];
    end

    imagesc(flipud(Data), CLIM);

    axis([0.5 Opt.NbLayers + .5 0 size(Data, 1)]);

    t = title(Opt.Title);
    set(t, 'fontsize', Opt.Fontsize);

    if Opt.Raster.AddXLabel
        t = xlabel('cortical depth');
        set(t, 'fontsize', Opt.Fontsize);
    end

    DephLevels = round(linspace(100, 0, 8));
    DephLevels([1; end]) = [];

    set(gca, ...
        'color', 'none', ...
        'tickdir', 'out', ...
        'xtick', 1:Opt.NbLayers, ...
        'xticklabel',  DephLevels, ...
        'ytick', [], ...
        'yticklabel', [], ...
        'ticklength', [0.01 0], ...
        'fontsize', Opt.Fontsize);

    PlotColorBar(Opt, CLIM);

end
