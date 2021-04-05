% (C) Copyright 2020 Remi Gau

function [NewColorMap] = NonCenteredDivergingColorMap(Data, ColorMap)
    %
    % Takes a diverging colormap and truncates it to remove useless values
    %

    MinMax = ComputeClimMatrix(Data, false());
    MIN = MinMax(1);
    MAX = MinMax(2);
    [AbsMax, Idx] = max(abs([MIN MAX]));
    Scale = linspace(-1 * AbsMax, AbsMax, size(ColorMap, 1))';

    if Idx == 2
        Idx = Scale < MIN;
    else
        Idx = Scale > MAX;

    end
    NewColorMap = ColorMap(~Idx, :);

end
