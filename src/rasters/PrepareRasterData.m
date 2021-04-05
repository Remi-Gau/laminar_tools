% (C) Copyright 2021 Remi Gau

function [Data, SortingData, R] = PrepareRasterData(Data, SortingData, Opt, SortBy)

    fprintf(' Sorting and binning\n');

    if all(size(Data) == size(SortingData))

        for i = 1:size(Data, 1)
            for j = 1:size(Data, 2)

                [Data{i, j}, R{i, j}] = PreProcessRasterData(Data{i, j}, ...
                                                             SortingData{i, j}, ...
                                                             Opt, ...
                                                             SortBy);

                [SortingData{i, j}] = PreProcessRasterData(SortingData{i, j}, ...
                                                           SortingData{i, j}, ...
                                                           Opt, ...
                                                           SortBy);

            end
        end

    else

        for i = 1:size(Data, 1)
            for j = 1:size(Data, 2)

                [Data{i, j}, R{i, j}] = PreProcessRasterData(Data{i, j}, ...
                                                             SortingData, ...
                                                             Opt, ...
                                                             SortBy);

            end
        end

        SortingData = PreProcessRasterData(SortingData, ...
                                           SortingData, ...
                                           Opt, ...
                                           SortBy);

    end

end

function [ToSort, R] = PreProcessRasterData(ToSort, Sorting, Opt, SortBy)

    [ToSort, ~, R] = SortRaster(ToSort, Sorting, Opt, SortBy);
    ToSort = BinRaster(ToSort);
    ToSort = SmoothRaster(ToSort, Opt);

end
