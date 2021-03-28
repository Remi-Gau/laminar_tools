% (C) Copyright 2021 Remi Gau

function Data = BinRaster(Data, NbBin)

    if nargin < 2
        NbBin = size(Data, 1) / 10;
    end

    IdxToAvg = floor(linspace(1, size(Data, 1), NbBin + 1));
    
    tmp = [];
    
    for iBin = 2:numel(IdxToAvg)
        tmp(iBin - 1, :) = mean(Data(IdxToAvg((iBin - 1):iBin), :));
    end
    
    Data = tmp;

end
