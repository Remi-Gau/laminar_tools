% (C) Copyright 2021 Remi Gau

function Data = BinRaster(Data, NbBin)

    if nargin < 2
        if iscell(Data)
            NbBin = min(cellfun('size', Data, 1));
        else
            NbBin = size(Data, 1) / 10;
        end
    end

    % If we are dealing with "group" data
    % we make loop through each subject
    % and bin with a recursive to BinRaster
    if iscell(Data)

        for iSub = 1:size(Data, 1)
            tmp(:, :, iSub) = BinRaster(Data{iSub}, NbBin); %#ok<*AGROW>
        end

        Data = tmp;

        return

    end

    if NbBin > size(Data, 1)
        error('The number of bins must be superior to the number of vertices');
    elseif NbBin == size(Data, 1)
        return
    end

    IdxToAvg = floor(linspace(1, size(Data, 1), NbBin + 1));

    tmp = [];

    for iBin = 2:numel(IdxToAvg)
        tmp(iBin - 1, :) = mean(Data(IdxToAvg((iBin - 1):iBin), :));
    end

    Data = tmp;

end
