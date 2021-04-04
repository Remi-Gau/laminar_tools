function Clim = ComputeClimMatrix(Data, SymmetricalClim)
    %
    % Returns the mininum and maximum from an array or a cell of arrays
    % The range covered will always include 0;
    %
    % If SymmetricalClim is true() then the ran will be centerd on O;
    %

    if nargin < 2 || isempty(SymmetricalClim)
        SymmetricalClim = true;
    end
    
    if SymmetricalClim
        Max = GetAbsMax(Data);
        Clim = [-Max, Max];
        return
    end

    if iscell(Data)
        Min = cellfun(@(x) min(x(:)), Data);
        Max = cellfun(@(x) max(x(:)), Data);
    else
        Min = Data(:);
        Max = Data(:);
    end
    
    Min = min(Min(:));
    Max = max(Max(:));

    if Min > 0
        Min = 0;
    end
    if Max < 0
        Max = 0;
    end

    Clim = [Min, Max];

end
