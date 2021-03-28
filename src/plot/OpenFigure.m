% (C) Copyright 2021 Remi Gau

function OpenFigure(Opt)

    figure('Name', Opt.Title, ...
           'Position', Opt.FigDim);

    SetFigureDefaults(Opt);

end
