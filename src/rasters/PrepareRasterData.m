% (C) Copyright 2021 Remi Gau

function [Data, SortingData, R] = PrepareRasterData(Data, SortingData, Opt, SortBy)
    
    fprintf('  Sorting and binning\n');
    
    for i = 1:size(Data,1)
        for j = 1:size(Data,2)
        
        [Data{i, j}, ~, R{i, j}] = SortRaster(Data{i, j}, ...
            SortingData, ...
            Opt, ...
            SortBy);
        Data{i, j} = BinRaster(Data{i, j});
        Data{i, j} = SmoothRaster(Data{i, j}, Opt);
        
        end
    end
    
    [SortingData] = SortRaster(SortingData, SortingData, Opt, SortBy);
    SortingData = BinRaster(SortingData);
    SortingData = SmoothRaster(SortingData, Opt);
    
end