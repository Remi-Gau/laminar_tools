% (C) Copyright 2021 Remi Gau

function Opt = OpenFigure(Opt)

    Opt = SetFigureTitle(Opt);

    figure('Name', Opt.Title, ...
           'Position', Opt.FigDim);

    SetFigureDefaults(Opt);

end
