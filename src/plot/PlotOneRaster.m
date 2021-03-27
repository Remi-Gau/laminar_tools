% (C) Copyright 2020 Remi Gau

function PlotOneRaster(Data, Opt, CLIM)

    if nargin < 3
        CLIM = [min(Data(:)) max(Data(:))];
    end
    
    DephLevels = round(linspace(100, 0, 8));
    DephLevels([1; end]) = [];

    Data = imgaussfilt(Data,  [size(Data, 1) * Opt.Raster.VerticalFWHM  .001]);
    
    imagesc(flipud(Data), CLIM);

    axis([0.5 Opt.NbLayers + .5 0 size(Data, 1)]);

    t = title(Opt.Title);
    set(t, 'fontsize', Opt.Fontsize);

    set(gca, ...
        'color', 'none', ...
        'tickdir','out', ...
        'xtick', 1:Opt.NbLayers, ...
        'xticklabel',  DephLevels, ...
        'ytick', [], ...
        'yticklabel', [], ...
        'ticklength', [0.01 0], ...
        'fontsize', Opt.Fontsize);

end
